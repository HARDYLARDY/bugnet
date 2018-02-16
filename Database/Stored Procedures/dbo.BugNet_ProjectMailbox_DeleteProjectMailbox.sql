SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectMailbox_DeleteProjectMailbox]
	@ProjectMailboxId INT
AS
	DELETE [BNProjectMailBoxes] WHERE ProjectMailboxId = @ProjectMailboxId;

	IF @@RowCount > 0
		RETURN 0;
	ELSE
		RETURN 1;
GO
