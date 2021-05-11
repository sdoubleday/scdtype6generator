CREATE FUNCTION [dimensionSchema].[templateDimCoreName_DimSKLookup_usvf]
(
	 @NK_SourceSystemID1 NVARCHAR(500)					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,@NK_SourceSystemID2 NVARCHAR(500)					/*Sample*/
	,@Ctl_EffectiveDate DATETIME2(7)
	,@MissingMemberSK INT = -1
)
RETURNS INT
BEGIN
DECLARE @SK INT = NULL;


	SELECT
	@SK = [SK_templateDimCoreName]
	FROM [dimensionSchema].[templateDimCoreName_Dim] d
	WHERE
	d.[NK_SourceSystemID1] = @NK_SourceSystemID1		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	AND d.[NK_SourceSystemID2] = @NK_SourceSystemID2		/*Sample*/
	AND d.[Ctl_EffectiveDate] <= @Ctl_EffectiveDate
	AND d.[Ctl_EndDate_Excl] > @Ctl_EffectiveDate
;

SET @SK = COALESCE(@SK, @MissingMemberSK);

RETURN @SK;
END
