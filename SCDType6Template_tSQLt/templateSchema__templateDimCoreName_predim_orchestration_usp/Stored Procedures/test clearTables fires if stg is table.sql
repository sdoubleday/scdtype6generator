﻿CREATE PROCEDURE [templateSchema__templateDimCoreName_predim_orchestration_usp].[test clearTables fires if stg is table]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[templateSchema__templateDimCoreName_predim_orchestration_usp].ACTUAL') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_predim_orchestration_usp].ACTUAL;
	IF OBJECT_ID('[templateSchema__templateDimCoreName_predim_orchestration_usp].EXPECTED') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_predim_orchestration_usp].EXPECTED;

	EXECUTE tSQLt.SpyProcedure @ProcedureName = '[templateSchema].[templateDimCoreName_predim_setup_clearTables_usp]';
	DECLARE @Expected INT = 1;
	
	--ACT
	EXECUTE [templateSchema].[templateDimCoreName_predim_orchestration_usp];

	--ASSERT
	DECLARE @Actual INT = NULL;
	SELECT @Actual = COUNT(1) FROM [templateSchema].[templateDimCoreName_predim_setup_clearTables_usp_SpyProcedureLog];

	EXECUTE [tSQLt].AssertEquals @Expected = @Expected, @Actual = @Actual;

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