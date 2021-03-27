﻿CREATE VIEW [templateSchema].[templateDimCoreName_predim_Step2_prep_columnTransformations_vw]
AS
SELECT 
 stg.[NK_SourceSystemID1]
,stg.[NK_SourceSystemID2]
,COALESCE(CAST(stg.[SampleColumnOne] AS VARCHAR(500)),'*UNKNOWN') AS [SampleColumnOne]
,COALESCE(CAST(stg.[SampleColumnTwo] AS VARCHAR(500)),'*UNKNOWN') AS [SampleColumnTwo]
,CASE WHEN dim.[SK_templateDimCoreName] IS NULL
	THEN CONVERT(DATETIME2,'1900-01-01',102)
	ELSE stg.[Ctl_EffectiveDate]
END AS [Ctl_EffectiveDate]
,CASE WHEN dim.[SK_templateDimCoreName] IS NULL
	THEN 'NEW'
	ELSE 'PENDING'
END AS [SCD_Status]
FROM [templateSchema].[templateDimCoreName_dimSrc_stg] stg
LEFT OUTER JOIN [templateSchema].[Dim_templateDimCoreName] dim
ON dim.Ctl_CurrentFlag = 1
AND dim.[NK_SourceSystemID1] = stg.[NK_SourceSystemID1]
AND dim.[NK_SourceSystemID2] = stg.[NK_SourceSystemID2]
;