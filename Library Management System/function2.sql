-- ================================================
-- Template generated from Template Explorer using:
-- Create Inline Function (New Menu).SQL
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
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION GET_barrower_details
(	
	@nic int
)
RETURNS TABLE 
AS
RETURN
(
	SELECT        libman.barrower_name.f_name, libman.barrower_name.l_name, libman.barrower_contact.lan_no, libman.barrower_contact.mobi_no, libman.barrower_address.postal_code, libman.barrower_address.street_name, 
                         libman.barrower_address.zipcode, libman.city.city_name, libman.borrower.idborrower
FROM            libman.barrower_address INNER JOIN
                         libman.borrower ON libman.barrower_address.borrower_idborrower = libman.borrower.idborrower INNER JOIN
                         libman.barrower_contact ON libman.borrower.idborrower = libman.barrower_contact.borrower_idborrower INNER JOIN
                         libman.barrower_name ON libman.borrower.idborrower = libman.barrower_name.borrower_idborrower INNER JOIN
                         libman.city ON libman.barrower_address.city_city_id = libman.city.city_id
WHERE        (libman.borrower.idborrower = @nic)
)
GO
