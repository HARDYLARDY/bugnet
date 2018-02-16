SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BugNet_IssueWorkReport_DeleteIssueWorkReport]
	@IssueWorkReportId INT
AS
	DELETE [BNIssueWorkReports] WHERE IssueWorkReportId = @IssueWorkReportId;
GO
