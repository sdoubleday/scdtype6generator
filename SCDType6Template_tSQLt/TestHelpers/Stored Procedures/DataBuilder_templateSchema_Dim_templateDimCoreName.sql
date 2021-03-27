CREATE PROCEDURE [TestHelpers].[DataBuilder_templateSchema_Dim_templateDimCoreName]
 @SK_templateDimCoreName int = NULL
,@NK_SourceSystemID1 int = NULL
,@NK_SourceSystemID2 int = NULL
,@SampleColumnOne_Cur varchar(500) = NULL
,@SampleColumnOne_Hist varchar(500) = NULL
,@SampleColumnTwo_Cur varchar(500) = NULL
,@SampleColumnTwo_Hist varchar(500) = NULL
,@Ctl_CurrentFlag bit = NULL
,@Ctl_EffectiveDate datetime2 = NULL
,@Ctl_EndDate datetime2 = NULL
AS 

IF OBJECT_ID('tempdb..[#DataBuilder_templateSchema_Dim_templateDimCoreName]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_templateSchema_Dim_templateDimCoreName];
END
SELECT TOP 0 * INTO [#DataBuilder_templateSchema_Dim_templateDimCoreName] FROM [templateSchema].[Dim_templateDimCoreName];

INSERT INTO [#DataBuilder_templateSchema_Dim_templateDimCoreName](
 [SK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnOne_Hist]
,[SampleColumnTwo_Cur]
,[SampleColumnTwo_Hist]
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate]
) SELECT
 @SK_templateDimCoreName
,@NK_SourceSystemID1
,@NK_SourceSystemID2
,@SampleColumnOne_Cur
,@SampleColumnOne_Hist
,@SampleColumnTwo_Cur
,@SampleColumnTwo_Hist
,@Ctl_CurrentFlag
,@Ctl_EffectiveDate
,@Ctl_EndDate
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [templateSchema].[Dim_templateDimCoreName] SELECT * FROM [#DataBuilder_templateSchema_Dim_templateDimCoreName];';
EXECUTE sp_executesql @sql;
RETURN 0


