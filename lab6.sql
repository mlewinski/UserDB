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
		for dane in (select USE_NAME from USERS where USE_NAME like 'Uzytkownik')
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
