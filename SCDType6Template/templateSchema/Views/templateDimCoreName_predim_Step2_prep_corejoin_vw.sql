CREATE VIEW [templateSchema].[templateDimCoreName_predim_Step2_prep_corejoin_vw]
AS
SELECT 
 stg.[NK_SourceSystemID1]
,stg.[NK_SourceSystemID2]
,stg.[SampleColumnOne]
,stg.[SampleColumnTwo]
,stg.[Ctl_EffectiveDate]
,dim.[SNK_templateDimCoreName] AS [dim__SNK_templateDimCoreName]
FROM [templateSchema].[templateDimCoreName_dimSrc_stg] stg
LEFT OUTER JOIN [templateSchema].[Dim_templateDimCoreName] dim
ON dim.Ctl_CurrentFlag = 1
AND dim.[NK_SourceSystemID1] = stg.[NK_SourceSystemID1]
AND dim.[NK_SourceSystemID2] = stg.[NK_SourceSystemID2]
;
