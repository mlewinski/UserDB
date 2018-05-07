@'E:\Bazy danych\lab5b.sql'

CLEAR SCREEN;
SET LINESIZE 230;
alter session set nls_date_format="YYYY-MM-DD";

CREATE or REPLACE PROCEDURE pSEQ_USE_GRO_insert(
	U_NAME IN USERS.USE_NAME%TYPE,
	U_NICKNAME IN USERS.USE_NICKNAME%TYPE,
	U_SURNAME IN USERS.USE_SURNAME%TYPE,
	U_EMAIL IN USERS.USE_EMAIL%TYPE,
	U_PHONE IN USERS.USE_PHONE%TYPE
	)
	IS
		U_ID	USERS.USE_ID%TYPE;
		G_ID	GROUPS.GRO_ID%TYPE;
		U_OFFSET	NUMBER(6);
		PRAGMA AUTONOMOUS_TRANSACTION;
	BEGIN
			SELECT SEQ_USR_GENERATOR.nextval INTO U_OFFSET FROM dual;
			INSERT INTO USERS(USE_NAME, USE_NICKNAME, USE_SURNAME, USE_EMAIL, USE_PHONE, TYP_ID)
			VALUES (U_NAME, U_NICKNAME||U_OFFSET, U_SURNAME, U_EMAIL, U_PHONE, 2);
			--
			SELECT SEQ_USERS.currval INTO U_ID FROM dual;
			--
			INSERT INTO GROUPS(GRO_NAME, GRO_DESCRIPTION)
			VALUES (U_NICKNAME||U_OFFSET, 'Private group of '||U_NICKNAME);
			--
			SELECT SEQ_GROUPS.currval INTO G_ID FROM dual;
			--
			INSERT INTO XXX_GROUPS(USE_ID, GRO_ID)
			VALUES(U_ID, G_ID);
			COMMIT;
	END;
/
/*
Imiê u¿ytkownika     USE_NICKNAME         USE_SURNAME                    E-mail               USE_PHONE        GRO_NAME
-------------------- -------------------- ------------------------------ -------------------- ---------------- -------------------
Janusz               Janusz               Kowalski                       janusz@janusze.pl    22323141         Research project 1
Piotr                pnowak               Nowak                          piotr@nowaki.pl      0048191234       Research project 1
Piotr                pnowak               Nowak                          piotr@nowaki.pl      0048191234       Users
*/
exec pSEQ_USE_GRO_insert('Piotr','pietrek','piotrowski', 'p1@p2.pl', '123455777', 'pietrek');

SELECT * FROM V_USERS_GROUPS;
/*
Imiê u¿ytkownika     USE_NICKNAME         USE_SURNAME                    E-mail               USE_PHONE        GRO_NAME
-------------------- -------------------- ------------------------------ -------------------- ---------------- -----------------------
Janusz               Janusz               Kowalski                       janusz@janusze.pl    22323141         Research project 1
Piotr                pnowak               Nowak                          piotr@nowaki.pl      0048191234       Research project 1
Piotr                pnowak               Nowak                          piotr@nowaki.pl      0048191234       Users
Piotr                pietrek              piotrowski                     p1@p2.pl             123455777        pietrek
*/

CREATE or REPLACE PROCEDURE pRET_USE_GRO_insert(
	U_NAME IN USERS.USE_NAME%TYPE,
	U_NICKNAME IN USERS.USE_NICKNAME%TYPE,
	U_SURNAME IN USERS.USE_SURNAME%TYPE,
	U_EMAIL IN USERS.USE_EMAIL%TYPE,
	U_PHONE IN USERS.USE_PHONE%TYPE
	)
	IS
		U_ID	USERS.USE_ID%TYPE;
		G_ID	GROUPS.GRO_ID%TYPE;
		U_OFFSET	NUMBER(6);
		PRAGMA AUTONOMOUS_TRANSACTION;
	BEGIN
			SELECT SEQ_USR_GENERATOR.nextval INTO U_OFFSET FROM dual;
			INSERT INTO USERS(USE_NAME, USE_NICKNAME, USE_SURNAME, USE_EMAIL, USE_PHONE, TYP_ID)
			VALUES (U_NAME, U_NICKNAME||U_OFFSET, U_SURNAME, U_EMAIL, U_PHONE, 2)
			RETURNING USE_ID INTO U_ID;
			INSERT INTO GROUPS(GRO_NAME, GRO_DESCRIPTION)
			VALUES (U_NICKNAME||U_OFFSET, 'Private group of '||U_NICKNAME)
			RETURNING GRO_ID INTO G_ID;
			INSERT INTO XXX_GROUPS(USE_ID, GRO_ID)
			VALUES(U_ID, G_ID);
			COMMIT;
	END;
/
exec pRET_USE_GRO_insert('Piotr','pi','piotrowski', 'p1@p2.pl', '123455777');