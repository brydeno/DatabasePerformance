-- Let's run this query and just verify using an execution plan that it uses an index.

SELECT * from dbo.Posts
WHERE OwnerUserId = 22

-- That's great from SSMS or similar, but how could we tell if our aplication uses the index. We need to work a little bit harder.

-- Store this query up to use when you need it.
-- Best to run just before your workload, then straight after
-- The numbers should change :)

SELECT 
    object_name(s.[object_id]) AS TableName,
    i.name AS IndexName,
    i.index_id AS IndexID,
    us.user_seeks AS UserSeeks,
    us.user_scans AS UserScans,
    us.user_lookups AS UserLookups,
    us.user_updates AS UserUpdates
FROM 
    sys.dm_db_index_usage_stats us
INNER JOIN 
    sys.indexes i ON (us.object_id = i.object_id AND us.index_id = i.index_id)
INNER JOIN 
    sys.objects s ON us.object_id = s.object_id
WHERE 
    s.type = 'U' -- Filter for user tables only
    AND i.type_desc = 'NONCLUSTERED' -- Filter for non-clustered indexes
--    AND (us.user_seeks = 0 AND us.user_scans = 0) -- Filter for unused indexes
ORDER BY 
    TableName, IndexName;

SELECT * FROM dbo.Posts
WHERE OwnerUserId = 22

SELECT 
    object_name(s.[object_id]) AS TableName,
    i.name AS IndexName,
    i.index_id AS IndexID,
    us.user_seeks AS UserSeeks,
    us.user_scans AS UserScans,
    us.user_lookups AS UserLookups,
    us.user_updates AS UserUpdates
FROM 
    sys.dm_db_index_usage_stats us
INNER JOIN 
    sys.indexes i ON (us.object_id = i.object_id AND us.index_id = i.index_id)
INNER JOIN 
    sys.objects s ON us.object_id = s.object_id
WHERE 
    s.type = 'U' -- Filter for user tables only
    AND i.type_desc = 'NONCLUSTERED' -- Filter for non-clustered indexes
--    AND (us.user_seeks = 0 AND us.user_scans = 0) -- Filter for unused indexes
ORDER BY 
    TableName, IndexName;

-- On this occasion our index was used
