
.separator ,

DROP TABLE IF EXISTS employees_last_month;
DROP TABLE IF EXISTS employees_this_month;

.import data/employees-last-month.csv employees_last_month
.import data/employees-this-month.csv employees_this_month
