CREATE VIEW [templateSchema].[templateDimCoreName_FindUpdates_vw]
AS
SELECT
 [SNK_templateDimCoreName]
,[SampleColumnOne]
,[SampleColumnTwo]
FROM [templateSchema].[templateDimCoreName_predim_prep]
WHERE SCD_Status = 'PENDING'
EXCEPT
SELECT
 [SNK_templateDimCoreName]
,[SampleColumnOne_Cur]
,[SampleColumnTwo_Cur]
FROM [templateSchema].[templateDimCoreName_predim_copycurrent]
