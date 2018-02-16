CREATE TABLE [dbo].[BNDefaultValuesVisibility]
(
[ProjectId] [int] NOT NULL,
[StatusVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_StatusVisibility] DEFAULT ((1)),
[OwnedByVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_OwnedByVisibility] DEFAULT ((1)),
[PriorityVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PriorityVisibility] DEFAULT ((1)),
[AssignedToVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AssignedToVisibility] DEFAULT ((1)),
[PrivateVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PrivateVisibility] DEFAULT ((1)),
[CategoryVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_CategoryVisibility] DEFAULT ((1)),
[DueDateVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_DueDateVisibility] DEFAULT ((1)),
[TypeVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_TypeVisibility] DEFAULT ((1)),
[PercentCompleteVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PercentCompleteVisibility] DEFAULT ((1)),
[MilestoneVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_MilestoneVisibility] DEFAULT ((1)),
[EstimationVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_EstimationVisibility] DEFAULT ((1)),
[ResolutionVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_ResolutionVisibility] DEFAULT ((1)),
[AffectedMilestoneVisibility] [bit] NOT NULL CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AffectedMilestoneVisivility] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BNDefaultValuesVisibility] ADD CONSTRAINT [PK_Bugnet_DefaultValuesVisibility] PRIMARY KEY CLUSTERED  ([ProjectId]) ON [PRIMARY]
GO
