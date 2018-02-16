SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_DeleteStatus]
	@StatusIdToDelete INT
AS
	DELETE [BNProjectStatus] WHERE StatusId = @StatusIdToDelete;

	IF @@RowCount > 0
		RETURN 0;
	ELSE
		RETURN 1;
GO
