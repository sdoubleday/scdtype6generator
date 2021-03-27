CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step1_copycurrent_usp]
AS
	INSERT INTO [templateSchema].[templateDimCoreName_predim_copycurrent]
	(
		 [NK_SourceSystemID1]
		,[NK_SourceSystemID2]
		,[SampleColumnOne_Cur]
		,[SampleColumnTwo_Cur]
	)
	SELECT
		 [NK_SourceSystemID1]
		,[NK_SourceSystemID2]
		,[SampleColumnOne_Cur]
		,[SampleColumnTwo_Cur]
	FROM templateSchema.Dim_templateDimCoreName
	WHERE Ctl_CurrentFlag = 1;


