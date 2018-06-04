CLEAR SCREEN;
SET LINESIZE 230;
set serveroutput on;
alter session set nls_date_format="YYYY-MM-DD";

CREATE OR REPLACE TYPE
	V_OPTIONS IS VARRAY(3) OF VARCHAR2(10);
/

CREATE OR REPLACE TYPE
	V_AFFECTS IS TABLE OF VARCHAR2(20);
/

DELETE FROM LOGS;
DROP TABLE LOGS;

CREATE TABLE LOGS
(
	LOG_ID number(9) NOT NULL,
	LOG_DATE date NOT NULL,
	LOG_WHO varchar2(30) NOT NULL,
	LOG_MESSAGE varchar2(150) NOT NULL,
	LOG_OPTIONS V_OPTIONS,
	LOG_AFFECTED_USERS V_AFFECTS
)
NESTED TABLE LOG_AFFECTED_USERS STORE AS TAB_AFFECTED;

ALTER TABLE LOGS
	ADD CONSTRAINT CSR_PK_LOGS
	PRIMARY KEY (LOG_ID);
	
DROP SEQUENCE SEQ_LOGS;
CREATE SEQUENCE SEQ_LOGS INCREMENT BY 1 START WITH 1 MAXVALUE 999999999 MINVALUE 1;

CREATE OR REPLACE TRIGGER T_BI_LOGS
	BEFORE INSERT ON LOGS
	FOR EACH ROW
		BEGIN
			IF :new.LOG_ID is NULL then
				SELECT SEQ_LOGS.nextval INTO :new.LOG_ID FROM dual;
			END IF;
		end;
/

INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE, LOG_OPTIONS, LOG_AFFECTED_USERS)
 VALUES(SYSDATE, USER, 'TEST-LOG', V_OPTIONS('READABLE','NONEDIT','PERMAMENT'), V_AFFECTS('ADMIN','JAN1'));
 
DECLARE
	zmienna V_OPTIONS;
	BEGIN
		SELECT LOG_OPTIONS into zmienna
		FROM LOGS
		WHERE LOG_MESSAGE='TEST-LOG';
		dbms_output.put_line('Opcje wpisu : ');
		dbms_output.put_line(zmienna(1));
		dbms_output.put_line(zmienna(2));
		dbms_output.put_line(zmienna(3));
	END;
/

DECLARE
	zmienna V_AFFECTS;
	BEGIN
		SELECT LOG_AFFECTED_USERS into zmienna
		FROM LOGS
		WHERE LOG_MESSAGE='TEST-LOG';
		dbms_output.put_line('Dotyczy użytkownika : ');
		dbms_output.put_line(zmienna(1));
	END;
/

select LOG_ID, x.* from LOGS, TABLE(LOG_OPTIONS) x;
/*
    LOG_ID COLUMN_VAL
---------- ----------
         1 READABLE
         1 NONEDIT
         1 PERMAMENT
*/

select LOG_ID, x.* from LOGS, TABLE(LOG_AFFECTED_USERS) x;
/*
    LOG_ID COLUMN_VALUE
---------- --------------------
         1 ADMIN
         1 JAN2
         1 SYSTEM
*/
update LOGS
set 
	LOG_OPTIONS = V_OPTIONS('READABLE', 'EDITABLE', NULL),
	LOG_AFFECTED_USERS = V_AFFECTS('ADMIN', 'JAN2', 'SYSTEM')
where LOG_MESSAGE='TEST-LOG';
/*
    LOG_ID COLUMN_VAL
---------- ----------
         1 READABLE
         1 EDITABLE
         1
*/