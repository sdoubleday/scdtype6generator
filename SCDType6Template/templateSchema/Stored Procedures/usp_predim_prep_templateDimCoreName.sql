CREATE PROCEDURE [templateSchema].[usp_predim_prep_templateDimCoreName]
AS
	INSERT INTO templateSchema.predim_prep_templateDimCoreName
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
		THEN GetMaxSNK.MaxSNK + (ROW_NUMBER() OVER (ORDER BY COALESE(dim.SNK_templateDimCoreName,-1) ASC ) )
		ELSE dim.[SNK_templateDimCoreName]
	END AS [SNK_templateDimCoreName]
	,stg.NK_SourceSystemID1
	,stg.NK_SourceSystemID2
	,COALESCE(stg.SampleColumnOne,'*UNKNOWN') AS SampleColumnOne
	,COALESCE(stg.SampleColumnTwo,'*UNKNOWN') AS SampleColumnTwo
	,CASE WHEN dim.[SNK_templateDimCoreName] IS NULL
		THEN CONVERT(DATETIME2,'1900-01-01',102)
		ELSE stg.Ctl_EffectiveDate
	END AS Ctl_EffectiveDate
	,CASE WHEN dim.[SNK_templateDimCoreName] IS NULL
		THEN 'NEW'
		ELSE 'PENDING'
	END AS SCD_Status
	FROM templateSchema.stg_dimSrc_templateDimCoreName stg
	LEFT OUTER JOIN templateSchema.Dim_templateDimCoreName dim
	ON dim.Ctl_CurrentFlag = 1
	AND dim.NK_SourceSystemID1 = stg.NK_SourceSystemID1
	AND dim.NK_SourceSystemID2 = stg.NK_SourceSystemID2
	CROSS JOIN (
		SELECT MAX(SNK_templateDimCoreName) as MaxSNK FROM templateSchema.Dim_templateDimCoreName
	) AS GetMaxSNK
;
