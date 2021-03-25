CREATE PROCEDURE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_GetMaxSNK_vw]
 @MaxSNK int = NULL
AS 

IF OBJECT_ID('tempdb..[#DataBuilder_templateSchema_templateDimCoreName_predim_GetMaxSNK_vw]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_templateSchema_templateDimCoreName_predim_GetMaxSNK_vw];
END
SELECT TOP 0 * INTO [#DataBuilder_templateSchema_templateDimCoreName_predim_GetMaxSNK_vw] FROM [templateSchema].[templateDimCoreName_predim_GetMaxSNK_vw];

INSERT INTO [#DataBuilder_templateSchema_templateDimCoreName_predim_GetMaxSNK_vw](
 [MaxSNK]
) SELECT
 @MaxSNK
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [templateSchema].[templateDimCoreName_predim_GetMaxSNK_vw] SELECT * FROM [#DataBuilder_templateSchema_templateDimCoreName_predim_GetMaxSNK_vw];';
EXECUTE sp_executesql @sql;
RETURN 0


