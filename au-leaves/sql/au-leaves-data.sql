
.separator ,

DROP TABLE IF EXISTS al_leave_request;
DROP TABLE IF EXISTS al_ts_entry;
DROP TABLE IF EXISTS integers;

.import data/al-leave-request.csv al_leave_request
.import data/al-ts-entry.csv al_ts_entry
.import data/integers.csv_ integers
