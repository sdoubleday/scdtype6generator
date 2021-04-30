CREATE TABLE [templateSchema].[Dim_templateDimCoreName]
(
	 [SK_templateDimCoreName] INT NOT NULL
	,[NK_SourceSystemID1] INT NOT NULL					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1*/
	,[NK_SourceSystemID2] INT NOT NULL					/*Sample*/
	,[SampleColumnOne_Cur] VARCHAR(500) NOT NULL		/*DimensionAttribute_ReplacementPoint|SampleColumnOne*/
	,[SampleColumnOne_Hist] VARCHAR(500) NOT NULL		/*DimensionAttribute_ReplacementPoint|SampleColumnOne*/
	,[SampleColumnTwo_Cur] VARCHAR(500) NOT NULL		/*Sample*/
	,[SampleColumnTwo_Hist] VARCHAR(500) NOT NULL		/*Sample*/
	,[Ctl_CurrentFlag] BIT NOT NULL
	,[Ctl_EffectiveDate] DATETIME2(7) NOT NULL
	,[Ctl_EndDate_Excl] DATETIME2(7) NOT NULL
	,CONSTRAINT [pk_templateSchema_templateDimCoreName] PRIMARY KEY CLUSTERED ([SK_templateDimCoreName])
	,INDEX [ncind_templateSchema_templateDimCoreName_CurrentNKLookup] NONCLUSTERED (
		 [Ctl_CurrentFlag]
		,[NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1*/
		,[NK_SourceSystemID2]		/*Sample*/
		,[SK_templateDimCoreName])
	,INDEX [ncind_templateSchema_templateDimCoreName_CurrentSKLookup] NONCLUSTERED ([Ctl_CurrentFlag],[SK_templateDimCoreName])
	,INDEX [ncind_templateSchema_templateDimCoreName_NKLookup] NONCLUSTERED (
		 [NK_SourceSystemID1]		/*NaturalKey_ReplacementPoint|NK_SourceSystemID1*/
		,[NK_SourceSystemID2]		/*Sample*/
		)
)
