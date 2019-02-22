CREATE OR REPLACE TRIGGER TRIG_EID BEFORE INSERT ON EMPLOYEES 
FOR EACH ROW 
BEGIN
    SELECT SEQ_EMPLOYEES_AI.NEXTVAL INTO :NEW.EMPLOYEE_ID FROM DUAL;
END;
--------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP------------------------------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP----------------------
CREATE OR REPLACE TRIGGER TRIG_SALEID BEFORE INSERT ON SALES 
FOR EACH ROW
BEGIN
    SELECT SEQ_SALES_AI.NEXTVAL INTO :NEW.SALE_ID FROM DUAL;
    SELECT SYSDATE INTO :NEW.SALE_DATE FROM DUAL;
END;
--------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP------------------------------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP----------------------
DROP VIEW SALE_ITEMS_BK;
CREATE VIEW SALE_ITEMS_BK AS SELECT * FROM SALE_ITEMS;
CREATE OR REPLACE TRIGGER TRIG_ITEMCALC BEFORE INSERT ON SALE_ITEMS 
FOR EACH ROW
BEGIN

    BEGIN
        SELECT GET_CURRENT_LID(:NEW.SALE_ID) INTO :NEW.LINE_ITEM_ID FROM DUAL;
        EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
    BEGIN      
        SELECT TRUNC((:NEW.PRICE * :NEW.QUANTITY),2) INTO :NEW.STOTAL FROM DUAL;
        EXCEPTION WHEN OTHERS THEN NULL;    
    END;
END;
--------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP------------------------------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP----------------------
CREATE OR REPLACE TRIGGER TRG_ITEMS_AI BEFORE INSERT ON ITEMS
FOR EACH ROW
BEGIN
    SELECT SEQ_ITEMSID.NEXTVAL INTO :NEW.ITEM_ID FROM DUAL;
END;
--------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP------------------------------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP----------------------
CREATE OR REPLACE TRIGGER TRIG_CUST_AI BEFORE INSERT ON CUSTOMERS
FOR EACH ROW
BEGIN
    SELECT SEQ_CUSTOMERS_AI.NEXTVAL INTO :NEW.CUST_ID FROM DUAL;
END;
--------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP------------------------------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP----------------------
CREATE OR REPLACE FUNCTION GET_CURRENT_LID(SALEID NUMBER) RETURN NUMBER AS
    XLID NUMBER := 1;
BEGIN
    BEGIN
        SELECT MAX(LINE_ITEM_ID) +1 INTO XLID FROM SALE_ITEMS_BK WHERE SALE_ID = SALEID;
        EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
    
    IF XLID IS NULL THEN
     XLID := 1;
    END IF;
    
    RETURN XLID;
END;
--------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP------------------------------@CHECHESWAP------------------------------------@CHECHESWAP--------------------------------@CHECHESWAP----------------------
COMMIT;
