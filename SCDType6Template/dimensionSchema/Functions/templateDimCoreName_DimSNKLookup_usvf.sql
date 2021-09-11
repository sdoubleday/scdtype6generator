CREATE FUNCTION [dimensionSchema].[templateDimCoreName_DimSNKLookup_usvf]
(
	 @NK_SourceSystemID1 NVARCHAR(500)					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,@NK_SourceSystemID2 NVARCHAR(500)					/*Sample*/
	,@MissingMemberSNK INT = -1
)
RETURNS INT
BEGIN
DECLARE @SNK INT = NULL;


	SELECT
	@SNK = [SNK_templateDimCoreName]
	FROM [dimensionSchema].[templateDimCoreName_T1_dim] d
	WHERE
	d.[NK_SourceSystemID1] = @NK_SourceSystemID1		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|AND*/
	AND d.[NK_SourceSystemID2] = @NK_SourceSystemID2		/*Sample*/
;

SET @SNK = COALESCE(@SNK, @MissingMemberSNK);

RETURN @SNK;
END
