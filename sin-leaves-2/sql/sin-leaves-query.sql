-- Query leaves difference - SINGAPORE


-- al leave request
drop table if exists sin_leave_request_temp;

create table sin_leave_request_temp 
as SELECT "Emp No" as id,
           trim("Emp Name") as name,
           "Leave" as type,
           date( "Start Date" ) as date,
           CAST("Day" as decimal) as days
      FROM sin_leave_request
      where Day < 1
  union all
  select id, name, type, date, days from (
      SELECT "Emp No" as id,
               trim("Emp Name") as name,
               "Leave" as type,
               date( "Start Date" ) as startdate,
               date( "End Date" ) as enddate,
               date( "Start Date", '+' || n || ' day' ) as date,
               1 as days
          FROM sin_leave_request, integers
          where Day >= 1
              and date <= enddate
              and strftime('%w', date) between '1' and '5'
      )
;


-- al ts entry
drop table if exists sin_ts_entry_temp;

create table sin_ts_entry_temp 
as SELECT "Personnel Number" as id,
           trim("Name of Employee or Applicant") as name,
           "Leave" as type,
           date( "Date" ) as date,
           case when CAST("Number (unit)" as decimal) <= 4.3 then 0.5 else 1 end as days
      FROM sin_ts_entry
;


-- Compare
select type, id, name, date,
    (select days from sin_leave_request_temp where id = t.id and type = t.type and date = t.date ) as leave_request,
    (select days from sin_ts_entry_temp where id = t.id and type = t.type and date = t.date ) as ts_entry
 from (
    select id, name, type, date 
    from sin_leave_request_temp
    union
    select id, name, type, date 
    from sin_ts_entry_temp
    ) as t
order by type, id, date
;
