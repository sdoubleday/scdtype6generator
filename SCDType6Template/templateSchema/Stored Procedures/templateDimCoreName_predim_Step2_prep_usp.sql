CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step2_prep_usp]
AS
	INSERT INTO templateSchema.[templateDimCoreName_predim_prep]
	(
		 [SNK_templateDimCoreName]
		,[NK_SourceSystemID1]
		,[NK_SourceSystemID2]
		,[SampleColumnOne]
		,[SampleColumnTwo]
		,[Ctl_EffectiveDate]
		,[SCD_Status]
	)
	SELECT 
	 CASE WHEN dim.[SNK_templateDimCoreName] IS NULL
		THEN GetMaxSNK.[MaxSNK] + (ROW_NUMBER() OVER (ORDER BY COALESCE(dim.[SNK_templateDimCoreName],-1) ASC ) )
		ELSE dim.[SNK_templateDimCoreName]
	END AS [SNK_templateDimCoreName]
	,stg.[NK_SourceSystemID1]
	,stg.[NK_SourceSystemID2]
	,COALESCE(stg.[SampleColumnOne],'*UNKNOWN') AS [SampleColumnOne]
	,COALESCE(stg.[SampleColumnTwo],'*UNKNOWN') AS [SampleColumnTwo]
	,CASE WHEN dim.[SNK_templateDimCoreName] IS NULL
		THEN CONVERT(DATETIME2,'1900-01-01',102)
		ELSE stg.[Ctl_EffectiveDate]
	END AS [Ctl_EffectiveDate]
	,CASE WHEN dim.[SNK_templateDimCoreName] IS NULL
		THEN 'NEW'
		ELSE 'PENDING'
	END AS [SCD_Status]
	FROM [templateSchema].[templateDimCoreName_dimSrc_stg] stg
	LEFT OUTER JOIN [templateSchema].[Dim_templateDimCoreName] dim
	ON dim.Ctl_CurrentFlag = 1
	AND dim.[NK_SourceSystemID1] = stg.[NK_SourceSystemID1]
	AND dim.[NK_SourceSystemID2] = stg.[NK_SourceSystemID2]
	CROSS JOIN [templateSchema].[templateDimCoreName_predim_GetMaxSNK_vw] AS GetMaxSNK
;
