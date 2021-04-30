CREATE TABLE [templateSchema].[templateDimCoreName_predim_copycurrent]
(
	 [NK_SourceSystemID1] INT NOT NULL					/*NaturalKey_ReplacementPoint|NK_SourceSystemID1*/
	,[NK_SourceSystemID2] INT NOT NULL					/*Sample*/
	,[SampleColumnOne_Cur] VARCHAR(500) NOT NULL		/*DimensionAttribute_ReplacementPoint|SampleColumnOne*/
	,[SampleColumnTwo_Cur] VARCHAR(500) NOT NULL		/*Sample*/
)
