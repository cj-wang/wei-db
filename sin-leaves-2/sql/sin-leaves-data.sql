
.separator ,

DROP TABLE IF EXISTS sin_leave_request;
DROP TABLE IF EXISTS sin_ts_entry;
DROP TABLE IF EXISTS integers;

.import data/sin-leave-request.csv sin_leave_request
.import data/sin-ts-entry.csv sin_ts_entry
.import data/integers.csv_ integers
