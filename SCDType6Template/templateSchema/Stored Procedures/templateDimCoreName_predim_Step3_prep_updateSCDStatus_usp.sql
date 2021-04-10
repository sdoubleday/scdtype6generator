CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step3_prep_updateSCDStatus_usp]
AS
	UPDATE prep
	SET [SCD_Status] = 
		CASE
			WHEN dim.[NK_SourceSystemID1] IS NULL				/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|AND*/
			AND dim.[NK_SourceSystemID2] IS NULL				/*Sample*/
			THEN 'IGNORE'
			ELSE 'UPDATE'
		END
	FROM [templateSchema].[templateDimCoreName_predim_prep] prep
	LEFT OUTER JOIN [templateSchema].[templateDimCoreName_FindUpdates_vw] as dim
	ON prep.[NK_SourceSystemID1] = dim.[NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|AND*/
	AND prep.[NK_SourceSystemID2] = dim.[NK_SourceSystemID2]	/*Sample*/
	WHERE prep.[SCD_Status] = 'PENDING'
	;
