CREATE TABLE [templateSchema].[stg_dimSrc_templateDimCoreName]
(
/*BEGIN Columns from end user*/
/*Needs one or more NK_ columns to form the composite natural key. NKs cannot be NULL.*/
	 [NK_SourceSystemID1] INT NOT NULL
	,[NK_SourceSystemID2] INT NOT NULL
	,[SampleColumnOne] VARCHAR(500) NULL
	,[SampleColumnTwo] INT NULL
	,[Ctl_EffectiveDate] DATETIME2(7) NOT NULL CONSTRAINT [df_templateSchema_templateDimCoreName_Ctl_EffectiveDate] DEFAULT (GETDATE())
/*END Columns from end user*/
)
