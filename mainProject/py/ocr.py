from openai import OpenAI
import json
import requests
import uuid
import time
import pandas as pd
import oracledb  # Oracle DB와의 연결을 위한 라이브러리 추가
import sys

# 명령줄 인수로 이미지 경로 받기
if len(sys.argv) != 2:
    print("Usage: python ocr.py <image_file_path>")
    sys.exit(1)

image_file = sys.argv[1]


# API 요청 설정
api_url = 'https://qrzccj1y9c.apigw.ntruss.com/custom/v1/22243/60e2b8a7e366adc85128cffa9fb17254e9c8e9e4a73a7b6eac9c819a718987a3/general'
secret_key = 'ZkhvZFJGUXd2WFRkVWNrWExGc0RXbU9EaVRGYXZuRkc='

# OCR API 요청 데이터 생성
request_json = {
    'images': [
        {
            'format': 'jpg',
            'name': 'invoice'  
        }
    ],
    'requestId': str(uuid.uuid4()),
    'version': 'V2',
    'timestamp': int(round(time.time() * 1000))
}

payload = {'message': json.dumps(request_json).encode('UTF-8')}
files = [
    ('file', open(image_file, 'rb'))
]
headers = {
    'X-OCR-SECRET': secret_key
}

# API 요청 및 응답 처리
response = requests.request("POST", api_url, headers=headers, data=payload, files=files)
json_data = response.json()

# OCR 결과 문자열 생성
string_result = ''
for i in json_data['images'][0]['fields']:
    if i['lineBreak'] == True:
        linebreak = '\n'
    else:
        linebreak = ' '
    string_result = string_result + i['inferText'] + linebreak

print(string_result)

# JSON 파일로 저장
json_file_path = 'C:\\RPAWork\\workspace\\mainproject\\mainProject\\json\\json_file.json'
with open(json_file_path, 'w', encoding='utf-8') as file:
    json.dump(json_data, file, ensure_ascii=False, indent=4)

client = OpenAI()

# OpenAI API를 통한 정보 분석 요청
response = client.chat.completions.create(
    model="gpt-4o-mini",
    response_format={"type": "json_object"},
    messages=[
        {"role": "system", "content": "You are a helpful assistant to analyze the tracking number, receiver, sender, address, and memo from the invoice and output it in JSON format"},
        {"role": "user", "content": f'please analyze {string_result}. Extract only the tracking number, receiver, sender, address, and memo.'},
    ]
)
message = response.choices[0].message.content

print(message)

# 분석된 데이터 처리
data = json.loads(message)

tracking_number = data.get('tracking_number', 'N/A')
receiver = data.get('receiver', {})
sender = data.get('sender', {})
memo = data.get('memo', 'N/A')

receiver_name = receiver.get('name', 'N/A')
receiver_phone_numbers = ', '.join(receiver.get('phone_numbers', [])) if receiver.get('phone_numbers') else 'N/A'
receiver_address = receiver.get('address', 'N/A')

sender_name = sender.get('name', 'N/A')
sender_phone_number = sender.get('phone_number', 'N/A')
sender_address = sender.get('address', 'N/A')

# 메모 필드 처리: 리스트를 문자열로 변환
memo_str = '\n'.join(memo) if isinstance(memo, list) else memo

# 데이터프레임 생성
df = pd.DataFrame([{
    '운송번호': tracking_number,
    '받는분이름': receiver_name,
    '받는분휴대폰번호': receiver_phone_numbers,
    '받는분주소': receiver_address,
    '보내는분이름': sender_name,
    '보내는분휴대폰번호': sender_phone_number,
    '보내는분주소': sender_address,
    '메모': memo_str  # 메모를 문자열로 저장
}])
print("Dataframe created:", df)
oracledb.init_oracle_client(lib_dir="C:/Users/3calss_15/Downloads/instantclient_11_2")
# Oracle 데이터베이스에 연결 (oracledb 사용) 및 예외 처리 추가
dsn = oracledb.makedsn('localhost', 1521, service_name='xe')  # DSN 생성
try:
    connection = oracledb.connect(user='mainproject', password='mainproject', dsn=dsn)
    print("Oracle DB connection successful.")
except oracledb.DatabaseError as e:
    print(f"Error connecting to Oracle Database: {e}")

# 데이터베이스에 데이터 저장 함수
def save_to_db(df):
    cursor = connection.cursor()  # 커서 생성
    
    # 데이터프레임의 각 행을 반복하여 DB에 삽입
    for index, row in df.iterrows():
        cursor.execute('''
                INSERT INTO DELIVERY 
                (DELIVERY_NUMBER, RECEIVER, RECEIVER_PHONE, RECEIVER_ADDRESS, SENDER, SENDER_PHONE, SENDER_ADDRESS, MEMO)
                VALUES (:1, :2, :3, :4, :5, :6, :7, :8)
            ''', (row['운송번호'], row['받는분이름'], row['받는분휴대폰번호'], row['받는분주소'], 
                  row['보내는분이름'], row['보내는분휴대폰번호'], row['보내는분주소'], row['메모']))
        print(f"Inserted row: {row}")
    connection.commit()  # 변경 사항을 DB에 저장
    cursor.close()  # 커서 닫기

# DB에 저장 호출
save_to_db(df)

# 연결 종료
connection.close()  # DB 연결 종료