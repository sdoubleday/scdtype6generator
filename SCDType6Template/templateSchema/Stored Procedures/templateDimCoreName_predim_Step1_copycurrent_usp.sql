CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step1_copycurrent_usp]
AS
	INSERT INTO [templateSchema].[templateDimCoreName_predim_copycurrent]
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


