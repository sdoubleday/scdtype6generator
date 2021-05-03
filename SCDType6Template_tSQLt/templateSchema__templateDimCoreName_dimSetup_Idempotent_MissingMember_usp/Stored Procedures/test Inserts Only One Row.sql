﻿CREATE PROCEDURE [templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].[test Inserts Only One Row]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].ACTUAL') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].ACTUAL;
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].EXPECTED') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].EXPECTED;

	EXECUTE tSQLt.FakeTable @TableName = '[dimensionSchema].[templateDimCoreName_Dim]';
	
	--ACT
	DECLARE @SK INT = -2;
	DECLARE @NK INT = -2;
	DECLARE @MissingString VARCHAR(500) = 'MissingString';
	EXECUTE [templateSchema].[templateDimCoreName_dimSetup_Idempotent_MissingMember_usp] @MissingMemberString = @MissingString, @MissingMemberSK = @SK, @MissingMemberNK = @NK;
	EXECUTE [templateSchema].[templateDimCoreName_dimSetup_Idempotent_MissingMember_usp] @MissingMemberString = @MissingString, @MissingMemberSK = @SK, @MissingMemberNK = @NK;

	SELECT 
	 [d].[SK_templateDimCoreName]
	,[d].[NK_SourceSystemID1]
	,[d].[NK_SourceSystemID2]
	,[d].[SampleColumnOne_Cur]
	,[d].[SampleColumnOne_Hist]
	,[d].[SampleColumnTwo_Cur]
	,[d].[SampleColumnTwo_Hist]
	,[d].[Ctl_CurrentFlag]
	,[d].[Ctl_EffectiveDate]
	,[d].[Ctl_EndDate_Excl]
	INTO [templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].ACTUAL
	FROM [dimensionSchema].[templateDimCoreName_Dim] d;

	--ASSERT
	CREATE TABLE [templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].EXPECTED (
		 [SK_templateDimCoreName] INT NOT NULL
		,[NK_SourceSystemID1] NVARCHAR(500) NOT NULL
		,[NK_SourceSystemID2] NVARCHAR(500) NOT NULL
		,[SampleColumnOne_Cur] VARCHAR(500) NOT NULL
		,[SampleColumnOne_Hist] VARCHAR(500) NOT NULL
	);
	INSERT INTO [templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].EXPECTED (
		 [SK_templateDimCoreName]
		,[NK_SourceSystemID1]
		,[NK_SourceSystemID2]
		,[SampleColumnOne_Cur]
		,[SampleColumnOne_Hist]
	) VALUES (
		 @SK
		,@NK
		,@NK
		,@MissingString
		,@MissingString
	);

	EXECUTE [tSQLt].AssertEqualsTable @Expected = '[templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].EXPECTED'
,@Actual = '[templateSchema__templateDimCoreName_dimSetup_Idempotent_MissingMember_usp].ACTUAL';

END

/****
Script generated by cookiecutter
,for completion by user.
https://github.com/sdoubleday/cookiecutter-tsqlt-class-vs
This test compares the contents of EXPECTED and ACTUAL.
****/
/****
Suggestion: Verify the object being selected from in the
Act section. It defaults to your object under test.
****/
