CREATE PROCEDURE [templateSchema].[usp_templateDimCoreName_predim_prep_updateSCDStatus]
AS
	UPDATE prep
	SET [SCD_Status] = 
		CASE
			WHEN updateable.[SNK_templateDimCoreName] IS NULL
			THEN 'IGNORE'
			ELSE 'UPDATE'
		END
	FROM [templateSchema].[predim_prep_templateDimCoreName] prep
	LEFT OUTER JOIN [templateSchema].[vw_templateDimCoreName_FindUpdates] as updateable
	ON prep.[SNK_templateDimCoreName] = updateable.[SNK_templateDimCoreName]
	WHERE prep.[SCD_Status] = 'PENDING'
	;
	DELETE [templateSchema].[predim_prep_templateDimCoreName]
	WHERE [SCD_Status] = 'IGNORE';
