﻿CREATE PROCEDURE [templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].[test When Max SK Is Positive Return It]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].ACTUAL') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].ACTUAL;
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].EXPECTED') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimUpsert_GetMaxSK_vw].EXPECTED;

	EXECUTE tSQLt.FakeTable @TableName = '[dimensionSchema].[templateDimCoreName_Dim]';

	EXECUTE TestHelpers.[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = -1;
	EXECUTE TestHelpers.[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 1;
	EXECUTE TestHelpers.[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 2;
	EXECUTE TestHelpers.[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 3;

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
		3
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
