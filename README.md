# dtl
DTL--Dynamic Data-driven Time Slicing LSH For Joinable Tables Discovery

The relevant steps are as follows
1. Use SQL script to get the table name and column name to write to the database table;
2. Iterate through the table data, calculate the minhash value of each field.
3. Streamset can be use to read the database log , it is a open source software, we can get it from  https://github.com/streamsets/datacollector-oss.
4. Use streamset to build the pipeline, and using the log monitoring component to parse the logs, write to kafka.
5. Consume kafka data, build time slices, calculate the dynamic similarity; and dynamic similarity matrix
6. Use minhash to compute the static similarity and combine it with the similarity matrix and the dynamic similarity to get the composite similarity.

