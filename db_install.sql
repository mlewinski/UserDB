--@'C:\OneDrive\Studia\PK\Bazy danych\db_install.sql'
------------------
--KASOWANIE TABEL;
------------------

CLEAR SCREEN;
SET LINESIZE 230;
alter session set nls_date_format="YYYY-MM-DD";
PROMPT ;
PROMPT logowanie jako STUDENT;
PROMPT ;

-- connect STUDENT@db1/STUDENTPASS

PROMPT kasowanie tabel;
PROMPT ;

-- dropy
	DELETE FROM ZZZ_GROUPS_ROLES;
	DROP TABLE ZZZ_GROUPS_ROLES;
	
	DELETE FROM ACCESS_CONTROL;
	DROP TABLE ACCESS_CONTROL;
	
	DELETE FROM XXX_GROUPS;
	DROP TABLE XXX_GROUPS;
	
	DELETE FROM YYY_ROLES;
	DROP TABLE YYY_ROLES;
	
	DELETE FROM NOTIFICATIONS;
	DROP TABLE NOTIFICATIONS;
	
	DELETE FROM USERS;
	DROP TABLE USERS;
	
	DELETE FROM RESOURCES;
	DROP TABLE RESOURCES;
	
	DELETE FROM GROUPS;
	DROP TABLE GROUPS;
	
	DELETE FROM ROLES;
	DROP TABLE ROLES;
	
	DELETE FROM CATEGORY_OF_NOTIFICATION;
	DROP TABLE CATEGORY_OF_NOTIFICATION;
	
	DELETE FROM TYPE_USER;
	DROP TABLE TYPE_USER;
	
	DELETE FROM LOGS;
	DROP TABLE LOGS;
--
PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE CATEGORY_OF_NOTIFICATION;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE CATEGORY_OF_NOTIFICATION
(
	CAT_ID	number(9)	NOT NULL,
	CAT_NAME	varchar2(10)	NOT NULL,
	CAT_DESCRIPTION	varchar2(255)
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE CATEGORY_OF_NOTIFICATION
	ADD CONSTRAINT CSR_PK_CAT_OF_NOTIFICATION
	PRIMARY KEY (CAT_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							UNIQUE KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE CATEGORY_OF_NOTIFICATION
	ADD CONSTRAINT CSR_UQ_CAT_OF_NOTIFICATION
	UNIQUE (CAT_NAME);

PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE TYPE_USER;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE TYPE_USER
(
	TYP_ID	number(9)	NOT NULL,
	TYP_NAME	varchar2(20)	NOT NULL,
	TYP_DESCRIPTION	varchar2(255)
);
--TABLSPACE STUDENT_DATA

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE TYPE_USER
	ADD CONSTRAINT CSR_PK_TYPE_USER
	PRIMARY KEY (TYP_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							UNIQUE KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE TYPE_USER
	ADD CONSTRAINT CSR_UQ_TYPE_USER
	UNIQUE (TYP_NAME);

PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE ROLES;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE ROLES
(
	ROL_ID	number(9)	NOT NULL,
	ROL_NAME	varchar2(100)	NOT NULL,
	ROL_DESCRIPTION	varchar2(255)
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE ROLES
	ADD CONSTRAINT CSR_PK_ROLES
	PRIMARY KEY (ROL_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							UNIQUE KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE ROLES
	ADD CONSTRAINT CSR_UQ_ROLES
	UNIQUE (ROL_NAME);

PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE GROUPS;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE GROUPS
(
	GRO_ID	number(9)	NOT NULL,
	GRO_NAME	varchar2(60)	NOT NULL,
	GRO_DESCRIPTION	varchar2(127)
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE GROUPS
	ADD CONSTRAINT CSR_PK_GROUPS
	PRIMARY KEY (GRO_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							UNIQUE KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE GROUPS
	ADD CONSTRAINT CSR_UQ_GROUPS
	UNIQUE (GRO_NAME);
	
PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE RESOURCE;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE RESOURCES
(
	RES_ID	number(9)	NOT NULL,
	RES_URI	varchar2(255)	NOT NULL,
	RES_TYPE	varchar2(20),
	RES_NOTE	varchar2(255)
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE RESOURCES
	ADD CONSTRAINT CSR_PK_RESOURCES
	PRIMARY KEY (RES_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							UNIQUE KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE RESOURCES
	ADD CONSTRAINT CSR_UQ_RESOURCES
	UNIQUE (RES_URI);	
	
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							CONSTRAINTS;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE RESOURCES
	ADD CONSTRAINT CSR_CHK_RESOURCES
	CHECK (RES_TYPE IN ('FILE','SERVICE','DIRECTORY'));

PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE USERS;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE USERS
(
	USE_ID	number(9)	NOT NULL,
	USE_NICKNAME	varchar2(20) NOT NULL,
	USE_NAME		varchar2(30) NOT NULL,
	USE_SURNAME		varchar2(30) NOT NULL,
	USE_EMAIL		varchar2(50)	NOT NULL,
	USE_PHONE		varchar2(16) NOT NULL,
	TYP_ID	number(9)	NOT NULL			
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE USERS
	ADD CONSTRAINT CSR_PK_USERS
	PRIMARY KEY (USE_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							FOREIGN KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE USERS
	ADD CONSTRAINT CSR_FK_USERS
	FOREIGN KEY (TYP_ID)
	REFERENCES TYPE_USER (TYP_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							UNIQUE KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE USERS
	ADD CONSTRAINT CSR_UQ_USERS
	UNIQUE (USE_NICKNAME);
	
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							CONSTRAINTS;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE USERS
	ADD CONSTRAINT CSR_CHK_USERS
	CHECK (USE_ID BETWEEN 0 AND 10000);

	
PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE NOTIFICATIONS;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE NOTIFICATIONS
(
	NOT_ID	number(9)	NOT NULL,
	NOT_CONTENT	VARCHAR2(255)	NOT NULL,
	NOT_DATE	DATE	NOT NULL,
	USE_ID	number(9)	NOT NULL,
	CAT_ID	number(9)	NOT NULL
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE NOTIFICATIONS
	ADD CONSTRAINT CSR_PK_NOTIFICATIONS
	PRIMARY KEY (NOT_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							FOREIGN KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE NOTIFICATIONS
	ADD CONSTRAINT CSR_FK_1_NOTIFICATIONS
	FOREIGN KEY (CAT_ID)
	REFERENCES CATEGORY_OF_NOTIFICATION (CAT_ID);
	
ALTER TABLE NOTIFICATIONS
	ADD CONSTRAINT CSR_FK_2_NOTIFICATIONS
	FOREIGN KEY (USE_ID)
	REFERENCES USERS (USE_ID);
	
PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE YYY_ROLES;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE YYY_ROLES
(
	YYY_ID	number(9)	NOT NULL,
	USE_ID	number(9)	NOT NULL,
	ROL_ID	number(9)	NOT NULL
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE YYY_ROLES
	ADD CONSTRAINT CSR_PK_YYY_ROLES
	PRIMARY KEY (YYY_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							FOREIGN KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE YYY_ROLES
	ADD CONSTRAINT CSR_FK_1_YYY_ROLES
	FOREIGN KEY (USE_ID)
	REFERENCES USERS (USE_ID);
	
ALTER TABLE YYY_ROLES
	ADD CONSTRAINT CSR_FK_2_YYY_ROLES
	FOREIGN KEY (ROL_ID)
	REFERENCES ROLES (ROL_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE XXX_GROUPS;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE XXX_GROUPS
(
	XXX_ID	number(9)	NOT NULL,
	GRO_ID	number(9)	NOT NULL,
	USE_ID	number(9)	NOT NULL
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE XXX_GROUPS
	ADD CONSTRAINT CSR_PK_XXX_GROUPS
	PRIMARY KEY (XXX_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							FOREIGN KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE XXX_GROUPS
	ADD CONSTRAINT CSR_FK_1_XXX_GROUPS
	FOREIGN KEY (GRO_ID)
	REFERENCES GROUPS (GRO_ID);
	
ALTER TABLE XXX_GROUPS
	ADD CONSTRAINT CSR_FK_2_XXX_GROUPS
	FOREIGN KEY (USE_ID)
	REFERENCES USERS (USE_ID);
	
PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE ACCESS_CONTROL;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE ACCESS_CONTROL
(
	ACC_ID	number(9)	NOT NULL,
	RES_ID	number(9)	NOT NULL,
	USE_ID	number(9)	NOT NULL,
	ACC_CHMOD	VARCHAR2(3)	NOT NULL
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE ACCESS_CONTROL
	ADD CONSTRAINT CSR_PK_ACCESS_CONTROL
	PRIMARY KEY (ACC_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							FOREIGN KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE ACCESS_CONTROL
	ADD CONSTRAINT CSR_FK_1_ACCESS_CONTROL
	FOREIGN KEY (RES_ID)
	REFERENCES RESOURCES (RES_ID);
	
ALTER TABLE ACCESS_CONTROL
	ADD CONSTRAINT CSR_FK_2_ACCESS_CONTROL
	FOREIGN KEY (USE_ID)
	REFERENCES USERS (USE_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE ZZZ_GROUPS_ROLES;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE ZZZ_GROUPS_ROLES
(
	ZZZ_ID	number(9)	NOT NULL,
	GRO_ID	number(9)	NOT NULL,
	ROL_ID	number(9)	NOT NULL
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE ZZZ_GROUPS_ROLES
	ADD CONSTRAINT CSR_PK_ZZZ_GROUPS_ROLES
	PRIMARY KEY (ZZZ_ID);

PROMPT ;
PROMPT ----------------------------------;
PROMPT 							FOREIGN KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE ZZZ_GROUPS_ROLES
	ADD CONSTRAINT CSR_FK_1_ZZZ_GROUPS_ROLES
	FOREIGN KEY (GRO_ID)
	REFERENCES GROUPS (GRO_ID);
	
ALTER TABLE ZZZ_GROUPS_ROLES
	ADD CONSTRAINT CSR_FK_2_ZZZ_GROUPS_ROLES
	FOREIGN KEY (ROL_ID)
	REFERENCES ROLES (ROL_ID);
	
PROMPT ;
PROMPT ----------------------------------;
PROMPT CREATE TABLE LOGS;
PROMPT ----------------------------------;
PROMPT ;
CREATE TABLE LOGS
(
	LOG_ID	number(9)	NOT NULL,
	LOG_DATE	date	NOT NULL,
	LOG_WHO		varchar2(30)	NOT NULL,
	LOG_MESSAGE	varchar2(150)	NOT NULL
);
--TABLSPACE STUDENT_DATA
PROMPT ;
PROMPT ----------------------------------;
PROMPT 							PRIMARY KEY;
PROMPT ----------------------------------;
PROMPT ;
ALTER TABLE LOGS
	ADD CONSTRAINT CSR_PK_LOGS
	PRIMARY KEY (LOG_ID);
	
PROMPT----------------------------;
PROMPT	SEQUENCE;
PROMPT----------------------------;
DROP SEQUENCE SEQ_ZZZ_GROUPS_ROLES;
CREATE SEQUENCE SEQ_ZZZ_GROUPS_ROLES INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;	

DROP SEQUENCE SEQ_ACCESS_CONTROL;
CREATE SEQUENCE SEQ_ACCESS_CONTROL INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;	

DROP SEQUENCE SEQ_XXX_GROUPS;
CREATE SEQUENCE SEQ_XXX_GROUPS INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;	

DROP SEQUENCE SEQ_YYY_ROLES;
CREATE SEQUENCE SEQ_YYY_ROLES INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;

DROP SEQUENCE SEQ_NOTIFICATIONS;
CREATE SEQUENCE SEQ_NOTIFICATIONS INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;	

DROP SEQUENCE SEQ_USERS;
CREATE SEQUENCE SEQ_USERS INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;	

DROP SEQUENCE SEQ_RESOURCES;
CREATE SEQUENCE SEQ_RESOURCES INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;	

DROP SEQUENCE SEQ_GROUPS;
CREATE SEQUENCE SEQ_GROUPS INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;	

DROP SEQUENCE SEQ_ROLES;
CREATE SEQUENCE SEQ_ROLES INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;	

DROP SEQUENCE SEQ_CATEGORY_OF_NOTIFICATION;
CREATE SEQUENCE SEQ_CATEGORY_OF_NOTIFICATION INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;	

DROP SEQUENCE SEQ_TYPE_USER;
CREATE SEQUENCE SEQ_TYPE_USER INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;

DROP SEQUENCE SEQ_LOGS;
CREATE SEQUENCE SEQ_LOGS INCREMENT BY 1 START WITH 1 MAXVALUE 999999999 MINVALUE 1;

PROMPT----------------------------;
PROMPT	TRIGGER;
PROMPT----------------------------;

CREATE OR REPLACE TRIGGER T_BI_ZZZ_GROUPS_ROLES
	BEFORE INSERT ON ZZZ_GROUPS_ROLES
	FOR EACH ROW
		BEGIN
			IF :new.ZZZ_ID is NULL then
				SELECT SEQ_ZZZ_GROUPS_ROLES.nextval INTO :new.ZZZ_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_ACCESS_CONTROL
	BEFORE INSERT ON ACCESS_CONTROL
	FOR EACH ROW
		BEGIN
			IF :new.ACC_ID is NULL then
				SELECT SEQ_ACCESS_CONTROL.nextval INTO :new.ACC_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_XXX_GROUPS
	BEFORE INSERT ON XXX_GROUPS
	FOR EACH ROW
		BEGIN
			IF :new.XXX_ID is NULL then
				SELECT SEQ_XXX_GROUPS.nextval INTO :new.XXX_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_YYY_ROLES
	BEFORE INSERT ON YYY_ROLES
	FOR EACH ROW
		BEGIN
			IF :new.YYY_ID is NULL then
				SELECT SEQ_YYY_ROLES.nextval INTO :new.YYY_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_NOTIFICATIONS
	BEFORE INSERT ON NOTIFICATIONS
	FOR EACH ROW
		BEGIN
			IF :new.NOT_ID is NULL then
				SELECT SEQ_NOTIFICATIONS.nextval INTO :new.NOT_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_USERS
	BEFORE INSERT ON USERS
	FOR EACH ROW
		BEGIN
			IF :new.USE_ID is NULL then
				SELECT SEQ_USERS.nextval INTO :new.USE_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_RESOURCES
	BEFORE INSERT ON RESOURCES
	FOR EACH ROW
		BEGIN
			IF :new.RES_ID is NULL then
				SELECT SEQ_RESOURCES.nextval INTO :new.RES_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_GROUPS
	BEFORE INSERT ON GROUPS
	FOR EACH ROW
		BEGIN
			IF :new.GRO_ID is NULL then
				SELECT SEQ_GROUPS.nextval INTO :new.GRO_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_ROLES
	BEFORE INSERT ON ROLES
	FOR EACH ROW
		BEGIN
			IF :new.ROL_ID is NULL then
				SELECT SEQ_ROLES.nextval INTO :new.ROL_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_CATEGORY_OF_NOTIFICATION
	BEFORE INSERT ON CATEGORY_OF_NOTIFICATION
	FOR EACH ROW
		BEGIN
			IF :new.CAT_ID is NULL then
				SELECT SEQ_CATEGORY_OF_NOTIFICATION.nextval INTO :new.CAT_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_TYPE_USER
	BEFORE INSERT ON TYPE_USER
	FOR EACH ROW
		BEGIN
			IF :new.TYP_ID is NULL then
				SELECT SEQ_TYPE_USER.nextval INTO :new.TYP_ID FROM dual;
			END IF;
		end;
/

CREATE OR REPLACE TRIGGER T_BI_LOGS
	BEFORE INSERT ON LOGS
	FOR EACH ROW
		BEGIN
			IF :new.LOG_ID is NULL then
				SELECT SEQ_LOGS.nextval INTO :new.LOG_ID FROM dual;
			END IF;
		end;
/

-- AI TRIGGERS----------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER T_AI_USERS
	AFTER INSERT ON USERS
	FOR EACH ROW
		BEGIN
			INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE) VALUES(SYSDATE, USER, 'Added new user : '||:new.USE_ID||', '||:new.USE_NAME||', '||:new.USE_EMAIL);
		end;
/

CREATE OR REPLACE TRIGGER T_AI_GROUPS
	AFTER INSERT ON GROUPS
	FOR EACH ROW
		BEGIN
			INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE) VALUES(SYSDATE, USER, 'Added new group : '||:new.GRO_ID||', '||:new.GRO_NAME);
		end;
/

CREATE OR REPLACE TRIGGER T_AI_ROLES
	AFTER INSERT ON ROLES
	FOR EACH ROW
		BEGIN
			INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE) VALUES(SYSDATE, USER, 'Added new role : '||:new.ROL_ID||', '||:new.ROL_NAME);
		end;
/

-- AU TRIGGERS----------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER T_AU_USERS
	AFTER UPDATE ON USERS
	FOR EACH ROW
		BEGIN
			INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE) VALUES(SYSDATE, USER, 'User '||:old.USE_ID||':'
							||:old.USE_NAME||'->'||:new.USE_NAME||', '
							||:old.USE_SURNAME||'->'||:new.USE_SURNAME||', '
							||:old.USE_NICKNAME||'->'||:new.USE_NICKNAME||', '
							||:old.USE_EMAIL||'->'||:new.USE_EMAIL||', '
							||:old.USE_PHONE||'->'||:new.USE_PHONE);
		end;
/

CREATE OR REPLACE TRIGGER T_AU_GROUPS
	AFTER UPDATE ON GROUPS
	FOR EACH ROW
		BEGIN
			INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE) VALUES(SYSDATE, USER, 'Group '||:old.GRO_ID||':'
							||:old.GRO_NAME||'->'||:new.GRO_NAME||', '
							||:old.GRO_DESCRIPTION||'->'||:new.GRO_DESCRIPTION);
		end;
/

CREATE OR REPLACE TRIGGER T_AU_ROLES
	AFTER UPDATE ON ROLES
	FOR EACH ROW
		BEGIN
			INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE) VALUES(SYSDATE, USER, 'User '||:old.ROL_ID||':'
							||:old.ROL_NAME||'->'||:new.ROL_NAME||', '
							||:old.ROL_DESCRIPTION||'->'||:new.ROL_DESCRIPTION);
		end;
/

-- AD TRIGGERS----------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER T_AD_USERS
	AFTER DELETE ON USERS
	FOR EACH ROW
		BEGIN
			INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE) VALUES(SYSDATE, USER, 'Deleted user (USE_ID = '||:old.USE_ID||')');
		end;
/

CREATE OR REPLACE TRIGGER T_AD_GROUPS
	AFTER DELETE ON GROUPS
	FOR EACH ROW
		BEGIN
			INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE) VALUES(SYSDATE, USER, 'Deleted group (GRO_ID = '||:old.GRO_ID||')');
		end;
/

CREATE OR REPLACE TRIGGER T_AD_ROLES
	AFTER DELETE ON ROLES
	FOR EACH ROW
		BEGIN
			INSERT INTO LOGS(LOG_DATE, LOG_WHO, LOG_MESSAGE) VALUES(SYSDATE, USER, 'Deleted role (ROL_ID = '||:old.ROL_ID||')');
		end;
/

	DESCRIBE ZZZ_GROUPS_ROLES;
	DESCRIBE ACCESS_CONTROL;
	DESCRIBE XXX_GROUPS;
	DESCRIBE YYY_ROLES;
	DESCRIBE NOTIFICATIONS;
	DESCRIBE USERS;
	DESCRIBE RESOURCES;
	DESCRIBE GROUPS
	DESCRIBE ROLES;
	DESCRIBE CATEGORY_OF_NOTIFICATION;
	DESCRIBE TYPE_USER;
	DESCRIBE LOGS;
		
-- end of script
INSERT INTO TYPE_USER(TYP_NAME, TYP_DESCRIPTION) VALUES ('Admin', 'System administrator');
INSERT INTO TYPE_USER(TYP_NAME, TYP_DESCRIPTION) VALUES ('User', 'User with standard permissions');
INSERT INTO TYPE_USER(TYP_NAME, TYP_DESCRIPTION) VALUES ('Guest', 'User without permissions');

INSERT INTO CATEGORY_OF_NOTIFICATION(CAT_NAME, CAT_DESCRIPTION) VALUES ('Warning', 'Defines an event that does not impact the stability of the system');
INSERT INTO CATEGORY_OF_NOTIFICATION(CAT_NAME, CAT_DESCRIPTION) VALUES ('Error', 'Defines an event that could cause an impact on the stability');
INSERT INTO CATEGORY_OF_NOTIFICATION(CAT_NAME, CAT_DESCRIPTION) VALUES ('Severe', 'Defines an event that impacts system stability');

INSERT INTO USERS(USE_NICKNAME, USE_NAME, USE_SURNAME, USE_EMAIL, USE_PHONE, TYP_ID) VALUES ('Janusz', 'Janusz', 'Kowalski', 'janusz@janusze.pl', '22323141', 1);
INSERT INTO USERS(USE_NICKNAME, USE_NAME, USE_SURNAME, USE_EMAIL, USE_PHONE, TYP_ID) VALUES ('pnowak', 'Piotr', 'Nowak', 'piotr@nowaki.pl', '0048191234', 2);
INSERT INTO USERS(USE_NICKNAME, USE_NAME, USE_SURNAME, USE_EMAIL, USE_PHONE, TYP_ID) VALUES ('tomex', 'Tomasz', 'Kowalski', 'tomasz@janusze.pl', '111244333', 2);

INSERT INTO RESOURCES(RES_URI, RES_TYPE, RES_NOTE) VALUES ('http:/onet.pl/index.html', 'FILE', 'Onet - Index website');
INSERT INTO RESOURCES(RES_URI, RES_TYPE, RES_NOTE) VALUES ('http:/google.pl/files', 'DIRECTORY', 'Files directory at google');
INSERT INTO RESOURCES(RES_URI, RES_TYPE, RES_NOTE) VALUES ('192.168.1.1:8090', 'SERVICE', 'NTP Service');

INSERT INTO ROLES(ROL_NAME, ROL_DESCRIPTION) VALUES ('Printing operator', 'Entities allowed to operate printers');
INSERT INTO ROLES(ROL_NAME, ROL_DESCRIPTION) VALUES ('Cryptography manager', 'Entities allowed to configure cryptographic protocols');
INSERT INTO ROLES(ROL_NAME, ROL_DESCRIPTION) VALUES ('Research project stakeholders', 'Entities allowed to view researches results');
INSERT INTO ROLES(ROL_NAME, ROL_DESCRIPTION) VALUES ('Researchers', 'Entities allowed participate in researches');

INSERT INTO NOTIFICATIONS(NOT_CONTENT, NOT_DATE, USE_ID, CAT_ID) VALUES ('Login from untrusted platform', '2018-01-01', 1, 2);

INSERT INTO GROUPS(GRO_NAME, GRO_DESCRIPTION) VALUES ('Users', 'Regular users');
INSERT INTO GROUPS(GRO_NAME, GRO_DESCRIPTION) VALUES ('Research project 1', 'First research team');

INSERT INTO XXX_GROUPS(USE_ID, GRO_ID) VALUES(1,2);
INSERT INTO XXX_GROUPS(USE_ID, GRO_ID) VALUES(2,2);

INSERT INTO YYY_ROLES(USE_ID, ROL_ID) VALUES (1,2);
INSERT INTO YYY_ROLES(USE_ID, ROL_ID) VALUES (2,3);

INSERT INTO ZZZ_GROUPS_ROLES(GRO_ID, ROL_ID) VALUES (2, 4);

INSERT INTO ACCESS_CONTROL(USE_ID, RES_ID, ACC_CHMOD) VALUES (1, 3, 'RWX');
INSERT INTO ACCESS_CONTROL(USE_ID, RES_ID, ACC_CHMOD) VALUES (1, 2, 'RWX');
INSERT INTO ACCESS_CONTROL(USE_ID, RES_ID, ACC_CHMOD) VALUES (1, 1, 'RWX');
INSERT INTO ACCESS_CONTROL(USE_ID, RES_ID, ACC_CHMOD) VALUES (2, 1, 'R--');
INSERT INTO ACCESS_CONTROL(USE_ID, RES_ID, ACC_CHMOD) VALUES (2, 2, 'RW-');
INSERT INTO ACCESS_CONTROL(USE_ID, RES_ID, ACC_CHMOD) VALUES (2, 3, 'R--');
INSERT INTO ACCESS_CONTROL(USE_ID, RES_ID, ACC_CHMOD) VALUES (3, 1, 'RWX');
INSERT INTO ACCESS_CONTROL(USE_ID, RES_ID, ACC_CHMOD) VALUES (3, 2, 'RWX');
INSERT INTO ACCESS_CONTROL(USE_ID, RES_ID, ACC_CHMOD) VALUES (3, 3, 'R--');

-- VIEWS -------------------------------------------------------
CREATE OR REPLACE VIEW V_USERNAMES_ACL AS
		SELECT U.USE_NAME, A.ACC_CHMOD
		FROM USERS U, ACCESS_CONTROL A
		WHERE U.USE_ID=A.USE_ID;
		
CREATE OR REPLACE VIEW V_USERNAMES_ACL_COUNT AS
		SELECT U.USE_NAME, X.COUNTER
		FROM (
			SELECT USE_ID, COUNT(ACC_CHMOD) AS COUNTER
			FROM ACCESS_CONTROL
			GROUP BY USE_ID
		) X, USERS U
		WHERE U.USE_ID=X.USE_ID;
		
select * from V_USERNAMES_ACL_COUNT;
/*
Imię użytkownika        COUNTER
-------------------- ----------
Tomasz                        3
Piotr                         3
Janusz                        3
*/

CREATE OR REPLACE VIEW V_USERS_RES_ACL AS
	SELECT U.USE_NAME, U.USE_EMAIL, X.RES_URI, X.ACC_CHMOD
	FROM (
		SELECT R.RES_URI, A.ACC_CHMOD, A.USE_ID
			FROM RESOURCES R, ACCESS_CONTROL A
		WHERE R.RES_ID = A.RES_ID
	) X, USERS U
	WHERE U.USE_ID = X.USE_ID;

	
/*
Imię użytkownika     E-mail               Zasób                Pra
-------------------- -------------------- -------------------- ---
Tomasz               tomasz@janusze.pl    192.168.1.1:8090     R--
Piotr                piotr@nowaki.pl      192.168.1.1:8090     R--
Janusz               janusz@janusze.pl    192.168.1.1:8090     RWX
Tomasz               tomasz@janusze.pl    http:/google.pl/file RWX
                                          s

Piotr                piotr@nowaki.pl      http:/google.pl/file RW-
                                          s

Janusz               janusz@janusze.pl    http:/google.pl/file RWX
                                          s

Imię użytkownika     E-mail               Zasób                Pra
-------------------- -------------------- -------------------- ---

Tomasz               tomasz@janusze.pl    http:/onet.pl/index. RWX
                                          html

Piotr                piotr@nowaki.pl      http:/onet.pl/index. R--
                                          html

Janusz               janusz@janusze.pl    http:/onet.pl/index. RWX
                                          html
*/

CREATE OR REPLACE VIEW V_USERS_GROUPS AS
		SELECT U.USE_NAME, U.USE_NICKNAME, U.USE_SURNAME, U.USE_EMAIL, U.USE_PHONE, G.GRO_NAME
		FROM USERS U, GROUPS G, XXX_GROUPS X
		WHERE U.USE_ID=X.USE_ID AND X.GRO_ID=G.GRO_ID;
		
SELECT * FROM V_USERS_GROUPS;
/*
Imię użytkownika     USE_NICKNAME         USE_SURNAME                    E-mail               USE_PHONE        GRO_NAME
-------------------- -------------------- ------------------------------ -------------------- ---------------- -------------------
Janusz               Janusz               Kowalski                       janusz@janusze.pl    22323141         Research project 1
Piotr                pnowak               Nowak                          piotr@nowaki.pl      0048191234       Research project 1
Piotr                pnowak               Nowak                          piotr@nowaki.pl      0048191234       Users
*/

-- INDEX -------------------------------------------------------
DROP INDEX IX_USR_NAME;
DROP INDEX IX_ACC_CHMOD;

CREATE INDEX IX_USR_NAME
		ON USERS (USE_NAME)
		STORAGE (INITIAL 10k NEXT 10k)
		TABLESPACE STUDENT_INDEX;

CREATE INDEX IX_ACC_CHMOD
		ON ACCESS_CONTROL (ACC_CHMOD)
		STORAGE (INITIAL 10k NEXT 10k)
		TABLESPACE STUDENT_INDEX;

COLUMN USE_NAME HEADING 'Imię użytkownika' FORMAT A20
COLUMN USE_EMAIL HEADING 'E-mail' FORMAT A20
COLUMN RES_URI HEADING 'Zasób' FORMAT A20
COLUMN ACC_CHMOD HEADING 'Prawa' FORMAT A3
SELECT U.USE_NAME, U.USE_EMAIL, X.RES_URI, X.ACC_CHMOD
	FROM (
		SELECT R.RES_URI, A.ACC_CHMOD, A.USE_ID
			FROM RESOURCES R, ACCESS_CONTROL A
		WHERE R.RES_ID = A.RES_ID
	) X, USERS U
WHERE U.USE_ID = X.USE_ID;
/*
Imię użytkownika     E-mail               Zasób                Pra
-------------------- -------------------- -------------------- ---
Tomasz               tomasz@janusze.pl    192.168.1.1:8090     R--
Piotr                piotr@nowaki.pl      192.168.1.1:8090     R--
Janusz               janusz@janusze.pl    192.168.1.1:8090     RWX
Tomasz               tomasz@janusze.pl    http:/google.pl/file RWX
                                          s

Piotr                piotr@nowaki.pl      http:/google.pl/file RW-
                                          s

Janusz               janusz@janusze.pl    http:/google.pl/file RWX
                                          s

Imię użytkownika     E-mail               Zasób                Pra
-------------------- -------------------- -------------------- ---

Tomasz               tomasz@janusze.pl    http:/onet.pl/index. RWX
                                          html

Piotr                piotr@nowaki.pl      http:/onet.pl/index. R--
                                          html

Janusz               janusz@janusze.pl    http:/onet.pl/index. RWX
                                          html
*/

-- GENERATORY ----------------------------------------------------------
DROP SEQUENCE SEQ_USR_GENERATOR;
CREATE SEQUENCE SEQ_USR_GENERATOR INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;

CREATE or REPLACE PROCEDURE USE_insert(ile IN number)
	IS
		licznik number(2);
		offset number(6);
		BEGIN
			licznik := 1;
			SELECT SEQ_USR_GENERATOR.nextval INTO offset FROM dual;
			WHILE licznik < ile+1
			LOOP
				INSERT INTO USERS
				(USE_NAME, USE_NICKNAME, USE_SURNAME, USE_EMAIL, USE_PHONE, TYP_ID)
				VALUES ('Janusz','JK'||(licznik+offset*100), 'Kowalski'||(licznik+offset*100) , 'janusz'||(licznik+offset*100)||'@abc.pl', (licznik+offset*100), 2);
				licznik := licznik + 1;
			END LOOP;
		END;
/

BEGIN
	USE_insert(10);
END;
/*
USE_ID USE_NICKNAME         Imię użytkownika     USE_SURNAME                    E-mail              
------ -------------------- -------------------- ------------------------------ --------------------
     1 Janusz               Janusz               Kowalski                       janusz@janusze.pl   
     2 pnowak               Piotr                Nowak                          piotr@nowaki.pl     
     3 tomex                Tomasz               Kowalski                       tomasz@janusze.pl   
     4 JK101                Janusz               Kowalski101                    janusz101@abc.pl    
     5 JK102                Janusz               Kowalski102                    janusz102@abc.pl    
     6 JK103                Janusz               Kowalski103                    janusz103@abc.pl    
     7 JK104                Janusz               Kowalski104                    janusz104@abc.pl    
     8 JK105                Janusz               Kowalski105                    janusz105@abc.pl    
     9 JK106                Janusz               Kowalski106                    janusz106@abc.pl    
    10 JK107                Janusz               Kowalski107                    janusz107@abc.pl    
    11 JK108                Janusz               Kowalski108                    janusz108@abc.pl    
*/

DROP SEQUENCE SEQ_GRO_GENERATOR;
CREATE SEQUENCE SEQ_GRO_GENERATOR INCREMENT BY 1 START WITH 1 MAXVALUE 999999 MINVALUE 1;

CREATE or REPLACE PROCEDURE GRO_insert(ile IN number)
	IS
		licznik number(2);
		offset number(6);
		BEGIN
			licznik := 1;
			SELECT SEQ_GRO_GENERATOR.nextval INTO offset FROM dual;
			WHILE licznik < ile+1
			LOOP
				INSERT INTO GROUPS
				(GRO_NAME, GRO_DESCRIPTION)
				VALUES ('Users'||(licznik+offset*100), 'Grupa użytkowników numer '||(licznik+offset*100)||' o niestandardowej definicji');
				licznik := licznik + 1;
			END LOOP;
		END;
/

BEGIN
	GRO_insert(10);
END;
/*
 GRO_ID GRO_NAME                       GRO_DESCRIPTION
------- ------------------------------ ----------------------------------------------
      1 Users                          Regular users
      2 Research project 1             First research team
      3 Users101                       Grupa użytkowników numer 101 o niestandardowej
      4 Users102                       Grupa użytkowników numer 102 o niestandardowej
      5 Users103                       Grupa użytkowników numer 103 o niestandardowej
      6 Users104                       Grupa użytkowników numer 104 o niestandardowej
      7 Users105                       Grupa użytkowników numer 105 o niestandardowej
	  ...
*/

commit;