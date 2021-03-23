CREATE VIEW [templateSchema].[vw_templateDimCoreName_FindUpdates]
AS
SELECT
 [SNK_templateDimCoreName]
,[SampleColumnOne]
,[SampleColumnTwo]
FROM [templateSchema].[predim_prep_templateDimCoreName]
WHERE SCD_Status = 'PENDING'
EXCEPT
SELECT
 [SNK_templateDimCoreName]
,[SampleColumnOne_Cur]
,[SampleColumnTwo_Cur]
FROM [templateSchema].[predim_copycurrent_templateDimCoreName]
