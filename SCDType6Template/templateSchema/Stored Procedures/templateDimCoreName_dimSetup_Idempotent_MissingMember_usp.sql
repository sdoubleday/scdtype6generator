CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimSetup_Idempotent_MissingMember_usp]
	@MissingMemberString VARCHAR(500) = 'Context Not Specified'
	,@MissingMemberSK INT = -1
	,@MissingMemberNK INT = -1
AS
INSERT INTO [dimensionSchema].[templateDimCoreName_Dim]
(
 [SK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne_Cur]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,
 [SampleColumnOne_Hist]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]			/*Sample*/
,[SampleColumnTwo_Hist]			/*Sample*/
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]
)
SELECT
 [SK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne_Cur]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,
 [SampleColumnOne_Hist]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]			/*Sample*/
,[SampleColumnTwo_Hist]			/*Sample*/
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]
FROM (
VALUES (
 @MissingMemberSK
,
 @MissingMemberNK			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,@MissingMemberNK			/*Sample*/
,
 @MissingMemberString			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,
 @MissingMemberString			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,@MissingMemberString			/*Sample*/
,@MissingMemberString			/*Sample*/
,1
,CONVERT(DATETIME2,'1900-01-01',102)
,CONVERT(datetime2,'9999-12-31',102)
)

) as a (
 [SK_templateDimCoreName]
,
 [NK_SourceSystemID1]			/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
,[NK_SourceSystemID2]			/*Sample*/
,
 [SampleColumnOne_Cur]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,
 [SampleColumnOne_Hist]			/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
,[SampleColumnTwo_Cur]			/*Sample*/
,[SampleColumnTwo_Hist]			/*Sample*/
,[Ctl_CurrentFlag]
,[Ctl_EffectiveDate]
,[Ctl_EndDate_Excl]
)
WHERE NOT EXISTS
(SELECT [SK_templateDimCoreName] FROM [dimensionSchema].[templateDimCoreName_Dim] WHERE [SK_templateDimCoreName] = @MissingMemberSK)
;

