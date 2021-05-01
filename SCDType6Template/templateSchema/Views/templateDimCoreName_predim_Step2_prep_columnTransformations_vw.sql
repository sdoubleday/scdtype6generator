CREATE VIEW [templateSchema].[templateDimCoreName_predim_Step2_prep_columnTransformations_vw]
AS
SELECT 
 stg.[NK_SourceSystemID1]																	/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,stg.[NK_SourceSystemID2]																	/*Sample*/
,
 COALESCE(CAST(stg.[SampleColumnOne] AS VARCHAR(500)),'*UNKNOWN') AS [SampleColumnOne]		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,COALESCE(CAST(stg.[SampleColumnTwo] AS VARCHAR(500)),'*UNKNOWN') AS [SampleColumnTwo]		/*Sample*/
,CASE WHEN dim.[SK_templateDimCoreName] IS NULL
	THEN CONVERT(DATETIME2,'1900-01-01',102)
	ELSE stg.[Ctl_EffectiveDate]
END AS [Ctl_EffectiveDate]
,CASE WHEN dim.[SK_templateDimCoreName] IS NULL
	THEN 'NEW'
	ELSE 'PENDING'
END AS [SCD_Status]
FROM [StagingSchema].[templateDimCoreName_dimSrc_stg] stg
LEFT OUTER JOIN [templateSchema].[templateDimCoreName_Dim] dim
ON dim.[Ctl_CurrentFlag] = 1
AND
 dim.[NK_SourceSystemID1] = stg.[NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|AND*/
AND dim.[NK_SourceSystemID2] = stg.[NK_SourceSystemID2]		/*Sample*/
;
