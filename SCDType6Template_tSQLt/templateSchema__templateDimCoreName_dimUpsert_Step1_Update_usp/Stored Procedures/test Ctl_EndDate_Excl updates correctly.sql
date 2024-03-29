﻿CREATE PROCEDURE [templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].[test Ctl_EndDate_Excl updates correctly]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].ACTUAL') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].ACTUAL;
	IF OBJECT_ID('[templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].EXPECTED') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].EXPECTED;

	EXECUTE tSQLt.FakeTable @TableName = '[dimensionSchema].[templateDimCoreName_Dim]';
	EXECUTE tSQLt.FakeTable @TableName = '[templateSchema].[templateDimCoreName_predim_prep]';

	EXECUTE [TestHelpers].[DataBuilder_dimensionSchema_templateDimCoreName_Dim] @SNK_templateDimCoreName = 1, @Ctl_CurrentFlag = 1, @Ctl_EffectiveDate = '1900-01-01', @Ctl_EndDate_Excl = '9999-12-31';

	EXECUTE [TestHelpers].[DataBuilder_templateSchema_templateDimCoreName_predim_prep] @SNK_templateDimCoreName = 1, @Ctl_EffectiveDate = '2000-01-01';

	--ACT
	EXECUTE [templateSchema].[templateDimCoreName_dimUpsert_Step1_Update_usp];
	
	SELECT 
	 [Ctl_CurrentFlag]
	,[Ctl_EffectiveDate]
	,[Ctl_EndDate_Excl]
	INTO [templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].ACTUAL
	FROM [dimensionSchema].[templateDimCoreName_Dim];

	--ASSERT
	CREATE TABLE [templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].EXPECTED (
		 [Ctl_CurrentFlag] BIT
		,[Ctl_EffectiveDate] DATETIME2(7)
		,[Ctl_EndDate_Excl] DATETIME2(7)
	);
	INSERT INTO [templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].EXPECTED (
		 [Ctl_CurrentFlag]
		,[Ctl_EffectiveDate]
		,[Ctl_EndDate_Excl]
	) VALUES (0,'1900-01-01','2000-01-01');--,(1,'2000-01-01','9999-12-31');

	EXECUTE [tSQLt].AssertEqualsTable @Expected = '[templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].EXPECTED', @Actual = '[templateSchema__templateDimCoreName_dimUpsert_Step1_Update_usp].ACTUAL';

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
