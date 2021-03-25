CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step4_prep_DeleteIgnorable]
AS
	DELETE [templateSchema].[templateDimCoreName_predim_prep]
	WHERE [SCD_Status] = 'IGNORE';
