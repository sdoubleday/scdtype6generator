CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimUpsert_Step1_Update_usp]
AS
	UPDATE dim
	SET
	 dim.[SampleColumnOne_Cur] = prep.[SampleColumnOne]
	,dim.[SampleColumnTwo_Cur] = prep.[SampleColumnTwo]
	
	,dim.[Ctl_EndDate] = CASE WHEN dim.[Ctl_CurrentFlag] = 1 THEN prep.Ctl_EffectiveDate ELSE dim.[Ctl_EndDate] END
	,dim.[Ctl_CurrentFlag] = CASE WHEN dim.[Ctl_CurrentFlag] = 1 THEN 0 ELSE dim.[Ctl_CurrentFlag] END
	
	FROM [templateSchema].[Dim_templateDimCoreName] dim
	INNER JOIN [templateSchema].[templateDimCoreName_predim_prep] prep
	ON dim.[SNK_templateDimCoreName] = prep.[SNK_templateDimCoreName]
;