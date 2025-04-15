CREATE DATABASE yanolja_db2 default CHARACTER SET UTF8;
use yanolja_db2;

-- user 
CREATE TABLE Users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  password VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 숙소-- 
CREATE TABLE Locations (
    LocationID INT PRIMARY KEY AUTO_INCREMENT,
    City VARCHAR(255) NOT NULL,
    District VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 판매자
CREATE TABLE Sellers (
    SellerID INT PRIMARY KEY AUTO_INCREMENT,
    SellerName VARCHAR(255) NOT NULL,
    Contact VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
  

  -- product
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    SellerID INT,
    ProductName VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID)
);

-- 숙소 유형
CREATE TABLE AccommodationTypes (
    AccommodationTypeID INT PRIMARY KEY AUTO_INCREMENT,
    AccommodationType VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 숙박 유형
CREATE TABLE StayTypes (
    StayTypeID INT PRIMARY KEY AUTO_INCREMENT,
    StayType VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Accomodation
CREATE TABLE Accomodations (
    ProductID INT PRIMARY KEY,
    LocationID INT,
    AccommodationTypeID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
    FOREIGN KEY (AccommodationTypeID) REFERENCES AccommodationTypes(AccommodationTypeID)
);

-- Accommodation Images
CREATE TABLE AccommodationImages (
    ImageID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    ImageURL VARCHAR(1024) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Accomodations(ProductID)
);

-- 객실 종류
CREATE TABLE RoomTypes (
    RoomTypeID INT PRIMARY KEY AUTO_INCREMENT,
    RoomType VARCHAR(255) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 숙소별 객실 가격
CREATE TABLE Room (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT NOT NULL,
    RoomTypeID INT NOT NULL,
    StayTypeID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    MaxGuests INT NOT NULL,
    AdditionalPersonCharge DECIMAL(10,2) NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Accomodations(ProductID),
    FOREIGN KEY (RoomTypeID) REFERENCES RoomTypes(RoomTypeID),
    FOREIGN KEY (StayTypeID) REFERENCES StayTypes(StayTypeID)
);

-- Room Images
CREATE TABLE RoomImages (
    ImageID INT PRIMARY KEY AUTO_INCREMENT,
    RoomID INT NOT NULL,
    ImageURL VARCHAR(1024) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);


-- 티켓
-- 놀이카테고리 종류
CREATE TABLE Play_category(
  play_category INT PRIMARY KEY,
  golf TINYINT NOT NULL DEFAULT 0,
  ski TINYINT NOT NULL DEFAULT 0,
  waterpark TINYINT NOT NULL DEFAULT 0,
  watersports TINYINT NOT NULL DEFAULT 0,
  themepark TINYINT NOT NULL DEFAULT 0,
  vrEscaperoom TINYINT NOT NULL DEFAULT 0,
  kids TINYINT NOT NULL DEFAULT 0,
  indoorsports TINYINT NOT NULL DEFAULT 0,
  outdoorsports TINYINT NOT NULL DEFAULT 0,
  tour TINYINT NOT NULL DEFAULT 0,
  themecafe TINYINT NOT NULL DEFAULT 0,
  fishing TINYINT NOT NULL DEFAULT 0,
  health TINYINT NOT NULL DEFAULT 0,
  exhibition TINYINT NOT NULL DEFAULT 0,
  borrow TINYINT NOT NULL DEFAULT 0
);
-- 놀이
CREATE TABLE Play(
  play_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  Play_category INT NOT NULL,
  FOREIGN KEY (play_category) REFERENCES Play_category(play_category)
);

-- 배움 카테고리 종류
CREATE TABLE Lesson_category(
  lesson_category INT PRIMARY KEY,
  crafts TINYINT NOT NULL DEFAULT 0,
  sportsclass TINYINT NOT NULL DEFAULT 0,
  cookingclass TINYINT NOT NULL DEFAULT 0
);

-- 배움  
CREATE TABLE Lesson(
  lesson_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  lesson_category INT NOT NULL,
  FOREIGN KEY (lesson_category) REFERENCES Lesson_category(lesson_category)
);

-- 플레이타입  
CREATE TABLE Play_type(
  play_typeid VARCHAR(40) PRIMARY KEY,
  play_name VARCHAR(40) NOT NULL,
  leisureTicket VARCHAR(10) NOT NULL,
  exhibition VARCHAR(10) NOT NULL,
  kids VARCHAR(10) NOT NULL
);

-- 티켓 구매자(어린이/청소년/어른)
CREATE TABLE leisureTicket_headcount(
  age_group TINYINT PRIMARY KEY,
  leisureTicket_leisureTicket_id INT NOT NULL,
  leisureTicket_leisureTicket_headcount INT NOT NULL
);
-- 레저티켓 
CREATE TABLE leisureTicket (
  ProductID INT PRIMARY KEY,
  leisureTicket_id INT NOT NULL,
  lesureTicket_img VARCHAR(45) NOT NULL,
  leisureTicket_headcount INT NOT NULL,
  leisureTicket_price VARCHAR(45) NOT NULL,
  leisureTicket_schedule VARCHAR(45) NOT NULL,
  leisureTicket_location VARCHAR(45) NOT NULL,
  play_typeid VARCHAR(40) NOT NULL,
  play_id INT NOT NULL,
  Play_category CHAR(20) NOT NULL,
  lesson_id INT NOT NULL,
  age_group TINYINT NOT NULL,
  FOREIGN KEY (play_typeid) REFERENCES Play_type(play_typeid),
  FOREIGN KEY (age_group) REFERENCES leisureTicket_headcount(age_group),
  FOREIGN KEY (play_id) REFERENCES Play(play_id),
  FOREIGN KEY (lesson_id) REFERENCES Lesson(lesson_id),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
  );




-- 교통(1)항공
CREATE TABLE airport(
  airport_id INT PRIMARY KEY AUTO_INCREMENT,
  airport_name VARCHAR(20) NOT NULL,
  country VARCHAR(45)
);
-- 항공 스케줄
CREATE TABLE flight_sehedule(
  sehedule_number INT PRIMARY KEY AUTO_INCREMENT,
  daparture_time DATETIME NOT NULL,
  arrival_time DATETIME NOT NULL
);
-- 예약 비행 좌석 확인
CREATE TABLE reservation_flight_seat(
  reservation_flight_seat BOOLEAN PRIMARY KEY
);
-- 비행기 좌석
CREATE TABLE flight_seat(
  seat_number INT PRIMARY KEY AUTO_INCREMENT,
  seating_grade VARCHAR(45),
  reservation_flight_seat BOOLEAN,
  FOREIGN KEY (reservation_flight_seat) REFERENCES reservation_flight_seat(reservation_flight_seat)
);
-- 항공권
CREATE TABLE flight(
  ProductID INT PRIMARY KEY,
  flight_id INT NOT NULL,
  size INT NOT NULL,
  weight INT NOT NULL,
  speed INT NOT NULL,
  capacity INT NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  airport_id INT NOT NULL,
  seat_number INT NOT NULL,
  sehedule_number INT NOT NULL,
  FOREIGN KEY (airport_id) REFERENCES airport(airport_id),
  FOREIGN KEY (seat_number) REFERENCES flight_seat(seat_number),
  FOREIGN KEY (sehedule_number) REFERENCES flight_sehedule(sehedule_number),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 교통(2)기차
CREATE TABLE train_sehedule(
  sehedule_number INT PRIMARY KEY AUTO_INCREMENT,
  daparture_time DATETIME NOT NULL,
  arrival_time DATETIME NOT NULL
);
-- 기차 예약 좌석 확인
CREATE TABLE reservation_train_seat(
  reservation_train_seat BOOLEAN PRIMARY KEY
);
-- 기차 좌석
CREATE TABLE train_seat(
  seat_number INT PRIMARY KEY AUTO_INCREMENT,
  seating_grade VARCHAR(45),
  reservation_train_seat BOOLEAN,
  FOREIGN KEY (reservation_train_seat) REFERENCES reservation_train_seat(reservation_train_seat)
);
-- 기차
CREATE TABLE train(
  ProductID INT PRIMARY KEY,
  train_id INT NOT NULL,
  train_date DATETIME NOT NULL,
  departure DATE NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  seat VARCHAR(20) NOT NULL,
  seat_number INT NOT NULL,
  sehedule_number INT NOT NULL,
  FOREIGN KEY (seat_number) REFERENCES train_seat(seat_number),
  FOREIGN KEY (sehedule_number) REFERENCES train_sehedule(sehedule_number),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 교통(3)렌트
CREATE TABLE car_sehedule(
  sehedule_number INT PRIMARY KEY AUTO_INCREMENT,
  borrowing_time DATETIME NOT NULL,
  return_time DATETIME NOT NULL
);
--  렌트카 종류
CREATE TABLE car_product(
  product_code INT PRIMARY KEY AUTO_INCREMENT,
  first_car int NOT NULL,
  second_car int NOT NULL,
  third_car int NOT NULL
);
-- 렌트카
CREATE TABLE car(
  ProductID INT PRIMARY KEY,
  car_id INT NOT NULL,
  car_model VARCHAR(50) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  sehedule_number INT NOT NULL,
  product_code INT NOT NULL,
  FOREIGN KEY (sehedule_number) REFERENCES car_sehedule(sehedule_number),
  FOREIGN KEY (product_code) REFERENCES car_product(product_code),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);



-- 리뷰 
CREATE TABLE Reviews (
  review_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  accommodation_id INT NOT NULL,
  rating INT NOT NULL,
  comment TEXT,
  ProductID INT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- 예약--
CREATE TABLE Reservations (
  reservation_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  AccommodationTypeID INT NOT NULL,
  ProductID INT NOT NULL,
  check_in_date DATE NOT NULL,
  check_out_date DATE NOT NULL,
  status VARCHAR(50) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- 결제

-- 결제취소
CREATE TABLE payment_cancel(
  payment_cancel INT PRIMARY KEY,
  is_canceled TINYINT(1) NOT NULL,
  cancellation_fee INT NOT NULL,
  refund_amount INT NOT NULL,
  is_refund TINYINT(1) NOT NULL
);

-- 결제수단-카드
CREATE TABLE credit_card(
  credit_card INT PRIMARY KEY,
  card_company VARCHAR(50) NOT NULL,
  deposit_amount INT NOT NULL,
  card_number INT NOT NULL,
  password INT NOT NULL
);
-- 결제수단-통장
CREATE TABLE passbook(
  passbook INT PRIMARY KEY,
  bank VARCHAR(5),
  deposit_amount INT NOT NULL,
  bank_account_number INT NOT NULL,
  name VARCHAR(5),
  deposit_date DATETIME
);
-- 결제수단-핸드폰결제
CREATE TABLE phone_payment(
  phone_payment INT PRIMARY KEY,
  agency VARCHAR(45),
  deposit_amount INT NOT NULL,
  phone_number INT NOT NULL,
  authentication_number VARCHAR(5)
);
-- 결제수단
CREATE TABLE payment_method(
  payment_method VARCHAR(50) PRIMARY KEY,
  credit_card INT NOT NULL,
  passbook INT NOT NULL,
  phone_payment INT NOT NULL,
  payment_id INT NOT NULL,
  FOREIGN KEY (credit_card) REFERENCES credit_card(credit_card),
  FOREIGN KEY (passbook) REFERENCES passbook(passbook),
  FOREIGN KEY (phone_payment) REFERENCES phone_payment(phone_payment)
);
-- 결제
CREATE TABLE Payments (
  payment_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  reservation_id INT NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  payment_method VARCHAR(50) NOT NULL,
  payment_cancel INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id),
  FOREIGN KEY (payment_cancel) REFERENCES payment_cancel(payment_cancel),
  FOREIGN KEY (payment_method) REFERENCES payment_method(payment_method)
);





-- 릴레이션 테이블
SELECT
   t1.table_name, t1.table_comment, column_name, data_type, column_type, column_key, is_nullable, column_default, extra, column_comment
FROM
   (SELECT
       table_name, table_comment
    FROM
       information_schema.TABLES WHERE table_schema='yanolja_db2') t1,
   (SELECT
       table_name, column_name, data_type, column_type, column_key, is_nullable, column_default, extra, column_comment, ordinal_position
    FROM
       information_schema.COLUMNS WHERE table_schema='yanolja_db2') t2
WHERE
    t1.table_name = t2.table_name
ORDER BY
    t1.table_name, ordinal_position; 

