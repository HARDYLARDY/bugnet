SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectStatus_CreateNewStatus]
	@ProjectId INT,
	@StatusName NVARCHAR(50),
	@StatusImageUrl NVARCHAR(50),
	@IsClosedState BIT
AS
	IF NOT EXISTS
	 (
		 SELECT
			 StatusId
		 FROM
			 [BNProjectStatus]
		 WHERE
			 LOWER(StatusName) = LOWER(@StatusName)
			 AND ProjectId = @ProjectId
	 )
	BEGIN
		DECLARE @SortOrder INT;

		SELECT
			@SortOrder = ISNULL(MAX(SortOrder + 1), 1)
		FROM
			[BNProjectStatus]
		WHERE
			ProjectId = @ProjectId;

		INSERT
			[BNProjectStatus]
			 (
				 ProjectId,
				 StatusName,
				 StatusImageUrl,
				 SortOrder,
				 IsClosedState
			 )
		VALUES
			 (
				 @ProjectId, @StatusName, @StatusImageUrl, @SortOrder, @IsClosedState
			 );

		RETURN SCOPE_IDENTITY();
	END;

	RETURN -1;
GO
