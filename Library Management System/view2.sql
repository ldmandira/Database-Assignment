USE [libman]
GO

/****** Object:  View [dbo].[View_book_details]    Script Date: 12/29/2020 4:20:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW View_get_barrower_details
AS
SELECT        libman.barrower_name.borrower_idborrower, libman.barrower_name.f_name, libman.barrower_name.l_name, libman.barrower_address.postal_code, libman.barrower_address.street_name, libman.barrower_address.zipcode, 
                         libman.city.city_name
FROM            libman.barrower_address INNER JOIN
                         libman.city ON libman.barrower_address.city_city_id = libman.city.city_id CROSS JOIN
                         libman.barrower_name
GO


