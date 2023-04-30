CREATE VIEW [templateSchema].[templateDimCoreName_dimUpsert_GetMaxSK_vw]
AS
SELECT
	CASE
		WHEN MAX([SK_templateDimCoreName]) < 1 THEN 1
		WHEN MAX([SK_templateDimCoreName]) IS NULL THEN 1
		ELSE MAX([SK_templateDimCoreName])
	END AS [MaxSK]
FROM [dimensionSchema].[templateDimCoreName_Dim];
