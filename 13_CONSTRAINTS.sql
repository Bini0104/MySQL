/* CONSTRAINTS */

-- 제약조건
-- 테이블 작성 시 컬럼에 값 기록에 대한 제약조건을 설정할 수 있다.
-- 데이터 무결성 보장을 목적으로 함
-- 입력/수정하는 데이터에 문제가 없는지 자동으로 검사해 주게 하기 위한 목적
-- PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

/* NOT NULL */
-- NULL값 허용하지 않음

DROP TABLE IF EXISTS USER_NOTNULL;
CREATE TABLE IF NOT EXISTS USER_NOTNULL (
       user_no INT NOT NULL,
       user_id VARCHAR(255) NOT NULL,
       user_pwd VARCHAR(255) NOT NULL,
       user_name VARCHAR(255) NOT NULL,
       gender VARCHAR(3),
       phone VARCHAR(255) NOT NULL,
       email VARCHAR(255)
)ENGINE=INNODB;

INSERT INTO USER_NOTNULL (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-1235-5679', 'yu77@gmail.com');
       
SELECT * FROM USER_NOTNULL;

-- not null 제약조건 에러 발생(null값 적용)
INSERT INTO USER_NOTNULL (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (3, 'user03', null, '이순신', '남', '010-222-2222', 'lee@gmail.com');

/* UNIQUE */
-- 중복값 허용하지 않음 유일해야한다.
DROP TABLE IF EXISTS USER_UNIQUE;
CREATE TABLE IF NOT EXISTS USER_UNIQUE (
       user_no INT NOT NULL,
       user_id VARCHAR(255) NOT NULL,
       user_pwd VARCHAR(255) NOT NULL,
       user_name VARCHAR(255) NOT NULL,
       gender VARCHAR(3),
       phone VARCHAR(255) NOT NULL,
       email VARCHAR(255),
       UNIQUE(phone)
)ENGINE=INNODB;

INSERT INTO USER_UNIQUE (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-1235-5679', 'yu77@gmail.com');
      
SELECT * FROM USER_UNIQUE;

-- unique 제약조건 에러 발생(전화번호 중복값 적용)
INSERT INTO USER_UNIQUE (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (3, 'user03', 'pass03', '이순신', '남', '010-1235-5679', 'lee@gmail.com');

/* PRIMARY KEY */
-- 테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미한다.
-- 테이블에 대한 식별자 역할을 한다.(한 행씩 구분하는 역할을 한다.)
-- NOT NULL + UNIQUE 제약조건의 의미
-- 한 테이블당 한 개만 설정할 수 있음
-- 컬럼레벨, 테이블레벨 둘 다 설정 가능 함
-- 한 개 컬럼에 설정할 수도 있고, 여러 개의 컬럼을 묶어서 설정할 수도 있음(복합키)

DROP TABLE IF EXISTS USER_PRIMARYKEY;
CREATE TABLE IF NOT EXISTS USER_PRIMARYKEY (
       user_no INT,
       user_id VARCHAR(255) NOT NULL,
       user_pwd VARCHAR(255) NOT NULL,
       user_name VARCHAR(255) NOT NULL,
       gender VARCHAR(3),
       phone VARCHAR(255) NOT NULL,
       email VARCHAR(255),
       PRIMARY KEY(user_no)
)ENGINE=INNODB;

INSERT INTO USER_PRIMARYKEY (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
       (2, 'user02', 'pass02', '유관순', '여', '010-1235-5679', 'yu77@gmail.com');
       
SELECT * FROM USER_PRIMARYKEY;

-- primary key 제약조건 에러 발생(null값 적용)
INSERT INTO USER_PRIMARYKEY (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (NULL, 'user03', 'pass03', '이순신', '남', '010-1235-5679', 'lee@gmail.com');

-- primary key 제약조건 에러 발생(중복값 적용)
INSERT INTO USER_PRIMARYKEY (user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES (2, 'user03', 'pass03', '이순신', '남', '010-1235-5679', 'lee@gmail.com');

/* FOREIGN KEY */
-- 참조(REFERENCES)된 다른 테이블에서 제공하는 값만 사용할 수 있음
-- 참조 무결성을 위배하지 않기 위해 사용
-- FOREIGN KEY 제약조건에 의해서
-- 테이블 간의 관계(RELATIONSHIP)가 형성됨
-- 제공되는 값 외에는 NULL을 사용할 수 없음

-- 제약조건 확인용 테이블 생성 및 INSERT 후 조회하기(부모 테이블)
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade (
       grade_code INT,
       grade_name VARCHAR(255) NOT NULL
)ENGINE=INNODB;

INSERT INTO user_grade VALUES (10, '일반회원'),
                              (20, '우수회원'),
                              (30, '특별회원');
                              
SELECT * FROM user_grade;

-- 자식테이블
DROP TABLE IF EXISTS USER_FOREIGNKEY1;
CREATE TABLE IF NOT EXISTS USER_FOREIGNKEY1 (
       user_no INT PRIMARY KEY,
       user_id VARCHAR(255) NOT NULL,
       user_pwd VARCHAR(255) NOT NULL,
       user_name VARCHAR(255) NOT NULL,
       gender VARCHAR(3),
       phone VARCHAR(255) NOT NULL,
       email VARCHAR(255),
       grade_code INT,
       FOREIGN KEY (grade_code)
       REFERENCES user_grade (grade_code)
)ENGINE=INNODB;

INSERT INTO USER_FOREIGNKEY1 (user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
       (2, 'user02', 'pass02', '유관순', '여', '010-1235-5679', 'yu77@gmail.com', 20); 
       
SELECT * FROM user_foreignkey1;

-- FOREIGN KEY 제약 조건 에러 발생(참조 컬럼에 없는 값 적용)
INSERT INTO user_foreignkey1 (user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES (3, 'user03', 'pass03', '이순신', '남', '010-1235-5679', 'lee@gmail.com', 50);

DROP TABLE IF EXISTS USER_FOREIGNKEY2;
CREATE TABLE IF NOT EXISTS USER_FOREIGNKEY2 (
       user_no INT PRIMARY KEY,
       user_id VARCHAR(255) NOT NULL,
       user_pwd VARCHAR(255) NOT NULL,
       user_name VARCHAR(255) NOT NULL,
       gender VARCHAR(3),
       phone VARCHAR(255) NOT NULL,
       email VARCHAR(255),
       grade_code INT,
       FOREIGN KEY (grade_code)
       REFERENCES user_grade (grade_code)
           ON UPDATE SET NULL
           ON DELETE SET NULL
)ENGINE=INNODB;

INSERT INTO USER_FOREIGNKEY2 (user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES (1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
       (2, 'user02', 'pass02', '유관순', '여', '010-1235-5679', 'yu77@gmail.com', 20); 
       
SELECT * FROM USER_FOREIGNKEY2;

-- 1) 부모테이블의 grade_code 수정
DROP TABLE IF EXISTS user_foreignkey1;

UPDATE user_grade
SET grade_code = 1
WHERE grade_code = 10;

-- 자식 테이블의 grade_code가 10이 었던 회원의 grade_code값이 NULL이 된 것을 확인
SELECT * FROM USER_FOREIGNKEY2;

-- 2) 부모 테이블의 행 삭제
DELETE FROM user_grade
WHERE grade_code = 20;

-- 자식 테이블의 grade_code가 20이 었던 회원의 grade_code값이 NULL이 된 것을 확인
SELECT * FROM user_foreignkey2;

/* CHECK */
-- CHECK 제약 조건 위반시 허용하지 않음
DROP TABLE IF EXISTS USER_CHECK;
CREATE TABLE IF NOT EXISTS USER_CHECK (
       user_no INT AUTO_INCREMENT PRIMARY KEY,
       user_name VARCHAR(255) NOT NULL,
       gender VARCHAR(3) CHECK (gender IN ('남', '여')),
       age INT CHECK (age >= 19)
)ENGINE=INNODB;

INSERT INTO USER_CHECK VALUES (NULL, '안중근', '남', 25);

SELECT * FROM USER_CHECK;

-- gender 컬럼의 CHECK 제약 조건 에러 발생
INSERT INTO USER_CHECK VALUES (NULL, '홍길동', '남성', 27);

-- age 컬럼의 CHECK 제약 조건 에러 발생
INSERT INTO USER_CHECK VALUES (NULL, '유관순', '여', 17);

/* DEFAULT */
-- 컬럼에 NULL 대신 기본 값 적용
DROP TABLE IF EXISTS TBL_COUNTRY;
CREATE TABLE IF NOT EXISTS TBL_COUNTRY(
       COUNTRY_CODE INT AUTO_INCREMENT PRIMARY KEY,
	   COUNTRY_NAME VARCHAR(255) DEFAULT '한국',
       POPULATION VARCHAR(255) DEFAULT '0명'
)ENGINE=INNODB;

SELECT * FROM TBL_COUNTRY;

INSERT INTO TBL_COUNTRY VALUES (NULL, DEFAULT, DEFAULT);