This directory should hold all maintenance specific queries, the queries must
have the file extension .sql in order to be executed by the cron script.

Remember that file execution is unordered, queries depending on ordered 
execution should either be merged into one or should take unordered execution 
into account.
 