# 🏨 DB_yanolja - 데이터베이스 설계 프로젝트

**야놀자(숙박 예약 플랫폼)**를 기반으로 기획된 데이터베이스 설계 프로젝트입니다.  
숙박, 레저, 교통, 결제 등 **실제 상업 서비스에서 필요한 모든 도메인 요소를 반영한 관계형 데이터베이스(RDBMS)** 구조를 설계하고 SQL로 구현했습니다.

---

## 📦 프로젝트 목표

- 실제 서비스 구조를 반영한 **정규화된 스키마 설계**
- **사용자 → 예약 → 결제** 흐름의 전체 데이터 흐름 구현
- 다양한 **상품(Product)** 유형 관리 (숙박, 레저, 항공, 기차, 렌트)
- 세부적인 **결제 방식** 및 **취소/환불 처리** 구조 설계
- 확장 가능한 **카테고리 기반 레저/배움 데이터 모델링**

---

## 📁 주요 파일

| 파일명 | 설명 |
|--------|------|
| `yanoljs.sql` | 전체 테이블 생성 SQL 스크립트 |
| `DB구축을 위한 스키마 설계 프로젝트.pdf` | ERD 및 테이블 관계 설명서 |
| `.DS_Store` | macOS 시스템 파일 (Git에서 무시 예정) |

---

## 🛠 주요 테이블 구성

### 👤 Users  
회원 정보 관리 테이블 (이메일, 비밀번호, 가입일 등)

### 🏨 숙박 도메인
- `Products`: 상품 식별용 공통 테이블  
- `Accomodations`: 숙박 상품 정보  
- `Rooms`, `RoomTypes`, `StayTypes`: 객실 구성  
- `AccommodationImages`, `RoomImages`: 이미지 관리  
- `Reservations`, `Reviews`: 예약 및 후기

### 🎡 레저·배움 도메인
- `Play`, `Lesson`: 레저/배움 상품  
- `Play_category`, `Lesson_category`: 카테고리 테이블  
- `leisureTicket`, `leisureTicket_headcount`: 티켓 상세 관리  
- `Play_type`: 티켓 타입 정의

### 🚉 교통 도메인
- 항공: `airport`, `flight`, `flight_sehedule`, `flight_seat`, `reservation_flight_seat`  
- 기차: `train`, `train_sehedule`, `train_seat`, `reservation_train_seat`  
- 렌트: `car`, `car_product`, `car_sehedule`

### 💳 결제 도메인
- `Payments`: 결제 내역  
- `payment_method`: 결제 수단 (카드/통장/핸드폰)  
- `payment_cancel`: 환불 및 취소 처리  
- `credit_card`, `passbook`, `phone_payment`: 실제 결제 수단 정보

---

## 🔄 관계(릴레이션) 구조

- `Products`는 숙박, 교통, 레저, 렌트 등 다양한 상품의 공통 상위 테이블
- 대부분의 테이블은 `ProductID` 또는 `user_id`를 통해 서로 연결됨
- 결제 흐름은:  
  `Users → Reservations → Payments → payment_method → 실 결제 테이블`

---

## 💡 사용 기술 및 환경

- RDBMS: MySQL 8+
- SQL 문법 준수
- ERD 도구: Draw.io / MySQL Workbench
- 실행 환경: VS Code + DB Client 도구 (ex. TablePlus, DBeaver, MySQL CLI)

---

## 🙋‍♂️ 작성자

**dev-parkjs**  
📫 [GitHub 프로필](https://github.com/dev-parkjs)

---

## 📌 참고

본 프로젝트는 개인 포트폴리오 및 데이터베이스 모델링 실습을 목적으로 제작되었습니다.