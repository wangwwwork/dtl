SELECT
	a.name,
	b. ROWS
FROM
	sysobjects AS a
INNER JOIN sysindexes AS b ON a.id = b.id
WHERE
	(a.type = 'u')
AND (b.indid IN(0, 1))
ORDER BY
	b. ROWS DESC




select data_type, count(1) from (SELECT
	t.table_name,
	t.column_name,
	t.data_type,
	t.is_nullable,
	p.colname AS keyName
FROM
	information_schema.columns t
LEFT JOIN (
	SELECT
		TABLE_NAME AS tname,
		COLUMN_NAME AS colname
	FROM
		INFORMATION_SCHEMA.KEY_COLUMN_USAGE
) p ON t.table_name = p.tname
AND t.column_name = p.colname
WHERE
	table_name IN (
		SELECT
			NAME
		FROM
			SYSOBJECTS
		WHERE
			XTYPE = 'U'
	) and table_name not like 'conflict_JSE%') t GROUP BY data_type


SELECT OBJECT_NAME(B.ID) 表名,B.COLORDER 序号,B.NAME 字段名称,C.NAME 字段类型,B.PREC 精度级别,B.SCALE 小数位数,
    CASE WHEN NOT F.ID IS NULL THEN 'TRUE' ELSE '' END 是否主键,
    CASE WHEN COLUMNPROPERTY(B.ID,B.NAME,'ISIDENTITY') = 1 THEN 'TRUE' ELSE '' END AS 是否自动增长,
    CONVERT(VARCHAR(1000),ISNULL(G.VALUE,'')) 字段说明
FROM SYSOBJECTS A INNER JOIN SYSCOLUMNS B ON A.ID=B.ID INNER JOIN SYSTYPES C ON B.XTYPE=C.XUSERTYPE
    LEFT JOIN SYSOBJECTS D ON B.ID=D.PARENT_OBJ AND D.XTYPE='PK'
    LEFT JOIN SYSINDEXES E ON B.ID=E.ID AND D.NAME=E.NAME
    LEFT JOIN SYSINDEXKEYS F ON B.ID=F.ID AND B.COLID=F.COLID AND E.INDID=F.INDID
    LEFT JOIN SYS.EXTENDED_PROPERTIES G ON B.ID=G.MAJOR_ID AND B.COLID=G.MINOR_ID
WHERE A.XTYPE='U' AND OBJECT_NAME(B.ID)='MF_MO'


select * from (
SELECT OBJECT_NAME(B.ID) table_name,B.COLORDER roder_table,B.NAME field_name,C.NAME field_type,B.PREC field_percition,B.SCALE float_p,
    CASE WHEN NOT F.ID IS NULL THEN 'TRUE' ELSE '' END 是否主键,
    CASE WHEN COLUMNPROPERTY(B.ID,B.NAME,'ISIDENTITY') = 1 THEN 'TRUE' ELSE '' END AS 是否自动增长,
    CONVERT(VARCHAR(1000),ISNULL(G.VALUE,'')) 字段说明
FROM SYSOBJECTS A INNER JOIN SYSCOLUMNS B ON A.ID=B.ID INNER JOIN SYSTYPES C ON B.XTYPE=C.XUSERTYPE
    LEFT JOIN SYSOBJECTS D ON B.ID=D.PARENT_OBJ AND D.XTYPE='PK'
    LEFT JOIN SYSINDEXES E ON B.ID=E.ID AND D.NAME=E.NAME
    LEFT JOIN SYSINDEXKEYS F ON B.ID=F.ID AND B.COLID=F.COLID AND E.INDID=F.INDID
    LEFT JOIN SYS.EXTENDED_PROPERTIES G ON B.ID=G.MAJOR_ID AND B.COLID=G.MINOR_ID
WHERE A.XTYPE='U'  and OBJECT_NAME(B.ID) not like 'conflict_J%' ) t where t.field_type in ('char', 'int', 'varchar', 'nvarchar') and t.field_percition >= 12
