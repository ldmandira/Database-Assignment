USE [libman]
GO

/****** Object:  View [dbo].[View_barrower_details]    Script Date: 12/29/2020 4:16:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW View_get_book_details
AS
SELECT        libman.copy.idcopy, libman.copy.last_update, libman.copy.price, libman.book.title, libman.isbn.author
FROM            libman.book INNER JOIN
                         libman.copy ON libman.book.idbook = libman.copy.book_idbook INNER JOIN
                         libman.isbn ON libman.book.ISBN_isbn_id = libman.isbn.isbn_id
GO

