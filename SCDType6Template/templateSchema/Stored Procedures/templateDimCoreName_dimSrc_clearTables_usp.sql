CREATE PROCEDURE [templateSchema].[templateDimCoreName_dimSrc_clearTables_usp]
AS
DELETE [StagingSchema].[templateDimCoreName_dimSrc_stg];

