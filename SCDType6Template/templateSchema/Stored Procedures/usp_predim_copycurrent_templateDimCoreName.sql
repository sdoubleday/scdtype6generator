CREATE PROCEDURE [templateSchema].[usp_predim_copycurrent_templateDimCoreName]
AS
	INSERT INTO [templateSchema].predim_copycurrent_templateDimCoreName
	(
		SNK_templateDimCoreName
		,SampleColumnOne_Cur
		,SampleColumnTwo_Cur
	)
	SELECT
		SNK_templateDimCoreName
		,SampleColumnOne_Cur
		,SampleColumnTwo_Cur
	FROM templateSchema.Dim_templateDimCoreName
	WHERE Ctl_CurrentFlag = 1;


