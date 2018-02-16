SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectResolutions_DeleteResolution]
	@ResolutionIdToDelete INT
AS
	DELETE [BNProjectResolutions] WHERE ResolutionId = @ResolutionIdToDelete;

	IF @@RowCount > 0
		RETURN 0;
	ELSE
		RETURN 1;
GO
