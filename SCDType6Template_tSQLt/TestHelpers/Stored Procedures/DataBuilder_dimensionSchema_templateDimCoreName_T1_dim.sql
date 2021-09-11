CREATE PROCEDURE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_T1_dim]
 @SNK_templateDimCoreName int = NULL
,@NK_SourceSystemID1 nvarchar(500) = NULL
,@NK_SourceSystemID2 nvarchar(500) = NULL
,@SampleColumnOne_Cur varchar(500) = NULL
,@SampleColumnTwo_Cur varchar(500) = NULL
,@templateDimCoreName_IsMissing bit = NULL
AS 
IF OBJECT_ID('tempdb..[#DataBuilder_dimensionSchema_templateDimCoreName_T1_dim]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_dimensionSchema_templateDimCoreName_T1_dim];
END
SELECT TOP 0 
 [SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnTwo_Cur]
,[templateDimCoreName_IsMissing]
 INTO [#DataBuilder_dimensionSchema_templateDimCoreName_T1_dim] FROM [dimensionSchema].[templateDimCoreName_T1_dim];
INSERT INTO [#DataBuilder_dimensionSchema_templateDimCoreName_T1_dim](
 [SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnTwo_Cur]
,[templateDimCoreName_IsMissing]
) SELECT
 @SNK_templateDimCoreName
,@NK_SourceSystemID1
,@NK_SourceSystemID2
,@SampleColumnOne_Cur
,@SampleColumnTwo_Cur
,@templateDimCoreName_IsMissing
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [dimensionSchema].[templateDimCoreName_T1_dim] (

 [SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnTwo_Cur]
,[templateDimCoreName_IsMissing]

) SELECT 
 [SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnTwo_Cur]
,[templateDimCoreName_IsMissing]
 FROM [#DataBuilder_dimensionSchema_templateDimCoreName_T1_dim];';
EXECUTE sp_executesql @sql;
RETURN 0


