
CLEAR SCREEN;
SET LINESIZE 230;
alter session set nls_date_format="YYYY-MM-DD";

create or replace procedure
	pUSER_Validate_Length
	is
		length_below_zero exception;
		PRAGMA EXCEPTION_INIT(length_below_zero, -20005);
		type user_record is record(
			u_id 		users.use_id%type,
			u_nickname 	users.use_nickname%type
		);
		
		cursor USERS_cursor
		is
			select use_id, use_nickname
			from USERS;
			
		user_tmp user_record;
			
		begin
			open USERS_cursor;
			loop
				fetch USERS_cursor into user_tmp;
				exit when
					USERS_cursor%NOTFOUND OR USERS_cursor%ROWCOUNT < 1;
				if LENGTH(user_tmp.u_nickname)=0
				then
					raise length_below_zero;
				end if;
				if LENGTH(user_tmp.u_nickname)<5
				then
					INSERT INTO NOTIFICATIONS(NOT_CONTENT, NOT_DATE, USE_ID, CAT_ID)
					VALUES ('User''s nickname is too short : '||user_tmp.u_nickname, SYSDATE, user_tmp.u_id, 2);
				end if;				
			end loop;
				
			close USERS_cursor;
		exception
			when length_below_zero
				then
					dbms_output.put_line('Natrafiono na uzytkownika o zerowej dlugosci nazwy');
			when others 
				then
					dbms_output.put_line('Kursor nie zostal znaleziony');
		end;
/
select * from NOTIFICATIONS;


exec pUSER_Validate_Length;
/*
    NOT_ID Content                                      USE_ID
---------- ---------------------------------------- ----------
         1 Login from untrusted platform                     1
        21 User's nickname is too short : to1               41
        22 User's nickname is too short : to1               41
        23 User's nickname is too short : to2               42
*/