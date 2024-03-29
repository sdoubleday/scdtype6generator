﻿CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step3_prep_updateSCDStatus_usp]
AS
	UPDATE prep
	SET [SCD_Status] = 
		CASE
			WHEN
			dim.[SNK_templateDimCoreName] IS NULL
			THEN 'IGNORE'
			ELSE 'UPDATE'
		END
	FROM [templateSchema].[templateDimCoreName_predim_prep] prep
	LEFT OUTER JOIN [templateSchema].[templateDimCoreName_FindUpdates_vw] as dim
	ON
	prep.[SNK_templateDimCoreName] = dim.[SNK_templateDimCoreName]
	WHERE prep.[SCD_Status] = 'PENDING'
	;
