DROP TABLE EMPLOYEES CASCADE CONSTRAINTS;
CREATE TABLE EMPLOYEES(
    EMPLOYEE_ID NUMBER PRIMARY KEY,
    DNI VARCHAR2(15) UNIQUE,
    ENAME VARCHAR2(60) NOT NULL,
    HDATE DATE NOT NULL,
    IFACE BLOB NULL,
    JID VARCHAR2(10) 
);
DROP SEQUENCE SEQ_EMPLOYEES_AI;
CREATE SEQUENCE SEQ_EMPLOYEES_AI START WITH 100;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE JOBS;
CREATE TABLE JOBS(
    JID VARCHAR2(10) PRIMARY KEY,
    JOB_NAME VARCHAR2(50),
    JOB_SALARY NUMBER
);
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE SALES CASCADE CONSTRAINTS;
CREATE TABLE SALES(
    SALE_ID NUMBER PRIMARY KEY,
    SALE_DATE DATE NOT NULL,    
    SALE_TOTAL NUMBER NOT NULL,
    SALE_ART_COUNT NUMBER NOT NULL,
    SALE_CUSTOMER_ID NUMBER,
    SALE_EMPLOYEE_ID NUMBER
);
DROP SEQUENCE SEQ_SALES_AI;
CREATE SEQUENCE SEQ_SALES_AI START WITH 1;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE SALE_ITEMS;
CREATE TABLE SALE_ITEMS(
    SALE_ID NUMBER,
    LINE_ITEM_ID NUMBER NOT NULL,
    ITEM_ID NUMBER,
    PRICE NUMBER,
    QUANTITY NUMBER,
    STOTAL NUMBER,
    DISCOUNT NUMBER DEFAULT 0
);
----------------------------------------------------------------------------------------------------------------------------------
DROP TABLE ITEMS CASCADE CONSTRAINTS;
CREATE TABLE ITEMS(
    ITEM_ID NUMBER PRIMARY KEY,
    ITEM_CODE VARCHAR2(80) UNIQUE,
    ITEM_DESCRIPTION VARCHAR2(100) NOT NULL,
    UPRICE NUMBER NOT NULL,
    STOCK NUMBER NOT NULL,
    UNIT_TYPE VARCHAR2(60) NOT NULL
);

DROP SEQUENCE SEQ_ITEMSID;
CREATE SEQUENCE SEQ_ITEMSID START WITH 1;
----------------------------------------------------------------------------------------------------------------------------------
DROP TABLE CUSTOMERS CASCADE CONSTRAINTS;
CREATE TABLE CUSTOMERS(
    CUST_ID NUMBER PRIMARY KEY,
    CUST_DNI VARCHAR2(15) UNIQUE,
    CUST_NAME VARCHAR2(50),
    CUST_DBIRTH DATE,
    CUST_ADDRESS VARCHAR2(40),
    CUST_ZIP NUMBER,
    CUST_STATE VARCHAR2(50),
    CUST_COUNTRY VARCHAR2(50),
    CUST_PHONE VARCHAR2(50)
);
DROP SEQUENCE SEQ_CUSTOMERS_AI;
CREATE SEQUENCE SEQ_CUSTOMERS_AI START WITH 1;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE EMPLOYEES ADD CONSTRAINT FK_EMP_JID FOREIGN KEY(JID) REFERENCES JOBS(JID);
ALTER TABLE SALES ADD CONSTRAINT FK_SALES_CUSTID FOREIGN KEY(SALE_CUSTOMER_ID) REFERENCES CUSTOMERS(CUST_ID);
ALTER TABLE SALES ADD CONSTRAINT FK_SALES_EMPID FOREIGN KEY(SALE_EMPLOYEE_ID) REFERENCES EMPLOYEES(EMPLOYEE_ID);
ALTER TABLE SALE_ITEMS ADD PRIMARY KEY(SALE_ID, LINE_ITEM_ID);
ALTER TABLE SALE_ITEMS ADD CONSTRAINT FK_SITEMS_SALEID FOREIGN KEY(SALE_ID) REFERENCES SALES(SALE_ID);
ALTER TABLE SALE_ITEMS ADD CONSTRAINT FK_SITEMS_ITEMID FOREIGN KEY(ITEM_ID) REFERENCES ITEMS(ITEM_ID);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
COMMIT;