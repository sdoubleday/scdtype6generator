﻿CREATE PROCEDURE [templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].[test When Max SK Is Negative Return 1]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].ACTUAL') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].ACTUAL;
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].EXPECTED') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].EXPECTED;

	EXECUTE tSQLt.FakeTable @TableName = '[templateSchema].[templateDimCoreName_Dim]';

	EXECUTE TestHelpers.[DataBuilder_templateSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = -1;

	--ACT
	SELECT 
	[MaxSK]
	INTO [templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].ACTUAL
	FROM [templateSchema].[templateDimCoreName_dimUpsert_GetMaxSK_vw];

	--ASSERT
	CREATE TABLE [templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].EXPECTED (
		[MaxSK] BIGINT
	);
	INSERT INTO [templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].EXPECTED (
		[MaxSK]
	) VALUES (
		1
	);

	EXECUTE [tSQLt].AssertEqualsTable @Expected = '[templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].EXPECTED', @Actual = '[templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].ACTUAL';

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
