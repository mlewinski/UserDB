--@'E:\Bazy danych\lab5b.sql'

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
exec pSEQ_USE_GRO_insert('Piotr','pietrek','piotrowski', 'p1@p2.pl', '123455777');

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

/*
Imiê u¿ytkownika     USE_NICKNAME         USE_SURNAME                    E-mail               USE_PHONE        GRO_NAME
-------------------- -------------------- ------------------------------ -------------------- ---------------- ------------------------------------------------------------
Janusz               Janusz               Kowalski                       janusz@janusze.pl    22323141         Research project 1
Piotr                pnowak               Nowak                          piotr@nowaki.pl      0048191234       Research project 1
Piotr                pi2                  piotrowski                     p1@p2.pl             123455777        pi2
Piotr                pietrek3             piotrowski                     p1@p2.pl             123455777        pietrek3
Piotr                pi4                  piotrowski                     p1@p2.pl             123455777        pi4
Piotr                pietrek5             piotrowski                     p1@p2.pl             123455777        pietrek5
*/

exec pRET_USE_GRO_insert('Piotr','pi','piotrowski', 'p1@p2.pl', '123455777');

/*
Imie uzytkownika     USE_NICKNAME         USE_SURNAME                    E-mail               USE_PHONE        GRO_NAME
-------------------- -------------------- ------------------------------ -------------------- ---------------- ------------------------------------------------------------
Janusz               Janusz               Kowalski                       janusz@janusze.pl    22323141         Research project 1
Piotr                pnowak               Nowak                          piotr@nowaki.pl      0048191234       Research project 1
Piotr                pi2                  piotrowski                     p1@p2.pl             123455777        pi2
Piotr                pietrek3             piotrowski                     p1@p2.pl             123455777        pietrek3
Piotr                pi4                  piotrowski                     p1@p2.pl             123455777        pi4
Piotr                pietrek5             piotrowski                     p1@p2.pl             123455777        pietrek5
Piotr                pi6                  piotrowski                     p1@p2.pl             123455777        pi6				<--- dodany u¿ytkownik
*/

CREATE OR REPLACE PROCEDURE pUSE_GRO_insert(ile IN NUMBER)
	AS
		licznik number(2);
		BEGIN
			licznik := 1;
			DBMS_RANDOM.INITIALIZE(999999999);
			WHILE licznik < ile+1
			LOOP
				pRET_USE_GRO_insert('Uzytkownik', 'user', 'Nazwisko', 'user@users.net', DBMS_RANDOM.VALUE(0, 999999999));
				licznik:=licznik+1;
			END LOOP;
		END;
/

/*
SQL> select * from v_users_groups;

Imie uzytkownika     USE_NICKNAME         USE_SURNAME                    E-mail                USE_PHONE GRO_NAME
-------------------- -------------------- ------------------------------ -------------------- ---------- ------------------------------------------------------------
Janusz               Janusz               Kowalski                       janusz@janusze.pl      22323141 Research project 1
Piotr                pnowak               Nowak                          piotr@nowaki.pl        48191234 Research project 1
Uzytkownik           user2                Nazwisko                       user@users.net        173669615 user2
Uzytkownik           user3                Nazwisko                       user@users.net        216134209 user3
Uzytkownik           user4                Nazwisko                       user@users.net        155345472 user4
Uzytkownik           user5                Nazwisko                       user@users.net         90285469 user5
Uzytkownik           user6                Nazwisko                       user@users.net        259479504 user6
Uzytkownik           user7                Nazwisko                       user@users.net        555382933 user7
Uzytkownik           user8                Nazwisko                       user@users.net        241872662 user8
Uzytkownik           user9                Nazwisko                       user@users.net        970721722 user9
Uzytkownik           user10               Nazwisko                       user@users.net        289632772 user10

Imie uzytkownika     USE_NICKNAME         USE_SURNAME                    E-mail                USE_PHONE GRO_NAME
-------------------- -------------------- ------------------------------ -------------------- ---------- ------------------------------------------------------------
Uzytkownik           user11               Nazwisko                       user@users.net        706842968 user11
*/