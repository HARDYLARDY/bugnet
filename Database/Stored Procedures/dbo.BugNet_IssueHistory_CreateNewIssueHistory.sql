SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueHistory_CreateNewIssueHistory]
	@IssueId INT,
	@CreatedUserName NVARCHAR(255),
	@FieldChanged NVARCHAR(50),
	@OldValue NVARCHAR(50),
	@NewValue NVARCHAR(50)
AS
	DECLARE @UserId UNIQUEIDENTIFIER;

	SELECT @UserId = [Users].[UserId] FROM [dbo].[Users] WHERE [Users].[UserName] = @CreatedUserName;

	INSERT
		[BNIssueHistory]
		 (
			 IssueId,
			 UserId,
			 FieldChanged,
			 OldValue,
			 NewValue,
			 DateCreated
		 )
	VALUES
		 (
			 @IssueId, @UserId, @FieldChanged, @OldValue, @NewValue, GETDATE()
		 );

	RETURN SCOPE_IDENTITY();
GO
