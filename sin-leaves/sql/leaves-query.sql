-- Query leaves difference between SAP and TRICO


-- SAP
drop table if exists leaves_sap_temp;

create table leaves_sap_temp 
as SELECT "Personnel Number" as id,
           "Name of Employee or Applicant" as name,
           "Att./Absence type" as type,
           "Leave type text" as typetext,
           sum(Days) as days,
           group_concat(date || ' (' || CAST(days as decimal) || ')', ',  ') as dates
      FROM (select * from leaves_sap 
              order by date( substr(date,7) || '-' || substr(date,4,2) || '-' || substr(date,1,2)))
      group by id, type
;


-- TRICO
drop table if exists leaves_trico_temp;

create table leaves_trico_temp 
as select id, 
        name, 
        (select absence_type from leave_types where leave_type = type) as type,
        (select type_text from leave_types where leave_type = type) as typetext, 
        sum(days) as days,
        (select group_concat("Start Date" || IIF("Start Date" == "End Date", '', '-' || "End Date") || ' (' || day || ')', ',  ') 
            from (select * from leaves_trico 
              order by date( substr("Start Date",7) || '-' || substr("Start Date",4,2) || '-' || substr("Start Date",1,2))) o 
            where o."Emp No" = tmp.id and o.Leave = tmp.type ) as dates
    from (
        SELECT "Emp No" as id,
               "Emp Name" as name,
               Leave as type,
               date( substr("Start Date",7) || '-' || substr("Start Date",4,2) || '-' || substr("Start Date",1,2)) as startdate,
               date( substr("End Date",7) || '-' || substr("End Date",4,2) || '-' || substr("End Date",1,2)) as enddate,
               date( substr("Start Date",7) || '-' || substr("Start Date",4,2) || '-' || substr("Start Date",1,2), '+' || n || ' day' ) as date,
               min(CAST(day as decimal), 1) as days
          FROM leaves_trico, integers
          ) tmp
    where date <= enddate
      and date between date('now','start of month','-1 month') and date('now','start of month','+1 month','-1 day')
      and strftime('%w', date) between '1' and '5'
group by id, type
;


-- Compare
select id, name, type, typetext,
    s.days as SAP_DAYS,
    s.dates as SAP_DATES,
    ' ' as TRICO_DAYS,
    ' ' as TRICO_DATES
from leaves_sap_temp s
where not exists (select 1 from leaves_trico_temp t where s.id = t.id and s.type = t.type)

union all 

select id, name, type, typetext,
    ' ' as SAP_DAYS,
    ' ' as SAP_DATES,
    t.days as TRICO_DAYS,
    t.dates as TRICO_DATES
from leaves_trico_temp t
where not exists (select 1 from leaves_sap_temp s where s.id = t.id and s.type = t.type)

union all

select s.id, s.name, s.type, s.typetext,
    s.days as SAP_DAYS,
    s.dates as SAP_DATES,
    t.days as TRICO_DAYS,
    t.dates as TRICO_DATES
from leaves_sap_temp s, leaves_trico_temp t 
where s.id = t.id
  and s.type = t.type
  and s.days <> t.days
;
