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
	 CASE WHEN a.[dim__SNK_templateDimCoreName] IS NULL
		THEN GetMaxSNK.[MaxSNK] + (ROW_NUMBER() OVER (ORDER BY COALESCE(a.[dim__SNK_templateDimCoreName],-1) ASC ) )
		ELSE a.[dim__SNK_templateDimCoreName]
	END AS [SNK_templateDimCoreName]
	,a.[NK_SourceSystemID1]
	,a.[NK_SourceSystemID2]
	,COALESCE(a.[SampleColumnOne],'*UNKNOWN') AS [SampleColumnOne]
	,COALESCE(a.[SampleColumnTwo],'*UNKNOWN') AS [SampleColumnTwo]
	,CASE WHEN a.[dim__SNK_templateDimCoreName] IS NULL
		THEN CONVERT(DATETIME2,'1900-01-01',102)
		ELSE a.[Ctl_EffectiveDate]
	END AS [Ctl_EffectiveDate]
	,CASE WHEN a.[dim__SNK_templateDimCoreName] IS NULL
		THEN 'NEW'
		ELSE 'PENDING'
	END AS [SCD_Status]
	FROM [templateSchema].[templateDimCoreName_predim_Step2_prep_corejoin_vw] as a
	CROSS JOIN [templateSchema].[templateDimCoreName_predim_GetMaxSNK_vw] AS GetMaxSNK
;
