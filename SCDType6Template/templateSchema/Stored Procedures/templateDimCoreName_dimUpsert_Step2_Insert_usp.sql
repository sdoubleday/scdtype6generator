CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimUpsert_Step2_Insert_usp]
AS

INSERT INTO [templateSchema].[Dim_templateDimCoreName]
(
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
)
SELECT
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
FROM [templateSchema].[templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw]
;
