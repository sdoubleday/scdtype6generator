﻿CREATE PROCEDURE [templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].[test When Max SNK Is Negative Return 1]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].ACTUAL') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].ACTUAL;
	IF OBJECT_ID('[templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].EXPECTED') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].EXPECTED;

	EXECUTE tSQLt.FakeTable @TableName = '[templateSchema].Dim_templateDimCoreName';

	EXECUTE TestHelpers.DataBuilder_templateSchema_Dim_templateDimCoreName @SNK_templateDimCoreName = -1;

	--ACT
	SELECT 
	[MaxSNK]
	INTO [templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].ACTUAL
	FROM [templateSchema].[templateDimCoreName_predim_GetMaxSNK_vw];

	--ASSERT
	CREATE TABLE [templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].EXPECTED (
		[MaxSNK] BIGINT
	);
	INSERT INTO [templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].EXPECTED (
		[MaxSNK]
	) VALUES (
		1
	);

	EXECUTE [tSQLt].AssertEqualsTable @Expected = '[templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].EXPECTED', @Actual = '[templateSchema__templateDimCoreName_predim_GetMaxSNK_vw].ACTUAL';

END

/****
Script generated by cookiecutter, for completion by user.
https://github.com/sdoubleday/cookiecutter-tsqlt-class-vs
This test compares the contents of EXPECTED and ACTUAL.
****/
/****
Suggestion: Verify the object being selected from in the
Act section. It defaults to your object under test.
****/