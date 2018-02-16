SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[GetCustomIssues]
	-- Add the parameters for the stored procedure here
	@ProjectID int	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Insert statements for procedure here
	DECLARE @stmt nvarchar(max);    
	
    SET @stmt = 'SELECT * FROM dbo.BugNet_IssuesCustom_' + CAST(@ProjectID AS nvarchar);
    
	EXECUTE sp_executesql @stmt;
END
GO
