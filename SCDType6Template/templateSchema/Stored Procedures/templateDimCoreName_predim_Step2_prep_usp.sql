﻿CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_Step2_prep_usp]
AS
	INSERT INTO [templateSchema].[templateDimCoreName_predim_prep]
	(
		 [NK_SourceSystemID1]
		,[NK_SourceSystemID2]
		,[SampleColumnOne]
		,[SampleColumnTwo]
		,[Ctl_EffectiveDate]
		,[SCD_Status]
	)
	SELECT 
	 [NK_SourceSystemID1]
	,[NK_SourceSystemID2]
	,[SampleColumnOne]
	,[SampleColumnTwo]
	,[Ctl_EffectiveDate]
	,[SCD_Status]
	FROM [templateSchema].[templateDimCoreName_predim_Step2_prep_columnTransformations_vw] as a
;
