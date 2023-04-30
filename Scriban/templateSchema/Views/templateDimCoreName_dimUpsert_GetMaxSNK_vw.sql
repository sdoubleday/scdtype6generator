CREATE VIEW [templateSchema].[templateDimCoreName_predim_GetMaxSNK_vw]
AS
SELECT
	CASE
		WHEN MAX(SNK_templateDimCoreName) >= 1 THEN MAX(SNK_templateDimCoreName)
		WHEN MAX(SNK_templateDimCoreName) < 1 THEN 1
		WHEN MAX(SNK_templateDimCoreName) IS NULL THEN 1
	END AS [MaxSNK]
FROM [dimensionSchema].[templateDimCoreName_Dim];
