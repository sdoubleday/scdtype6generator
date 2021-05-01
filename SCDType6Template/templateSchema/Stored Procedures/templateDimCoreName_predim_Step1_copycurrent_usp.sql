CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step1_copycurrent_usp]
AS
	INSERT INTO [templateSchema].[templateDimCoreName_predim_copycurrent]
	(
		 [NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
		,[NK_SourceSystemID2]		/*Sample*/
		,
		 [SampleColumnOne_Cur]		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
		,[SampleColumnTwo_Cur]		/*Sample*/
	)
	SELECT
		 [NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
		,[NK_SourceSystemID2]		/*Sample*/
		,
		 [SampleColumnOne_Cur]		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
		,[SampleColumnTwo_Cur]		/*Sample*/
	FROM [templateSchema].[Dim_templateDimCoreName]
	WHERE [Ctl_CurrentFlag] = 1;


