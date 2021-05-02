CREATE PROCEDURE [templateSchema__templateDimCoreName_orchestration_usp].[test Dim Load]
AS
BEGIN
	--ASSEMBLE
	IF OBJECT_ID('[templateSchema__templateDimCoreName_orchestration_usp].ACTUAL') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_orchestration_usp].ACTUAL;
	IF OBJECT_ID('[templateSchema__templateDimCoreName_orchestration_usp].EXPECTED') IS NOT NULL DROP TABLE [templateSchema__templateDimCoreName_orchestration_usp].EXPECTED;

	/*Do you need to fake tables and insert rows?
	EXECUTE tSQLt.FakeTable @TableName = '[templateSchema].TableName';
	*/
	/*Do you need to spyprocedure?
	EXECUTE tSQLt.SpyProcedure @ProcedureName = '[templateSchema].ProcedureName'
	--,@CommandToExecute = 'SELECT 1'
	SELECT _id_, MyParameterName1, MyParameterName2 FROM [templateSchema].ProcedureName_SpyProcedureLog
	SELECT COUNT(1) FROM [templateSchema].ProcedureName_SpyProcedureLog
	*/
	DECLARE @Date1 DATETIME2 = '1999-12-31';
	DECLARE @Date2 DATETIME2 = '2000-01-01';
	DECLARE @Date3 DATETIME2 = '2000-01-02';
	EXECUTE TestHelpers.[DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg] @NK_SourceSystemID1 = 1, @NK_SourceSystemID2 = 11, @SampleColumnOne = 'Fred', @SampleColumnTwo = '1', @Ctl_EffectiveDate = @Date1;
	EXECUTE TestHelpers.[DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg] @NK_SourceSystemID1 = 2, @NK_SourceSystemID2 = 22, @SampleColumnOne = '2', @SampleColumnTwo = '2', @Ctl_EffectiveDate = @Date1;

	EXECUTE [templateSchema].[templateDimCoreName_orchestration_usp];
	
	EXECUTE [templateSchema].[templateDimCoreName_dimSrc_clearTables_usp]
	/*Update*/
	EXECUTE TestHelpers.[DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg] @NK_SourceSystemID1 = 1, @NK_SourceSystemID2 = 11, @SampleColumnOne = 'FredPrime', @SampleColumnTwo = '1', @Ctl_EffectiveDate = @Date2;
	/*Unchanged*/
	EXECUTE TestHelpers.[DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg] @NK_SourceSystemID1 = 2, @NK_SourceSystemID2 = 22, @SampleColumnOne = '2', @SampleColumnTwo = '2', @Ctl_EffectiveDate = @Date2;
	/*New*/
	EXECUTE TestHelpers.[DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg] @NK_SourceSystemID1 = 3, @NK_SourceSystemID2 = 33, @SampleColumnOne = 'Fred', @SampleColumnTwo = '2', @Ctl_EffectiveDate = @Date2;

	EXECUTE [templateSchema].[templateDimCoreName_orchestration_usp];

	EXECUTE [templateSchema].[templateDimCoreName_dimSrc_clearTables_usp];
	/*Updates*/
	EXECUTE TestHelpers.[DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg] @NK_SourceSystemID1 = 1, @NK_SourceSystemID2 = 11, @SampleColumnOne = 'FredPrime', @SampleColumnTwo = '10', @Ctl_EffectiveDate = @Date3;
	EXECUTE TestHelpers.[DataBuilder_StagingSchema_templateDimCoreName_dimSrc_stg] @NK_SourceSystemID1 = 3, @NK_SourceSystemID2 = 33, @SampleColumnOne = 'Fred', @SampleColumnTwo = '20', @Ctl_EffectiveDate = @Date3;

	--ACT
	EXECUTE [templateSchema].[templateDimCoreName_orchestration_usp];

	SELECT 
	 [NK_SourceSystemID1]
	,[NK_SourceSystemID2]
	,[SampleColumnOne_Cur]
	,[SampleColumnOne_Hist]
	,[SampleColumnTwo_Cur]
	,[SampleColumnTwo_Hist]
	,[Ctl_CurrentFlag]
	,[Ctl_EffectiveDate]
	,[Ctl_EndDate_Excl]
	INTO [templateSchema__templateDimCoreName_orchestration_usp].ACTUAL
	FROM [dimensionSchema].[templateDimCoreName_Dim];

	--ASSERT
	CREATE TABLE [templateSchema__templateDimCoreName_orchestration_usp].EXPECTED (
		 [NK_SourceSystemID1] INT NOT NULL /*Natural Key*/
		,[NK_SourceSystemID2] INT NOT NULL /*Natural Key*/
		,[SampleColumnOne_Cur] VARCHAR(500) NOT NULL
		,[SampleColumnOne_Hist] VARCHAR(500) NOT NULL
		,[SampleColumnTwo_Cur] VARCHAR(500) NOT NULL
		,[SampleColumnTwo_Hist] VARCHAR(500) NOT NULL
		,[Ctl_CurrentFlag] BIT NOT NULL
		,[Ctl_EffectiveDate] DATETIME2(7) NOT NULL
		,[Ctl_EndDate_Excl] DATETIME2(7) NOT NULL
	);
	INSERT INTO [templateSchema__templateDimCoreName_orchestration_usp].EXPECTED (
		 [NK_SourceSystemID1]
		,[NK_SourceSystemID2]
		,[SampleColumnOne_Cur]
		,[SampleColumnOne_Hist]
		,[SampleColumnTwo_Cur]
		,[SampleColumnTwo_Hist]
		,[Ctl_CurrentFlag]
		,[Ctl_EffectiveDate]
		,[Ctl_EndDate_Excl]
	)
	SELECT
		 [NK_SourceSystemID1]
		,[NK_SourceSystemID2]
		,[SampleColumnOne_Cur]
		,[SampleColumnOne_Hist]
		,[SampleColumnTwo_Cur]
		,[SampleColumnTwo_Hist]
		,[Ctl_CurrentFlag]
		,[Ctl_EffectiveDate]
		,[Ctl_EndDate_Excl]
	FROM (VALUES (
		 1		--[NK_SourceSystemID1]
		,11		--[NK_SourceSystemID2]
		,'FredPrime'		--[SampleColumnOne_Cur]
		,'Fred'		--[SampleColumnOne_Hist]
		,'10'		--[SampleColumnTwo_Cur]
		,'1'		--[SampleColumnTwo_Hist]
		,0		--[Ctl_CurrentFlag]
		,'1900-01-01'		--[Ctl_EffectiveDate]
		,'2000-01-01'		--[Ctl_EndDate_Excl]
	),(
		 1		--[NK_SourceSystemID1]
		,11		--[NK_SourceSystemID2]
		,'FredPrime'		--[SampleColumnOne_Cur]
		,'FredPrime'		--[SampleColumnOne_Hist]
		,'10'		--[SampleColumnTwo_Cur]
		,'1'		--[SampleColumnTwo_Hist]
		,0		--[Ctl_CurrentFlag]
		,'2000-01-01'		--[Ctl_EffectiveDate]
		,'2000-01-02'		--[Ctl_EndDate_Excl]
	),(
		 1		--[NK_SourceSystemID1]
		,11		--[NK_SourceSystemID2]
		,'FredPrime'		--[SampleColumnOne_Cur]
		,'FredPrime'		--[SampleColumnOne_Hist]
		,'10'		--[SampleColumnTwo_Cur]
		,'10'		--[SampleColumnTwo_Hist]
		,1		--[Ctl_CurrentFlag]
		,'2000-01-02'		--[Ctl_EffectiveDate]
		,'9999-12-31'		--[Ctl_EndDate_Excl]
	),(
		 2		--[NK_SourceSystemID1]
		,22		--[NK_SourceSystemID2]
		,'2'		--[SampleColumnOne_Cur]
		,'2'		--[SampleColumnOne_Hist]
		,'2'		--[SampleColumnTwo_Cur]
		,'2'		--[SampleColumnTwo_Hist]
		,1		--[Ctl_CurrentFlag]
		,'1900-01-01'		--[Ctl_EffectiveDate]
		,'9999-12-31'		--[Ctl_EndDate_Excl]
	),(
		 3		--[NK_SourceSystemID1]
		,33		--[NK_SourceSystemID2]
		,'Fred'		--[SampleColumnOne_Cur]
		,'Fred'		--[SampleColumnOne_Hist]
		,'20'		--[SampleColumnTwo_Cur]
		,'2'		--[SampleColumnTwo_Hist]
		,0		--[Ctl_CurrentFlag]
		,'1900-01-01'		--[Ctl_EffectiveDate]
		,'2000-01-02'		--[Ctl_EndDate_Excl]
	),(
		 3		--[NK_SourceSystemID1]
		,33		--[NK_SourceSystemID2]
		,'Fred'		--[SampleColumnOne_Cur]
		,'Fred'		--[SampleColumnOne_Hist]
		,'20'		--[SampleColumnTwo_Cur]
		,'20'		--[SampleColumnTwo_Hist]
		,1		--[Ctl_CurrentFlag]
		,'2000-01-02'		--[Ctl_EffectiveDate]
		,'9999-12-31'		--[Ctl_EndDate_Excl]
	),(
		 -1		--[NK_SourceSystemID1]
		,-1		--[NK_SourceSystemID2]
		,'Context Not Specified'		--[SampleColumnOne_Cur]
		,'Context Not Specified'		--[SampleColumnOne_Hist]
		,'Context Not Specified'		--[SampleColumnTwo_Cur]
		,'Context Not Specified'		--[SampleColumnTwo_Hist]
		,1		--[Ctl_CurrentFlag]
		,'1900-01-01'		--[Ctl_EffectiveDate]
		,'9999-12-31'		--[Ctl_EndDate_Excl]
	) ) AS a (
		 [NK_SourceSystemID1]
		,[NK_SourceSystemID2]
		,[SampleColumnOne_Cur]
		,[SampleColumnOne_Hist]
		,[SampleColumnTwo_Cur]
		,[SampleColumnTwo_Hist]
		,[Ctl_CurrentFlag]
		,[Ctl_EffectiveDate]
		,[Ctl_EndDate_Excl]
	)
	;

	EXECUTE [tSQLt].AssertEqualsTable @Expected = '[templateSchema__templateDimCoreName_orchestration_usp].EXPECTED', @Actual = '[templateSchema__templateDimCoreName_orchestration_usp].ACTUAL';

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
