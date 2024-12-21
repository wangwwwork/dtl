# dtl
DTL--Dynamic Data-driven Time Slicing LSH For Joinable Tables Discovery

### Project Overview

1. **Use SQL Scripts to Retrieve Table and Column Names and Write to a Database Table**
   - SQL scripts will be executed to fetch all table names and column names from the database, which will then be stored in a new table for easy reference in future steps.

2. **Traverse the Table Data and Compute the MinHash values for Each Field**
   - A process will be implemented to iterate through the data in each table, calculating the minimum hash value for every field, which can be used for data deduplication, fingerprinting, or other verification tasks.

3. **Read Database Logs Using StreamSets Open-Source Software**
   - Database logs will be captured using StreamSets, an open-source data integration tool. StreamSets Data Collector (available at [https://github.com/streamsets/datacollector-oss](https://github.com/streamsets/datacollector-oss)) will be used for this purpose.

4. **Build a StreamSets Pipeline with Log Monitoring Components to Parse Logs and Write to Kafka**
   - A data pipeline will be constructed using StreamSets, which includes components for monitoring and parsing the logs, then writing the processed data to Apache Kafka for further analysis.

5. **Consume Kafka Data, Build Time Windows, and Calculate Dynamic Similarity**
   - Kafka data will be consumed, and time-based partitions (or windows) will be constructed to calculate dynamic similarity and build a dynamic similarity matrix.

6. **Use MinHash values to Calculate Static Similarity and Integrate with Dynamic Similarity Matrix for Comprehensive Similarity**
   - Minimum hashing techniques will be used to compute static similarity. This static similarity will then be combined with the dynamic similarity matrix to calculate a comprehensive similarity score.
