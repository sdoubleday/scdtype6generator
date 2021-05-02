CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_orchestration_usp]
AS
DECLARE @StgIsTable BIT;
EXECUTE @StgIsTable = [templateSchema].[templateDimCoreName_Predim_ControlFlow_IsStgATable_usp];
IF @StgIsTable = 1
BEGIN
	EXECUTE [templateSchema].[templateDimCoreName_predim_setup_clearTables_usp];
END
EXECUTE [templateSchema].[templateDimCoreName_predim_Step1_copycurrent_usp];
EXECUTE [templateSchema].[templateDimCoreName_predim_Step2_prep_usp];
EXECUTE [templateSchema].[templateDimCoreName_predim_Step3_prep_updateSCDStatus_usp];
EXECUTE [templateSchema].[templateDimCoreName_predim_Step4_prep_DeleteIgnorable];
