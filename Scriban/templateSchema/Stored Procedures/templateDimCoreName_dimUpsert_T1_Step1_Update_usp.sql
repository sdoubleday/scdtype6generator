CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimUpsert_T1_Step1_Update_usp]
AS
	UPDATE dim
	SET
	 dim.[SampleColumnOne_Cur] = prep.[SampleColumnOne]		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
	,dim.[SampleColumnTwo_Cur] = prep.[SampleColumnTwo]		/*Sample*/
	
	FROM [dimensionSchema].[templateDimCoreName_T1_dim] dim
	INNER JOIN [templateSchema].[templateDimCoreName_predim_prep] prep
	ON
	dim.[SNK_templateDimCoreName] = prep.[SNK_templateDimCoreName]
;