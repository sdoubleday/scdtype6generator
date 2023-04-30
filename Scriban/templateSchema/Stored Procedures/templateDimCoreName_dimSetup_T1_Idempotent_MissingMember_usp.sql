CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimSetup_T1_Idempotent_MissingMember_usp]
	@MissingMemberString VARCHAR(500) = 'Context Not Specified'
	,@MissingMemberSNK INT = -1
	,@MissingMemberNK INT = -1
	,@Force BIT = 0
AS
INSERT INTO [dimensionSchema].[templateDimCoreName_T1_dim]
(
 [SNK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne_Cur]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]			/*Sample*/
)
SELECT
 [SNK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne_Cur]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]			/*Sample*/
FROM (
VALUES (
 @MissingMemberSNK
,
 @MissingMemberNK			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,@MissingMemberNK			/*Sample*/
,
 @MissingMemberString			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,@MissingMemberString			/*Sample*/
)

) as a (
 [SNK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne_Cur]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]			/*Sample*/
)
WHERE NOT EXISTS
(SELECT [SNK_templateDimCoreName] FROM [dimensionSchema].[templateDimCoreName_T1_dim] WHERE [SNK_templateDimCoreName] = @MissingMemberSNK)
;

UPDATE [dimensionSchema].[templateDimCoreName_T1_dim]
SET
[templateDimCoreName_IsMissing] = 1
WHERE [SNK_templateDimCoreName] = @MissingMemberSNK
;

IF @Force = 1
BEGIN
	UPDATE [dimensionSchema].[templateDimCoreName_T1_dim]
	SET
	 [SampleColumnOne_Cur] = @MissingMemberString			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
	,[SampleColumnTwo_Cur] = @MissingMemberString			/*Sample*/

	WHERE [SNK_templateDimCoreName] = @MissingMemberSNK
END
;