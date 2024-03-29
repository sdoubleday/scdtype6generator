﻿CREATE PROCEDURE [templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].[test SK Increments Correctly]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].ACTUAL') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].ACTUAL;
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].EXPECTED') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].EXPECTED;

	EXECUTE tSQLt.FakeTable @TableName = '[dimensionSchema].[templateDimCoreName_Dim]';
	EXECUTE tSQLt.FakeTable @TableName = '[templateSchema].templateDimCoreName_predim_prep';
	
	EXECUTE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = -1;
	EXECUTE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 1;
	EXECUTE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 2;
	EXECUTE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SK_templateDimCoreName = 3;

	EXECUTE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_prep];
	EXECUTE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_prep];
	
	--ACT
	SELECT 
	[SK_templateDimCoreName]
	INTO [templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].ACTUAL
	FROM [templateSchema].[templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw];

	--ASSERT
	CREATE TABLE [templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].EXPECTED (
		[SK_templateDimCoreName] BIGINT
	);
	INSERT INTO [templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].EXPECTED (
		[SK_templateDimCoreName]
	) VALUES (4),(5);

	EXECUTE [tSQLt].AssertEqualsTable @Expected = '[templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].EXPECTED', @Actual = '[templateSchema__templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw].ACTUAL';

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
