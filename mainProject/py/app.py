from flask import Flask, jsonify, request
import oracledb
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import TfidfVectorizer
import logging

app = Flask(__name__)

# 캐시 비활성화
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0

# 로깅 설정
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Oracle Instant Client 경로 설정
oracledb.init_oracle_client(lib_dir="C:/Users/3calss_15/Downloads/instantclient_11_2")

# 오라클 DB 연결 설정
connection = oracledb.connect(user='mainproject', password='mainproject', dsn='localhost:1521/xe')

# SQL 쿼리로 데이터베이스에서 필요한 데이터 불러오기
def fetch_data(user_id):
    try:
        logging.info("전체 제품 데이터를 가져오는 중...")
        query = """
        SELECT p.product_id, p.product_name, p.category_id, p.brand, p.price
        FROM products p
        """
        products_df = pd.read_sql(query, con=connection)

        logging.info(f"사용자 {user_id}의 전체 주문 데이터를 가져오는 중...")
        query_orders = f"""
        SELECT oi.product_id, COUNT(oi.product_id) AS user_order_count
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.order_id
        WHERE o.user_id = {user_id}
        GROUP BY oi.product_id
        """
        user_orders_df = pd.read_sql(query_orders, con=connection)

        logging.info(f"사용자 {user_id}의 조회 내역 데이터를 가져오는 중...")
        query_user_views = f"""
        SELECT uv.product_id, COUNT(uv.product_id) AS user_view_count
        FROM user_views uv
        WHERE uv.user_id = {user_id}
        GROUP BY uv.product_id
        """
        user_views_df = pd.read_sql(query_user_views, con=connection)

        logging.info(f"사용자 {user_id}의 장바구니 내역 데이터를 가져오는 중...")
        query_cart = f"""
        SELECT ch.product_id, COUNT(ch.product_id) AS user_cart_count
        FROM cart_history ch
        WHERE ch.user_id = {user_id}
        GROUP BY ch.product_id
        """
        user_cart_df = pd.read_sql(query_cart, con=connection)

        return products_df, user_orders_df, user_views_df, user_cart_df
    except Exception as e:
        logging.error(f"데이터를 가져오는 중 오류 발생: {e}")
        return None, None, None, None

# 추천 제품 생성 함수
def preprocess_and_recommend(user_id):
    products_df, user_orders_df, user_views_df, user_cart_df = fetch_data(user_id)
    
    if products_df is None:
        return []

    logging.info(f"회원 {user_id}에 대한 추천 준비 중...")

    # 제품 속성 결합 (카테고리, 브랜드)
    products_df['combined_features'] = products_df['CATEGORY_ID'].astype(str) + ' ' + products_df['BRAND']
    logging.info(f"결합된 속성 데이터: {products_df[['PRODUCT_ID', 'combined_features']].head()}")

    # TF-IDF 벡터화
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(products_df['combined_features'])
    logging.info(f"TF-IDF 매트릭스 크기: {tfidf_matrix.shape}")

    # 코사인 유사도 계산
    cosine_sim = cosine_similarity(tfidf_matrix, tfidf_matrix)
    logging.info("코사인 유사도 계산 완료.")

    # 사용자의 행동 데이터를 products_df에 결합
    products_df = pd.merge(products_df, user_orders_df, on='PRODUCT_ID', how='left')
    products_df = pd.merge(products_df, user_views_df, on='PRODUCT_ID', how='left')
    products_df = pd.merge(products_df, user_cart_df, on='PRODUCT_ID', how='left')

    # 각 데이터가 없는 경우 0으로 채움
    products_df['USER_ORDER_COUNT'] = products_df['USER_ORDER_COUNT'].fillna(0)
    products_df['USER_VIEW_COUNT'] = products_df['USER_VIEW_COUNT'].fillna(0)
    products_df['USER_CART_COUNT'] = products_df['USER_CART_COUNT'].fillna(0)

    # 행동 데이터를 가중치로 반영한 추천 점수 계산
    max_order_count = products_df['USER_ORDER_COUNT'].max() if products_df['USER_ORDER_COUNT'].max() > 0 else 1
    max_view_count = products_df['USER_VIEW_COUNT'].max() if products_df['USER_VIEW_COUNT'].max() > 0 else 1
    max_cart_count = products_df['USER_CART_COUNT'].max() if products_df['USER_CART_COUNT'].max() > 0 else 1

    # 각 행동의 가중치를 설정 (주문 50%, 조회 30%, 장바구니 20%)
    products_df['weighted_score'] = cosine_sim.mean(axis=1) * (
        (0.1 * products_df['USER_ORDER_COUNT'] / max_order_count) +
        (0.5 * products_df['USER_VIEW_COUNT'] / max_view_count) +
        (0.7 * products_df['USER_CART_COUNT'] / max_cart_count)
    )
    logging.info(f"가중치 점수 계산 완료: {products_df[['PRODUCT_ID', 'weighted_score']]}")

    # 추천 제품 정렬
    recommended_products = products_df.sort_values(by='weighted_score', ascending=False).head(10)
    logging.info(f"추천된 제품 목록: {recommended_products[['PRODUCT_ID', 'PRODUCT_NAME', 'BRAND', 'PRICE', 'weighted_score']]}")

    return recommended_products['PRODUCT_ID'].tolist()

# 추천 API
# 추천 API에 캐싱 방지 헤더 추가
@app.route('/recommend', methods=['GET'])
def recommend():
    user_id = request.args.get('user_id')
    if user_id is None:
        return jsonify({'error': 'user_id is required'}), 400

    logging.info(f"Received user_id: {user_id}")  # user_id를 로그로 출력
    
    # 응답에 캐싱 방지 헤더 추가
    response = jsonify(preprocess_and_recommend(user_id))
    response.headers['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=0'
    return response

if __name__ == '__main__':
    app.run(debug=True, port=5001)
