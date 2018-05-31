CLEAR SCREEN;
SET LINESIZE 230;
alter session set nls_date_format="YYYY-MM-DD";


CREATE OR REPLACE PROCEDURE pUSE_random_insert(ile IN NUMBER)
	AS
		licznik number(2);
		type TNAMES is varray(8) of varchar(30);
		type TSURNAMES is varray(5) of varchar(30);
		tmp_name USERS.USE_NAME%type;
		tmp_surname USERS.USE_SURNAME%type;
		
		imiona TNAMES := TNames('Piotr','Pawel','Adam','Andrzej','Anna','Marek','Kuba', 'Ewa');
		nazwiska TSURNAMES := TSURNAMES('Kowal','Nowak','Ptak','Madeja','Kisiel');
		
		PRAGMA AUTONOMOUS_TRANSACTION;
		BEGIN
			licznik := 1;
			DBMS_RANDOM.INITIALIZE(999999999);
			WHILE licznik < ile+1
			LOOP
				tmp_name := imiona(dbms_random.value(0,8));
				tmp_surname := nazwiska(dbms_random.value(0,5));
				INSERT INTO USERS(
					USE_NICKNAME,
					USE_NAME,
					USE_SURNAME, 
					USE_EMAIL, 
					USE_PHONE, 
					TYP_ID)
				VALUES (tmp_name||floor(mod(timestamp(sysdate), 10)), tmp_name, tmp_surname, tmp_name||'.'||tmp_surname||'@user.pl', dbms_random.value(111111111,999999999), 1);
				licznik:=licznik+1;
			END LOOP;
			commit;
		exception
			when others then
				dbms_output.put_line('pUSE_random_insert : '||SQLERRM);
		END;
/

/*
		52 Pawel24              Pawel                          Ptak                           Pawel.Ptak@user.pl                               973974864          1
        53 Pawel44              Pawel                          Madeja                         Pawel.Madeja@user.pl                             705370351          1
        54 Adam98               Adam                           Kisiel                         Adam.Kisiel@user.pl                              159374119          1
        55 Kuba78               Kuba                           Ptak                           Kuba.Ptak@user.pl  
*/