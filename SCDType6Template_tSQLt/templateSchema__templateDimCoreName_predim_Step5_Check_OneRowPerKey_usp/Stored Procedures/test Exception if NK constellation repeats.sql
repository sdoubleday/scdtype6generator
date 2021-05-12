﻿CREATE PROCEDURE [templateSchema__templateDimCoreName_predim_Step5_Check_OneRowPerKey_usp].[test Exception if NK constellation repeats]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[templateSchema__templateDimCoreName_predim_Step5_Check_OneRowPerKey_usp].ACTUAL') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_predim_Step5_Check_OneRowPerKey_usp].ACTUAL;
	IF OBJECT_ID('[templateSchema__templateDimCoreName_predim_Step5_Check_OneRowPerKey_usp].EXPECTED') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_predim_Step5_Check_OneRowPerKey_usp].EXPECTED;

	EXECUTE tSQLt.FakeTable @TableName = '[templateSchema].[templateDimCoreName_predim_prep]';
	EXECUTE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_prep] @NK_SourceSystemID1 = 1, @NK_SourceSystemID2 = 1;
	EXECUTE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_prep] @NK_SourceSystemID1 = 2, @NK_SourceSystemID2 = 2;
	EXECUTE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_prep] @NK_SourceSystemID1 = 2, @NK_SourceSystemID2 = 2;
	EXECUTE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_prep] @NK_SourceSystemID1 = 3, @NK_SourceSystemID2 = 3;

	--ACT
	EXECUTE tSQLt.ExpectException @ExpectedMessage = N'Multiple rows for one or more sets of Natural Keys. Only one row allowed per Natural Key set.'

	--ASSERT
	EXECUTE [templateSchema].[templateDimCoreName_predim_Step5_Check_OneRowPerKey_usp];

END

/****
Script generated by cookiecutter, for completion by user.
https://github.com/sdoubleday/cookiecutter-tsqlt-class-vs
This test compares the contents of EXPECTED and ACTUAL.
****/
/****
Suggestion: Update the @ExpectedMessage once you know
your error message.
****/
