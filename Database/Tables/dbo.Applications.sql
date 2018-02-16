CREATE TABLE [dbo].[Applications]
(
[ApplicationName] [nvarchar] (235) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ApplicationId] [uniqueidentifier] NOT NULL,
[Description] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Applications] ADD CONSTRAINT [PK__Applicat__C93A4C99E20B8863] PRIMARY KEY CLUSTERED  ([ApplicationId]) ON [PRIMARY]
GO
