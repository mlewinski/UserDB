--@'C:\Files\Repositories\UserDB\lab6.sql'

create or replace procedure
	pUSER_update (name in varchar2, new_name in varchar2)
	is
		xUName USERS.USE_NAME%TYPE;
		
		cursor USERS_cursor
		is
			select USE_NAME
			from USERS
			where USE_NAME=name
		for update of USE_NAME;
			
		begin
			open USERS_cursor;
			loop
				fetch USERS_cursor into xUName;
				exit when
					USERS_cursor%NOTFOUND OR USERS_cursor%ROWCOUNT < 1;
					
				update USERS
				set USE_NAME=new_name
				where current of USERS_cursor;
				
			end loop;
				
			close USERS_cursor;
		exception
			when others 
				then
					dbms_output.put_line('Kursor nie zostal znaleziony');
		end;
/
select USE_NAME from USERS;
/*
	USE_NAME
	------------------------------
	Imie
	Imie
	Imie
	Imie

	USE_NAME
	------------------------------
	Piotr
	Tomasz
	Uzytkownik
	Uzytkownik
*/
exec pUSER_update('Imie', 'No name');
select USE_NAME from USERS;
/*
	USE_NAME
	------------------------------
	No name
	No name
	No name
	No name

	USE_NAME
	------------------------------
	Piotr
	Tomasz
	Uzytkownik
	Uzytkownik
*/

create or replace procedure
	pN_USER_update (name in varchar2, new_name in varchar2)
	is
	begin
		for dane in (select USE_NAME from USERS where USE_NAME like name)
			loop
				exit when
					SQL%NOTFOUND OR
					SQL%ROWCOUNT < 1;
				dbms_output.put_line('test');
				update USERS
				set USE_NAME=new_name
				where USE_NAME like name;
			end loop;
		exception
			when others
				then
					dbms_output.put_line('Kursor nie zostal znaleziony');
		end;
/
/*
	USE_NAME
	------------------------------
	Imie
	Imie
	Imie

	USE_NAME
	------------------------------
	Piotr
	Tomasz
	Uzytkownik
	Uzytkownik
	Uzytkownik
*/
exec pN_USER_update('Imie', 'No name');
/*
    USE_ID USE_NAME
---------- ------------------------------
         1 No name
         4 No name
         5 No name
         6 No name
         7 No name
         8 No name
         9 No name
        10 No name
        11 No name
        12 No name
        13 No name

    USE_ID USE_NAME
---------- ------------------------------
         2 Piotr
         3 Tomasz
        14 Uzytkownik
        15 Uzytkownik
*/

---------------------------------------------------------------------
CREATE or REPLACE PROCEDURE pINSERT_GROUP(G_NAME IN VARCHAR2, G_DESC IN VARCHAR2)
IS
	insert_query VARCHAR(500); 
BEGIN
	insert_query := 'INSERT INTO GROUPS(GRO_NAME, GRO_DESCRIPTION) VALUES (:1, :2)';
	EXECUTE IMMEDIATE insert_query USING G_NAME, G_DESC;
    
END;
/

exec pINSERT_GROUP('Nowa grupa dynamiczna','Grupa utworzona dynamicznym zapytaniem SQL');

/*
	22 user11 Private group of user
	41 Nowa grupa dynamiczna Grupa utworzona dynamicznym zapytaniem SQL
*/