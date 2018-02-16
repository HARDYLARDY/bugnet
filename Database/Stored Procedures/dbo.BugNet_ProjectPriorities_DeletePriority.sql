SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_DeletePriority]
	@PriorityIdToDelete INT
AS
	DELETE [BNProjectPriorities] WHERE PriorityId = @PriorityIdToDelete;

	IF @@RowCount > 0
		RETURN 0;
	ELSE
		RETURN 1;
GO
