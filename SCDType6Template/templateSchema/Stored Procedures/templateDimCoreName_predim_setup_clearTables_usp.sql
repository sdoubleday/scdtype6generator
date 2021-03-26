CREATE PROCEDURE [templateSchema].[templateDimCoreName_predim_setup_clearTables_usp]
AS
DELETE [templateSchema].[templateDimCoreName_dimSrc_stg];
DELETE [templateSchema].[templateDimCoreName_predim_prep];
DELETE [templateSchema].[templateDimCoreName_predim_copycurrent];

