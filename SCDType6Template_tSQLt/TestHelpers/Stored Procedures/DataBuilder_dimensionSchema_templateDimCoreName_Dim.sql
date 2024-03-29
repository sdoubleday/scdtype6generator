﻿CREATE PROCEDURE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim]
 @SK_templateDimCoreName int = NULL
,@SNK_templateDimCoreName int = NULL
,@NK_SourceSystemID1 nvarchar(500) = NULL
,@NK_SourceSystemID2 nvarchar(500) = NULL
,@SampleColumnOne_Cur varchar(500) = NULL
,@SampleColumnOne_Hist varchar(500) = NULL
,@SampleColumnTwo_Cur varchar(500) = NULL
,@SampleColumnTwo_Hist varchar(500) = NULL
,@templateDimCoreName_IsMissing bit = NULL
,@Ctl_CurrentFlag bit = NULL
,@Ctl_EffectiveDate datetime2 = NULL
,@Ctl_EndDate_Excl datetime2 = NULL
AS 
IF OBJECT_ID('tempdb..[#DataBuilder_dimensionSchema_templateDimCoreName_Dim]') IS NOT NULL
BEGIN
	DROP TABLE [#DataBuilder_dimensionSchema_templateDimCoreName_Dim];
END
SELECT TOP 0 
 [SK_templateDimCoreName]
,[SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnOne_Hist]
,[SampleColumnTwo_Cur]
,[SampleColumnTwo_Hist]
,[templateDimCoreName_IsMissing]
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]
 INTO [#DataBuilder_dimensionSchema_templateDimCoreName_Dim] FROM [dimensionSchema].[templateDimCoreName_Dim];
INSERT INTO [#DataBuilder_dimensionSchema_templateDimCoreName_Dim](
 [SK_templateDimCoreName]
,[SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnOne_Hist]
,[SampleColumnTwo_Cur]
,[SampleColumnTwo_Hist]
,[templateDimCoreName_IsMissing]
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]
) SELECT
 @SK_templateDimCoreName
,@SNK_templateDimCoreName
,@NK_SourceSystemID1
,@NK_SourceSystemID2
,@SampleColumnOne_Cur
,@SampleColumnOne_Hist
,@SampleColumnTwo_Cur
,@SampleColumnTwo_Hist
,@templateDimCoreName_IsMissing
,@Ctl_CurrentFlag
,@Ctl_EffectiveDate
,@Ctl_EndDate_Excl
;
DECLARE @sql NVARCHAR(MAX) = N'INSERT INTO [dimensionSchema].[templateDimCoreName_Dim] (

 [SK_templateDimCoreName]
,[SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnOne_Hist]
,[SampleColumnTwo_Cur]
,[SampleColumnTwo_Hist]
,[templateDimCoreName_IsMissing]
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]

) SELECT 
 [SK_templateDimCoreName]
,[SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnOne_Hist]
,[SampleColumnTwo_Cur]
,[SampleColumnTwo_Hist]
,[templateDimCoreName_IsMissing]
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]
 FROM [#DataBuilder_dimensionSchema_templateDimCoreName_Dim];';
EXECUTE sp_executesql @sql;
RETURN 0


