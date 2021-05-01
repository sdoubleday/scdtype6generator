CREATE VIEW [templateSchema].[templateDimCoreName_FindUpdates_vw]
AS
SELECT
 [NK_SourceSystemID1]					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]					/*Sample*/
,[SampleColumnOne]						/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo]						/*Sample*/
FROM [templateSchema].[templateDimCoreName_predim_prep]
WHERE [SCD_Status] = 'PENDING'
EXCEPT
SELECT
 [NK_SourceSystemID1]					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]					/*Sample*/
,[SampleColumnOne_Cur]					/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]					/*Sample*/
FROM [templateSchema].[templateDimCoreName_predim_copycurrent]
