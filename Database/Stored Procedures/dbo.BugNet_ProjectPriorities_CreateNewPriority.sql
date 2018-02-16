SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ProjectPriorities_CreateNewPriority]
	@ProjectId INT,
	@PriorityName NVARCHAR(50),
	@PriorityImageUrl NVARCHAR(50)
AS
	IF NOT EXISTS
	 (
		 SELECT
			 PriorityId
		 FROM
			 [BNProjectPriorities]
		 WHERE
			 LOWER(PriorityName) = LOWER(@PriorityName)
			 AND ProjectId = @ProjectId
	 )
	BEGIN
		DECLARE @SortOrder INT;

		SELECT
			@SortOrder = ISNULL(MAX(SortOrder + 1), 1)
		FROM
			[BNProjectPriorities]
		WHERE
			ProjectId = @ProjectId;

		INSERT
			[BNProjectPriorities]
			 (
				 ProjectId,
				 PriorityName,
				 PriorityImageUrl,
				 SortOrder
			 )
		VALUES
			 (
				 @ProjectId, @PriorityName, @PriorityImageUrl, @SortOrder
			 );

		RETURN SCOPE_IDENTITY();
	END;

	RETURN 0;
GO
