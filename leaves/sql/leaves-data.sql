
.separator ,

DROP TABLE IF EXISTS leaves_sap;
DROP TABLE IF EXISTS leaves_trico;
DROP TABLE IF EXISTS leave_types;
DROP TABLE IF EXISTS integers;

.import data/leaves-sap.csv leaves_sap
.import data/leaves-trico.csv leaves_trico
.import data/leave-types.csv leave_types
.import data/integers.csv integers
