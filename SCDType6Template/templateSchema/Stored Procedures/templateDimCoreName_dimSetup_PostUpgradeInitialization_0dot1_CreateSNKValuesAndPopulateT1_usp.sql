CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimSetup_PostUpgradeInitialization_0dot1_CreateSNKValuesAndPopulateT1_usp]
AS

IF EXISTS (SELECT 1 FROM [dimensionSchema].[templateDimCoreName_T1_dim])
BEGIN
	RETURN;
END

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

UPDATE thisDim
SET [SNK_templateDimCoreName] = [SK_templateDimCoreName]
FROM [dimensionSchema].[templateDimCoreName_Dim] AS [thisDim]
WHERE [thisDim].[SK_templateDimCoreName] <= -1
;

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
