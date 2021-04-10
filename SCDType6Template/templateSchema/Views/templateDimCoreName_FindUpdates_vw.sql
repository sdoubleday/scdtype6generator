CREATE VIEW [templateSchema].[templateDimCoreName_FindUpdates_vw]
AS
SELECT
 [NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne]
,[SampleColumnTwo]
FROM [templateSchema].[templateDimCoreName_predim_prep]
WHERE [SCD_Status] = 'PENDING'
EXCEPT
SELECT
 [NK_SourceSystemID1]
,[NK_SourceSystemID2]
,[SampleColumnOne_Cur]
,[SampleColumnTwo_Cur]
FROM [templateSchema].[templateDimCoreName_predim_copycurrent]
