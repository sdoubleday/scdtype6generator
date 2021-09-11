CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimUpsert_T1_Step2_Insert_usp]
AS

INSERT INTO [dimensionSchema].[templateDimCoreName_T1_dim]
(
 [SNK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne_Cur]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]			/*Sample*/
)
SELECT
 [SNK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo]			/*Sample*/
FROM [templateSchema].[templateDimCoreName_predim_prep]
WHERE [SCD_Status] = 'NEW';
;
