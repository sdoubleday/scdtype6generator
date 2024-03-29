﻿CREATE TABLE [templateSchema].[templateDimCoreName_predim_prep]
(
	 [SNK_templateDimCoreName] INT NOT NULL
	,
	 [NK_SourceSystemID1] NVARCHAR(500) NOT NULL				/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,[NK_SourceSystemID2] NVARCHAR(500) NOT NULL				/*Sample*/
	,
	 [SampleColumnOne] VARCHAR(500) NOT NULL		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
	,[SampleColumnTwo] VARCHAR(500) NOT NULL		/*Sample*/
	,[Ctl_EffectiveDate] DATETIME2(7) NOT NULL
	,[SCD_Status] VARCHAR(30) NOT NULL
)
