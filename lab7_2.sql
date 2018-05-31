
CLEAR SCREEN;
SET LINESIZE 230;

alter session set nls_date_format="YYYY-MM-DD";

create or replace procedure
	pUSER_Validate_Length
	is
			length_below_zero exception;
			PRAGMA EXCEPTION_INIT(length_below_zero, -20005);
			
			type r_record is record (
				rol_id		number,
				rol_name	varchar2
			);
			type user_record is record (
				u_id 		number,
				u_nickname 	varchar2,
				u_role#		r_record
			);
			--
			
			cursor USERS_cursor
			is
				select use_id, use_nickname
				from USERS;
				
			user_tmp 		user_record;
			user_role_id	roles.rol_id%type;
				
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
					SELECT ROL_ID INTO user_role_id
					FROM USERS
					WHERE USE_ID=user_tmp.use_id;
					SELECT ROL_ID, ROL_NAME INTO user_tmp.u_role#
					FROM ROLES
					WHERE ROL_ID=user_role_id;
					INSERT INTO NOTIFICATIONS(NOT_CONTENT, NOT_DATE, USE_ID, CAT_ID)
					VALUES ('User''s nickname is too short : '
					||user_tmp.u_nickname
					||', user-role : '
					||user_tmp.u_role#.rol_id
					||'-'||user_tmp.u_role#.rol_name
					, SYSDATE, user_tmp.u_id, 2);
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
/*
    NOT_ID Content                                                               USE_ID
---------- --------------------------------------------------------------------- ----------
         1 Login from untrusted platform                                                  1
        21 User's nickname is too short : to1                                            41
        22 User's nickname is too short : to1, user-role : 4-Researchers                 41
        23 User's nickname is too short : to2, user-role : 4-Researchers                 42
*/