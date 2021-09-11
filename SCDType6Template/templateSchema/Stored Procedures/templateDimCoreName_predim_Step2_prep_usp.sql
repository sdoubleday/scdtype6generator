CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step2_prep_usp]
AS
	INSERT INTO [templateSchema].[templateDimCoreName_predim_prep]
	(
		 [SNK_templateDimCoreName]
		,
		 [NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
		,[NK_SourceSystemID2]		/*Sample*/
		,
		 [SampleColumnOne]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
		,[SampleColumnTwo]			/*Sample*/
		,[Ctl_EffectiveDate]
		,[SCD_Status]
	)
	SELECT
	 CASE WHEN a.[dim__SNK_templateDimCoreName] IS NULL
		THEN GetMaxSNK.[MaxSNK] + (ROW_NUMBER() OVER (ORDER BY COALESCE(a.[dim__SNK_templateDimCoreName],-1) ASC ) )
		ELSE a.[dim__SNK_templateDimCoreName]
	END AS [SNK_templateDimCoreName]
	,
	 [NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,[NK_SourceSystemID2]		/*Sample*/
	,
	 [SampleColumnOne]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
	,[SampleColumnTwo]			/*Sample*/
	,[Ctl_EffectiveDate]
	,[SCD_Status]
	FROM [templateSchema].[templateDimCoreName_predim_Step2_prep_columnTransformations_vw] as a
	INNER JOIN [templateSchema].[templateDimCoreName_predim_GetMaxSNK_vw] AS GetMaxSNK ON 1=1
;
