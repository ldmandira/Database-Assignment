-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION GET_barrowed_book
(
	-- Add the parameters for the function here
	@nic nvarchar(25)
)
RETURNS nvarchar
AS
BEGIN
	DECLARE @book_name nvarchar(25)
	SELECT @book_name=libman.book.title
	FROM libman.loan INNER JOIN
                  libman.copy_has_loan ON libman.loan.idloan = libman.copy_has_loan.loan_idloan INNER JOIN
				  libman.copy ON libman.copy_has_loan.copy_idcopy = libman.copy.idcopy INNER JOIN
                  libman.book ON libman.copy.book_idbook = libman.book.idbook
	WHERE(libman.loan.borrower_idborrower = @nic)

	-- Return the result of the function
	RETURN @book_name

END
GO

