CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimSetup_PostUpgradeInitialization_0dot1_CreateSNKValuesAndPopulateT1_usp]
AS

/*
	This needs to get run for any existing dimension from 0.0.* getting updated to 0.1.* right after deployment.
	Failure to do so will wreck the Type 6 dimension on the next load and the load will need to be restored over, backed out, or the table simply wiped.
*/

/*Only if not yet setup*/
IF EXISTS (SELECT 1 FROM [dimensionSchema].[templateDimCoreName_T1_dim])
BEGIN
	RETURN;
END

/*Assign SNKs*/
UPDATE thisDim
SET [SNK_templateDimCoreName] = [NewSNK]
FROM [dimensionSchema].[templateDimCoreName_Dim] AS thisDim
LEFT OUTER JOIN (
	SELECT
	DENSE_RANK() OVER (ORDER BY
		 [NK_SourceSystemID1]	/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
		,[NK_SourceSystemID2]	/*Sample*/
	) AS [NewSNK]
	,[SK_templateDimCoreName]
	FROM [dimensionSchema].[templateDimCoreName_Dim]
	WHERE [dimensionSchema].[templateDimCoreName_Dim].[SK_templateDimCoreName] > -1
) AS [GetSNK]
ON thisDim.[SK_templateDimCoreName] = [GetSNK].[SK_templateDimCoreName]
WHERE [thisDim].[SK_templateDimCoreName] > -1
;

/*Unknown members*/
UPDATE thisDim
SET [SNK_templateDimCoreName] = [SK_templateDimCoreName]
FROM [dimensionSchema].[templateDimCoreName_Dim] AS [thisDim]
WHERE [thisDim].[SK_templateDimCoreName] <= -1
;

/*Load T1*/
INSERT INTO [dimensionSchema].[templateDimCoreName_T1_dim]
(
	 [SNK_templateDimCoreName]
	,
	 [NK_SourceSystemID1]					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,[NK_SourceSystemID2]					/*Sample*/
	,
	 [SampleColumnOne_Cur]		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
	,[SampleColumnTwo_Cur]		/*Sample*/
	,[templateDimCoreName_IsMissing]
)
SELECT
	 [SNK_templateDimCoreName]
	,
	 [NK_SourceSystemID1]					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,[NK_SourceSystemID2]					/*Sample*/
	,
	 [SampleColumnOne_Cur]		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
	,[SampleColumnTwo_Cur]		/*Sample*/
	,[templateDimCoreName_IsMissing]
FROM [dimensionSchema].[templateDimCoreName_Dim]
WHERE [Ctl_CurrentFlag] = 1;
