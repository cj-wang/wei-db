-- Query leaves difference - AUSTRALIA


-- al leave request
drop table if exists al_leave_request_temp;

create table al_leave_request_temp 
as SELECT "Personnel Number" as id,
           trim("NAME") as name,
           "Subtype" as type,
           date( "Start Date" ) as date,
           CAST("Absence hours" as decimal) as hours
      FROM al_leave_request
      where "Set hours" = "X"
  union all
  select id, name, type, date, hours from (
      SELECT "Personnel Number" as id,
               trim("NAME") as name,
               "Subtype" as type,
               date( "Start Date" ) as startdate,
               date( "End Date" ) as enddate,
               date( "Start Date", '+' || n || ' day' ) as date,
               7.6 as hours
          FROM al_leave_request, integers
          where "Full-day" = "X"
              and date <= enddate
              and strftime('%w', date) between '1' and '5'
      )
;


-- al ts entry
drop table if exists al_ts_entry_temp;

create table al_ts_entry_temp 
as SELECT "Personnel Number" as id,
           trim("Name of Employee or Applicant") as name,
           "Att./Absence type" as type,
           date( "Date" ) as date,
           CAST("Number (unit)" as decimal) as hours
      FROM al_ts_entry
;


-- Compare
select type, id, name, date,
    (select hours from al_leave_request_temp where id = t.id and type = t.type and date = t.date ) as leave_request,
    (select hours from al_ts_entry_temp where id = t.id and type = t.type and date = t.date ) as ts_entry
 from (
    select id, name, type, date 
    from al_leave_request_temp
    union
    select id, name, type, date 
    from al_ts_entry_temp
    ) as t
order by type, id, date
;
