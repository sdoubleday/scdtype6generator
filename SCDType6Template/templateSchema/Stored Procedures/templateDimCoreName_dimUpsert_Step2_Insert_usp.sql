CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimUpsert_Step2_Insert_usp]
AS

INSERT INTO [dimensionSchema].[templateDimCoreName_Dim]
(
 [SK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne_Cur]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,
 [SampleColumnOne_Hist]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]			/*Sample*/
,[SampleColumnTwo_Hist]			/*Sample*/
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]
)
SELECT
 [SK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne_Cur]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,
 [SampleColumnOne_Hist]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]			/*Sample*/
,[SampleColumnTwo_Hist]			/*Sample*/
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]
FROM [templateSchema].[templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw]
;
