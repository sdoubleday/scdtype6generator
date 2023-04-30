CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step5_Check_OneRowPerKey_usp]
AS
IF EXISTS (
	SELECT 
	 [NK_SourceSystemID1]					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,[NK_SourceSystemID2]					/*Sample*/
	FROM [templateSchema].[templateDimCoreName_predim_prep]
	GROUP BY
	 [NK_SourceSystemID1]					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,[NK_SourceSystemID2]					/*Sample*/
	HAVING COUNT(1) > 1
)
BEGIN;
	THROW 51000, 'Multiple rows for one or more sets of Natural Keys. Only one row allowed per Natural Key set.', 1;
END;

