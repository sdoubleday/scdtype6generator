CREATE VIEW [templateSchema].[templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw]
AS
SELECT
 ROW_NUMBER() OVER (ORDER BY GetMaxSK.[MaxSK]) + GetMaxSK.[MaxSK] AS [SK_templateDimCoreName]
,prep.[NK_SourceSystemID1] AS [NK_SourceSystemID1]
,prep.[NK_SourceSystemID2] AS [NK_SourceSystemID2]
,prep.[SampleColumnOne] AS [SampleColumnOne_Cur]
,prep.[SampleColumnOne] AS [SampleColumnOne_Hist]
,prep.[SampleColumnTwo] AS [SampleColumnTwo_Cur]
,prep.[SampleColumnTwo] AS [SampleColumnTwo_Hist]
,1 AS [Ctl_CurrentFlag]
,prep.[Ctl_EffectiveDate] AS [Ctl_EffectiveDate]
,CONVERT(datetime2,'9999-12-31',102) AS [Ctl_EndDate_Excl]
FROM [templateSchema].[templateDimCoreName_predim_prep] AS prep
INNER JOIN [templateSchema].[templateDimCoreName_dimUpsert_GetMaxSK_vw] AS GetMaxSK ON 1=1
;