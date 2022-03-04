-- Query employees difference from last month

SELECT 
    op,
    "Employee ID",
    "Name",
    "Location",
    "Job Profile",
    "Compensation Grade",
    "Position Ref ID",
    "Position",
    "Job Family Group",
    "Worker Type",
    "Employee Type",
    "Time Type",
    "Scheduled Weekly Hours",
    "FTE %",
    "Pay Rate Type",
    "Effective Date of Pay Rate Type",
    "Total Base Pay - Amount",
    "Cost Center",
    "SAP Cost Center",
    "CBA Name",
    "Date of Birth",
    "Position Start Date",
    "Email - Work",
    "Email - Home",
    "Phone - Primary Work",
    "Home Address"
FROM (
        SELECT "Added" as op, *
          FROM employees_this_month
          where not exists (select 1 from employees_last_month where employees_this_month."Employee ID" = employees_last_month."Employee ID")
        
        union all
        
        SELECT "Deleted" as op, *
          FROM employees_last_month
          where not exists (select 1 from employees_this_month where employees_this_month."Employee ID" = employees_last_month."Employee ID")
        
        union all
        
        SELECT "Updated" as op, employees_last_month.*
          FROM employees_this_month, employees_last_month
          where employees_this_month."Employee ID" = employees_last_month."Employee ID"
            and (
                       employees_this_month."Name"                             <> employees_last_month."Name"
                    or employees_this_month."Location"                         <> employees_last_month."Location"
                    or employees_this_month."Job Profile"                      <> employees_last_month."Job Profile"
                    or employees_this_month."Compensation Grade"               <> employees_last_month."Compensation Grade"
                    or employees_this_month."Position Ref ID"                  <> employees_last_month."Position Ref ID"
                    or employees_this_month."Position"                         <> employees_last_month."Position"
                    or employees_this_month."Job Family Group"                 <> employees_last_month."Job Family Group"
                    or employees_this_month."Worker Type"                      <> employees_last_month."Worker Type"
                    or employees_this_month."Employee Type"                    <> employees_last_month."Employee Type"
                    or employees_this_month."Time Type"                        <> employees_last_month."Time Type"
                    or employees_this_month."Scheduled Weekly Hours"           <> employees_last_month."Scheduled Weekly Hours"
                    or employees_this_month."FTE %"                            <> employees_last_month."FTE %"
                    or employees_this_month."Pay Rate Type"                    <> employees_last_month."Pay Rate Type"
                    or employees_this_month."Effective Date of Pay Rate Type"  <> employees_last_month."Effective Date of Pay Rate Type"
                    or employees_this_month."Total Base Pay - Amount"          <> employees_last_month."Total Base Pay - Amount"
                    or employees_this_month."Cost Center"                      <> employees_last_month."Cost Center"
                    or employees_this_month."SAP Cost Center"                  <> employees_last_month."SAP Cost Center"
                    or employees_this_month."CBA Name"                         <> employees_last_month."CBA Name"
                    or employees_this_month."Date of Birth"                    <> employees_last_month."Date of Birth"
                    or employees_this_month."Position Start Date"              <> employees_last_month."Position Start Date"
                    or employees_this_month."Email - Work"                     <> employees_last_month."Email - Work"
                    or employees_this_month."Email - Home"                     <> employees_last_month."Email - Home"
                    or employees_this_month."Phone - Primary Work"             <> employees_last_month."Phone - Primary Work"
                    or employees_this_month."Home Address"                     <> employees_last_month."Home Address"
                )
        
        union all
        
        SELECT "Updated" as op, employees_this_month.*
          FROM employees_this_month, employees_last_month
          where employees_this_month."Employee ID" = employees_last_month."Employee ID"
            and (
                       employees_this_month."Name"                             <> employees_last_month."Name"
                    or employees_this_month."Location"                         <> employees_last_month."Location"
                    or employees_this_month."Job Profile"                      <> employees_last_month."Job Profile"
                    or employees_this_month."Compensation Grade"               <> employees_last_month."Compensation Grade"
                    or employees_this_month."Position Ref ID"                  <> employees_last_month."Position Ref ID"
                    or employees_this_month."Position"                         <> employees_last_month."Position"
                    or employees_this_month."Job Family Group"                 <> employees_last_month."Job Family Group"
                    or employees_this_month."Worker Type"                      <> employees_last_month."Worker Type"
                    or employees_this_month."Employee Type"                    <> employees_last_month."Employee Type"
                    or employees_this_month."Time Type"                        <> employees_last_month."Time Type"
                    or employees_this_month."Scheduled Weekly Hours"           <> employees_last_month."Scheduled Weekly Hours"
                    or employees_this_month."FTE %"                            <> employees_last_month."FTE %"
                    or employees_this_month."Pay Rate Type"                    <> employees_last_month."Pay Rate Type"
                    or employees_this_month."Effective Date of Pay Rate Type"  <> employees_last_month."Effective Date of Pay Rate Type"
                    or employees_this_month."Total Base Pay - Amount"          <> employees_last_month."Total Base Pay - Amount"
                    or employees_this_month."Cost Center"                      <> employees_last_month."Cost Center"
                    or employees_this_month."SAP Cost Center"                  <> employees_last_month."SAP Cost Center"
                    or employees_this_month."CBA Name"                         <> employees_last_month."CBA Name"
                    or employees_this_month."Date of Birth"                    <> employees_last_month."Date of Birth"
                    or employees_this_month."Position Start Date"              <> employees_last_month."Position Start Date"
                    or employees_this_month."Email - Work"                     <> employees_last_month."Email - Work"
                    or employees_this_month."Email - Home"                     <> employees_last_month."Email - Home"
                    or employees_this_month."Phone - Primary Work"             <> employees_last_month."Phone - Primary Work"
                    or employees_this_month."Home Address"                     <> employees_last_month."Home Address"
                )
    )
order by op, "Employee ID"
;
