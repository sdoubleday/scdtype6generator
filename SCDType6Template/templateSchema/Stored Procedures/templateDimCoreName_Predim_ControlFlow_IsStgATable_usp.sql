CREATE PROCEDURE [templateSchema].[templateDimCoreName_Predim_ControlFlow_IsStgATable_usp]
AS
DECLARE @returnable BIT
IF EXISTS (
	SELECT
	1 AS one 
	FROM sys.objects o
	WHERE OBJECT_SCHEMA_NAME(o.object_id) =  'StagingSchema'
	AND o.name like 'templateDimCoreName_dimSrc_stg'
	AND o.type = 'U'
)
BEGIN
	SET @returnable = 1
END
ELSE 
BEGIN
	SET @returnable = 0
END
RETURN @returnable
