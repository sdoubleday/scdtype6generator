CREATE TABLE [dimensionSchema].[templateDimCoreName_T1_dim]
(
	 [SNK_templateDimCoreName] INT NOT NULL
	,
	 [NK_SourceSystemID1] NVARCHAR(500) NOT NULL					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
	,[NK_SourceSystemID2] NVARCHAR(500) NOT NULL					/*Sample*/
	,
	 [SampleColumnOne_Cur] VARCHAR(500) NOT NULL		/*DimensionAttribute_ReplacementPoint|SampleColumnOne|,*/
	,[SampleColumnTwo_Cur] VARCHAR(500) NOT NULL		/*Sample*/
	,[templateDimCoreName_IsMissing] BIT NOT NULL CONSTRAINT [df_dimensionSchema_templateDimCoreName_T1_dim_IsMissing] DEFAULT (0)
	,[Ctl_rowversion] ROWVERSION NOT NULL
	,CONSTRAINT [pk_dimensionSchema_templateDimCoreName_T1_dim] PRIMARY KEY ([SNK_templateDimCoreName])
	,INDEX [ncind_dimensionSchema_templateDimCoreName_T1_dim_NKToSNKLookup] NONCLUSTERED (
		 [NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1|,*/
		,[NK_SourceSystemID2]		/*Sample*/
		,[SNK_templateDimCoreName]
	)
)
