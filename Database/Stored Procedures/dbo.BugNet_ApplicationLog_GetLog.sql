SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_ApplicationLog_GetLog]
	@FilterType NVARCHAR(50) = NULL
AS
	SELECT
		L.*
	FROM
		[BNApplicationLog] L
	WHERE
		(
			( @FilterType IS NULL )
			OR ( Level = @FilterType )
		)
	ORDER BY
		L.Date DESC;
GO
