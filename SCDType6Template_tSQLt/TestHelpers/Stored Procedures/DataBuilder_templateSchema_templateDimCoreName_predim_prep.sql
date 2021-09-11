CREATE PROCEDURE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_prep]
 @SNK_templateDimCoreName int = NULL
,@NK_SourceSystemID1 nvarchar(500) = NULL
,@NK_SourceSystemID2 nvarchar(500) = NULL
,@SampleColumnOne varchar(500) = NULL
,@SampleColumnTwo varchar(500) = NULL
,@Ctl_EffectiveDate datetime2 = NULL
,@SCD_Status varchar(30) = NULL
AS 
IF OBJECT_ID('tempdb..[#DataBuilder_templateSchema_templateDimCoreName_predim_prep]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_templateSchema_templateDimCoreName_predim_prep];
END
SELECT TOP 0 
 [SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne]
,[SampleColumnTwo]
,[Ctl_EffectiveDate]
,[SCD_Status]
 INTO [#DataBuilder_templateSchema_templateDimCoreName_predim_prep] FROM [templateSchema].[templateDimCoreName_predim_prep];
INSERT INTO [#DataBuilder_templateSchema_templateDimCoreName_predim_prep](
 [SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne]
,[SampleColumnTwo]
,[Ctl_EffectiveDate]
,[SCD_Status]
) SELECT
 @SNK_templateDimCoreName
,@NK_SourceSystemID1
,@NK_SourceSystemID2
,@SampleColumnOne
,@SampleColumnTwo
,@Ctl_EffectiveDate
,@SCD_Status
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [templateSchema].[templateDimCoreName_predim_prep] (

 [SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne]
,[SampleColumnTwo]
,[Ctl_EffectiveDate]
,[SCD_Status]

) SELECT 
 [SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne]
,[SampleColumnTwo]
,[Ctl_EffectiveDate]
,[SCD_Status]
 FROM [#DataBuilder_templateSchema_templateDimCoreName_predim_prep];';
EXECUTE sp_executesql @sql;
RETURN 0


