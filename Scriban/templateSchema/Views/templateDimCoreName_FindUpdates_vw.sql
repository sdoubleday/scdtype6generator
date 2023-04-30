CREATE VIEW [templateSchema].[templateDimCoreName_FindUpdates_vw]
AS
SELECT
 [SNK_templateDimCoreName]
,
 [SampleColumnOne]						/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo]						/*Sample*/
FROM [templateSchema].[templateDimCoreName_predim_prep]
WHERE [SCD_Status] = 'PENDING'
EXCEPT
SELECT
 [SNK_templateDimCoreName]
,
 [SampleColumnOne_Cur]					/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]					/*Sample*/
FROM [dimensionSchema].[templateDimCoreName_T1_dim]
;
