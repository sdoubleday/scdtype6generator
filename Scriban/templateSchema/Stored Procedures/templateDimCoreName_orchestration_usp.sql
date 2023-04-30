CREATE PROCEDURE [templateSchema].[templateDimCoreName_orchestration_usp]
AS

EXECUTE [templateSchema].[templateDimCoreName_dimSetup_Idempotent_MissingMember_usp];
EXECUTE [templateSchema].[templateDimCoreName_predim_orchestration_usp];
EXECUTE [templateSchema].[templateDimCoreName_dimUpsert_Step1_Update_usp];
EXECUTE [templateSchema].[templateDimCoreName_dimUpsert_Step2_Insert_usp];
EXECUTE [templateSchema].[templateDimCoreName_dimUpsert_T1_Step1_Update_usp];
EXECUTE [templateSchema].[templateDimCoreName_dimUpsert_T1_Step2_Insert_usp];
