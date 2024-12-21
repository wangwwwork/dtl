import pyodbc
import pandas as pd
import hashlib
import pymysql
from sqlalchemy import create_engine
from collections import Counter
from datasketch import MinHash
import pickle

# 连接到 MSSQL 数据库
conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=192.168.1.12;'
    'DATABASE=xxx;'
    'UID=xx;'
    'PWD=xxx;'
)

mysqlconn = pymysql.connect(
    host="localhost",
    user="root",
    password="xxx",
    database="lw"
)

if not mysqlconn:
    print("Connection to MySQL DB successful")


# 获取所有表和列的名称
query = """SELECT * from table_desc ORDER BY id LIMIT 8000 OFFSET 6000"""
columns_df = pd.read_sql(query, mysqlconn)
print(columns_df)

# 函数：计算列数据的 64 位 minHash
def get_minhash_signature(data, num_perm=128):
    """生成 MinHash 签名"""
    m = MinHash(num_perm=num_perm)
    for item in data:
        if item:  # 确保数据项不为空
            m.update(item.encode('utf8'))
    return m.digest()




# 函数：计算列数据的 minhash
def compute_column_minhash(table, column):
    query = f"SELECT {column} FROM JSERP8.{table} where {column} is not null group by {column}"
    print(query)
    df = pd.read_sql(query, conn)
    concatenated_data = df[column].astype(str).str.cat(sep=' ')
    tokens = concatenated_data.split()
    return get_minhash_signature(tokens)

# 对每个列计算 minhash
hashes = []
mysql_cursor = mysqlconn.cursor()
for index, row in columns_df.iterrows():
    table = row['table_name']
    column = row['column_name']
    sid = row['id']
    try:
        column_minhash = compute_column_minhash(table, column)
        updateSql = """UPDATE table_v3 SET jz = '%s'  WHERE id = %s """ % (column_minhash, sid)
        print(updateSql)
        mysql_cursor.execute(updateSql)
        mysqlconn.commit()
        hashes.append((table, column, column_minhash))
    except Exception as e:
        print(f"Error processing {table}.{column}: {e}")

# 关闭数据库连接
conn.close()
mysqlconn.close();
