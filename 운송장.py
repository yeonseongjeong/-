from openai import OpenAI
import json
import requests
import uuid
import time
import pandas as pd

api_url = 'https://qrzccj1y9c.apigw.ntruss.com/custom/v1/22243/60e2b8a7e366adc85128cffa9fb17254e9c8e9e4a73a7b6eac9c819a718987a3/general'
secret_key = 'ZkhvZFJGUXd2WFRkVWNrWExGc0RXbU9EaVRGYXZuRkc='
image_file = '/Users/gimdonghun/Documents/data/운송장찐.jpg'

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
  ('file', open(image_file,'rb'))
]
headers = {
  'X-OCR-SECRET': secret_key
}

response = requests.request("POST", api_url, headers=headers, data = payload, files = files)
json_data = response.json()

string_result = ''
for i in json_data['images'][0]['fields']:
    if i['lineBreak'] == True:
        linebreak = '\n'
    else:
        linebreak = ' '
    string_result = string_result + i['inferText'] + linebreak

print(string_result)

json_file_path = '/Users/gimdonghun/Documents/data/json_file.json'
with open(json_file_path, 'w', encoding='utf-8') as file:
    json.dump(json_data, file, ensure_ascii=False, indent=4)

client = OpenAI()

response = client.chat.completions.create(
    model="gpt-4o-mini",
    response_format={"type": "json_object"},
    messages=[
    {"role": "system", "content": "You are a helpful assistant to analyze the tracking number, receiver, sender, address, and memo from the invoice and output it in JSON format"},
    {"role": "user", "content": f'please analyze {string_result}. Extract only the tracking number, receiver, sender, address, and memo.'},  # 필요한 정보만 추출 (전화번호 제외)
  ]
)
message = response.choices[0].message.content

print(message)

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

df = pd.DataFrame([{
    '운송번호': tracking_number,
    '받는분 이름': receiver_name,
    '받는분 휴대폰번호': receiver_phone_numbers,
    '받는분 주소': receiver_address,
    '보내는분 이름': sender_name,
    '보내는분 휴대폰번호': sender_phone_number,
    '보내는분 주소': sender_address,
    '메모': memo
}])

excel_file_path = '/Users/gimdonghun/Documents/data/delivery_info_with_columns.xlsx'
df.to_excel(excel_file_path, index=False)

print(f"엑셀 파일이 '{excel_file_path}'에 저장 되었습니다.")



"""
테이블

CREATE TABLE Delivery_Info (
    userId INT AUTO_INCREMENT PRIMARY KEY,
    운송번호 VARCHAR(50) NOT NULL,
    받는분_이름 VARCHAR(100) NOT NULL,  -- 받는분 이름
    받는분_휴대폰번호 VARCHAR(255) NOT NULL,
    받는분_주소 VARCHAR(255) NOT NULL,
    보내는분_이름 VARCHAR(100) NOT NULL, 
    보내는분_휴대폰번호 VARCHAR(50) NOT NULL,
    보내는분_주소 VARCHAR(255) NOT NULL,
    메모 TEXT 
);

"""