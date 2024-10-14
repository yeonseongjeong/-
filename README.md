# 이익 분석 프로젝트

이 프로젝트는 쇼핑몰의 비즈니스 판매 데이터를 분석하고, 이를 시각화하여 제공하는 시스템입니다. Spring Legacy Project와 JavaScript의 Chart.js를 활용하여 데이터를 처리하고 동적으로 시각화합니다. 이 시스템을 통해 판매 트렌드를 파악하고, 다양한 카테고리와 브랜드에 따른 분석을 통해 의사결정을 지원합니다.

## 주요 기능

- **이익 분석**: 카테고리별, 기간별(일간, 주간, 월간), 브랜드별로 판매 데이터를 분석합니다.
- **데이터 시각화**: 주요 성과 지표를 막대 그래프로 시각화하여 제공합니다. JavaScript의 Chart.js를 사용해 데이터를 시각적으로 표현합니다.
- **쇼핑몰 웹 구현**: Spring Legacy Project를 사용하여 쇼핑몰 웹 애플리케이션을 구축하였습니다. 이 웹사이트는 사용자와의 상호작용을 위한 프론트엔드 및 백엔드 시스템을 포함합니다.
- **브랜드 및 카테고리별 분석**: 다양한 브랜드와 카테고리에 대한 판매 성과를 제공합니다.
- **OCR 기능**: 네이버 클로바와 OpenAI를 이용하여 택배 운송장을 읽는 OCR 기능을 구현하였습니다. 이 기능은 운송장 정보를 자동으로 추출하고, 데이터베이스에 저장하는 데 사용됩니다. 해당 기능을 Brity RPA를 통해 자동화합니다.
- **보고서 작성 자동화**: Brity RPA를 이용해 지정한 기간의 브랜드별, 카테고리별, 전체 매출/판매량 데이터와 해당 데이터를 시각화한 그래프를 ERP에서 추출하여 자동으로 보고서를 만들어 이메일로 전송합니다.
- **추천 알고리즘**: 사용자의 주문, 조회, 장바구니 이력을 기반으로 추천 제품을 생성하는 API를 제공합니다. 코사인 유사도와 TF-IDF 벡터화를 사용하여 각 제품의 특징을 분석하고, 사용자의 행동을 반영하여 개인 맞춤형 추천 제품을 도출합니다.
- **Brity RPA**: 데이터를 추출하고 데이터베이스에 저장하는 과정을 자동화합니다.
- **네이버 클로바, OpenAI**: OCR 기능을 통해 택배 운송장의 정보를 인식하고 추출합니다.
- **Flask**: 추천 알고리즘 API 구현에 사용됩니다.
- **Scikit-learn**: 추천 알고리즘에서 코사인 유사도와 TF-IDF 벡터화를 구현하는 데 사용됩니다.

## 사용 기술

- **Spring Legacy Project**: 쇼핑몰의 백엔드 로직을 처리하며, 데이터베이스와 연결하여 주문, 사용자, 제품 정보를 관리합니다.
- **JavaScript (Chart.js)**: Chart.js를 사용하여 데이터 시각화 및 판매 통계 그래프를 그립니다.
- **Oracle 데이터베이스**: 판매 데이터를 저장 및 관리합니다.
- **Brity RPA**: 데이터를 추출하고 데이터베이스에 저장하는 과정을 자동화합니다.
- **네이버 클로바, OpenAI**: OCR 기능을 통해 택배 운송장의 정보를 인식하고 추출합니다.

## 예시 쇼핑몰 페이지

- **메인 페이지**: 로그인한 사용자의 주문/조회/장바구니이력 데이터를 기반으로 10개의 상품을 추천합니다.
![image](https://github.com/user-attachments/assets/8c46637f-e13a-421a-883d-cc1944b4da38)
- **상품 페이지**
![image](https://github.com/user-attachments/assets/a198b4f6-8f0b-45c5-91d6-6efffca314a8)
![image](https://github.com/user-attachments/assets/1647b736-a217-4f7a-9fe2-6afd49b90d67)
- **웹기반 ERP시스템**
![image](https://github.com/user-attachments/assets/1792ed39-ed8f-4c92-80de-4529d7e7ef2a)
![image](https://github.com/user-attachments/assets/1a4fbf16-1bda-4a3f-9f32-56ae1abf5ab2)
![image](https://github.com/user-attachments/assets/9ec47700-3fe6-4b45-ac31-1971a0c4541e)
![image](https://github.com/user-attachments/assets/54272fe4-aafb-4e2c-bd82-64addfdcd048)
![image](https://github.com/user-attachments/assets/1f20dc02-27e1-44d2-a4e8-947081e27b3f)
