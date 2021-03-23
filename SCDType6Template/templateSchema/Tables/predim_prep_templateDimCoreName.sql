CREATE TABLE [templateSchema].[predim_prep_templateDimCoreName]
(
	 [SNK_templateDimCoreName] INT NOT NULL
	,[NK_SourceSystemID1] INT NOT NULL
	,[NK_SourceSystemID2] INT NOT NULL
	,[SampleColumnOne] VARCHAR(500) NOT NULL
	,[SampleColumnTwo] VARCHAR(500) NOT NULL
	,[Ctl_EffectiveDate] DATETIME2(7) NOT NULL
	,[SCD_Status] VARCHAR(30) NOT NULL /*NEW/UPDATE/IGNORE*/ DEFAULT df_templateSchema_templateDimCoreName_SCD_Status ('PENDING')
)
