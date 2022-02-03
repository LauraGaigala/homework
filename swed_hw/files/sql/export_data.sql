set markup csv on
set feedback off
alter session set nls_date_format='dd.mm.yyyy hh24:mi:ss';
spool "/opt/oracle/gathered_data.csv"
select * from homework_data fetch  first 100 rows only;
spool off;
exit;
