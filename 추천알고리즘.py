import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

# DB연결을 하지 않아서 예시 데이터를 생성하고 테스트 해보았습니다.
products = pd.DataFrame({
    'PRODUCT_ID': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
    'PRODUCT_NAME': ['로지텍G102', 'AULA F99 PRO', 'DELL UltraSharp U2723QE', 'Razer DeathAdder V2 Pro', 'MAXTILL MAXTILL TRON G10', '로지텍 코리아 G304 무선 마우스', '앱코 AN06F TKL PBT 게이밍 키보드', '체리 MX BOARD 3.0S WIRELESS RGB', '한성컴퓨터 TFG30F20W 울트라와이드', '삼성전자 커브드 C32R500 32인치'],
    'CATEGORY_ID': [1, 2, 3, 1, 1, 1, 2, 2, 3, 3]
})

cart_history = pd.DataFrame({
    'USER_ID': [1, 1, 2, 2, 3],
    'PRODUCT_ID': [1, 2, 3, 4, 5],
    'ACTION': ['ADD', 'ADD', 'ADD', 'REMOVE', 'ADD']
})

user_views = pd.DataFrame({
    'USER_ID': [1, 2, 3, 4, 5],
    'PRODUCT_ID': [1, 2, 3, 4, 5],
    'VIEWED_AT': pd.to_datetime(['2024-09-24', '2024-09-25', '2024-09-26', '2024-09-27', '2024-09-28'])
})

orders = pd.DataFrame({
    'ORDER_ID': [1001, 1002, 1003, 1004, 1005],
    'USER_ID': [1, 2, 3, 4, 5],
    'TOTAL_PRICE': [100, 150, 200, 250, 300]
})

order_items = pd.DataFrame({
    'ORDER_ITEM_ID': [1, 2, 3, 4, 5],
    'ORDER_ID': [1001, 1002, 1003, 1004, 1005],
    'PRODUCT_ID': [1, 2, 3, 4, 5],
    'QUANTITY': [1, 2, 1, 1, 1],
    'PRICE': [100, 150, 200, 250, 300]
})

def user_based_collaborative_filtering(user_id):
    user_product_matrix = pd.pivot_table(cart_history, values='ACTION', index='USER_ID', columns='PRODUCT_ID', aggfunc='count').fillna(0)
    user_similarity = cosine_similarity(user_product_matrix)
    user_sim_df = pd.DataFrame(user_similarity, index=user_product_matrix.index, columns=user_product_matrix.index)
    similar_user = user_sim_df.loc[user_id].idxmax()
    similar_user_products = cart_history[cart_history['USER_ID'] == similar_user]['PRODUCT_ID'].unique()
    user_products = cart_history[cart_history['USER_ID'] == user_id]['PRODUCT_ID'].unique()
    recommended_products = set(similar_user_products) - set(user_products)
    return products[products['PRODUCT_ID'].isin(recommended_products)]

def item_based_collaborative_filtering(product_id):
    product_matrix = pd.get_dummies(products[['CATEGORY_ID']])
    product_similarity = cosine_similarity(product_matrix)
    product_sim_df = pd.DataFrame(product_similarity, index=products['PRODUCT_ID'], columns=products['PRODUCT_ID'])
    similar_products = product_sim_df[product_id].sort_values(ascending=False).index[1:4]
    return products[products['PRODUCT_ID'].isin(similar_products)]

def content_based_filtering(user_id):
    viewed_products = user_views[user_views['USER_ID'] == user_id]['PRODUCT_ID']
    viewed_product_info = products[products['PRODUCT_ID'].isin(viewed_products)]
    recommended_products = products[(products['CATEGORY_ID'].isin(viewed_product_info['CATEGORY_ID'])) &
                                    (~products['PRODUCT_ID'].isin(viewed_products))]
    return recommended_products

def cart_based_recommendation(user_id):
    user_cart_products = cart_history[cart_history['USER_ID'] == user_id]['PRODUCT_ID']
    related_products = order_items[order_items['PRODUCT_ID'].isin(user_cart_products)]['PRODUCT_ID'].unique()
    recommended_products = set(related_products) - set(user_cart_products)
    return products[products['PRODUCT_ID'].isin(recommended_products)]

def trending_products():
    recent_views = user_views[user_views['VIEWED_AT'] >= pd.Timestamp.now() - pd.DateOffset(days=30)]
    trending_product_ids = recent_views['PRODUCT_ID'].value_counts().head(3).index
    return products[products['PRODUCT_ID'].isin(trending_product_ids)]

print("사용자 기반 추천: \n", user_based_collaborative_filtering(1))
print("-----------------------------------")
print("상품 기반 추천: \n", item_based_collaborative_filtering(1))
print("-----------------------------------")
print("콘텐츠 기반 추천: \n", content_based_filtering(1))
print("-----------------------------------")
print("장바구니 기반 추천: \n", cart_based_recommendation(1))
print("-----------------------------------")
print("최신 트렌드 추천: \n", trending_products())
