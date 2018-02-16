SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[BugNet_ProjectsView]
AS
	SELECT TOP ( 100 ) PERCENT
		[dbo].[BNProjects].[ProjectId],
		[dbo].[BNProjects].[ProjectName],
		[dbo].[BNProjects].[ProjectCode],
		[dbo].[BNProjects].[ProjectDescription],
		[dbo].[BNProjects].[AttachmentUploadPath],
		[dbo].[BNProjects].[ProjectManagerUserId],
		[dbo].[BNProjects].[ProjectCreatorUserId],
		[dbo].[BNProjects].[DateCreated],
		[dbo].[BNProjects].[ProjectDisabled],
		[dbo].[BNProjects].[ProjectAccessType],
		[Managers].[UserName] AS ManagerUserName,
		ISNULL([ManagerUsersProfile].[DisplayName], N'none') AS ManagerDisplayName,
		[Creators].[UserName] AS CreatorUserName,
		ISNULL([CreatorUsersProfile].[DisplayName], N'none') AS CreatorDisplayName,
		[dbo].[BNProjects].[AllowAttachments],
		[dbo].[BNProjects].[AttachmentStorageType],
		[dbo].[BNProjects].[SvnRepositoryUrl],
		[dbo].[BNProjects].[AllowIssueVoting]
	FROM
		[dbo].[BNProjects]
		INNER JOIN [dbo].[Users] AS Managers ON [Managers].[UserId] = [dbo].[BNProjects].[ProjectManagerUserId]
		INNER JOIN [dbo].[Users] AS Creators ON [Creators].[UserId] = [dbo].[BNProjects].[ProjectCreatorUserId]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] AS CreatorUsersProfile ON [Creators].[UserName] = [CreatorUsersProfile].[UserName]
		LEFT OUTER JOIN [dbo].[BNUserProfiles] AS ManagerUsersProfile ON [Managers].[UserName] = [ManagerUsersProfile].[UserName]
	ORDER BY
		[dbo].[BNProjects].[ProjectName];
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 5
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "BugNet_Projects"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 237
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Managers"
            Begin Extent = 
               Top = 6
               Left = 275
               Bottom = 121
               Right = 446
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Creators"
            Begin Extent = 
               Top = 6
               Left = 484
               Bottom = 121
               Right = 655
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "CreatorUsersProfile"
            Begin Extent = 
               Top = 6
               Left = 693
               Bottom = 121
               Right = 878
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ManagerUsersProfile"
            Begin Extent = 
               Top = 6
               Left = 916
               Bottom = 121
               Right = 1101
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 18
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         W', 'SCHEMA', N'dbo', 'VIEW', N'BugNet_ProjectsView', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'idth = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'BugNet_ProjectsView', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'BugNet_ProjectsView', NULL, NULL
GO
