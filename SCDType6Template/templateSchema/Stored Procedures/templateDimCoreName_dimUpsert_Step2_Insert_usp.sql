CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimUpsert_Step2_Insert_usp]
AS

INSERT INTO [templateSchema].[Dim_templateDimCoreName]
(
 [SNK_templateDimCoreName]
,[NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnOne_Hist]
,[SampleColumnTwo_Cur]
,[SampleColumnTwo_Hist]
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate]
)
SELECT
 prep.[SNK_templateDimCoreName] AS [SNK_templateDimCoreName]
,prep.[NK_SourceSystemID1] AS [NK_SourceSystemID1]
,prep.[NK_SourceSystemID2] AS [NK_SourceSystemID2]
,prep.[SampleColumnOne] AS [SampleColumnOne_Cur]
,prep.[SampleColumnOne] AS [SampleColumnOne_Hist]
,prep.[SampleColumnTwo] AS [SampleColumnTwo_Cur]
,prep.[SampleColumnTwo] AS [SampleColumnTwo_Hist]
,1 AS [Ctl_CurrentFlag]
,prep.[Ctl_EffectiveDate] AS [Ctl_EffectiveDate]
,CONVERT(datetime2,'9999-12-31',102) AS [Ctl_EndDate]
FROM [templateSchema].[templateDimCoreName_predim_prep] AS prep
;