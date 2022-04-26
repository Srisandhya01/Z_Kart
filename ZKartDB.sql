CREATE TABLE [dbo].[CardDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CardNo] [bigint] NOT NULL,
	[ExpiryDate] [varchar](50) NOT NULL,
	[CVV] [varchar](50) NOT NULL,
	[BillingAddr] [varchar](max) NOT NULL,
 CONSTRAINT [PK_CardDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

CREATE TABLE [dbo].[CartDetails](
	[sno] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Brand] [varchar](50) NOT NULL,
	[Model] [varchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Stock] [int] NOT NULL,
	[Email] [varchar](50) NOT NULL
)

CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
))



CREATE TABLE [dbo].[OrderDetails](
	[orderid] [varchar](max) NOT NULL,
	[sno] [int] NOT NULL,
	[productid] [int] NOT NULL,
	[Brand] [varchar](50) NOT NULL,
	[price] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[orderdate] [varchar](50) NOT NULL,
	[status] [varchar](50) NULL,
	[email] [varchar](50) NULL
)

CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Brand] [varchar](50) NOT NULL,
	[Model] [varchar](max) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Stock] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Product1] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
))

CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Gender] [varchar](50) NOT NULL,
	[Address] [varchar](max) NOT NULL,
	[Phone] [bigint] NOT NULL,
	[Password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Record] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))

ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO

CREATE PROCEDURE [dbo].[Card_SP]
	@Name VARCHAR(50) = NULL,
	@CardNo BIGINT = NULL,
	@ExpiryDate VARCHAR(50) = NULL,
	@CVV VARCHAR(50) = NULL,
	@BillingAddr VARCHAR(MAX) = NULL
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO CardDetails([Name], CardNo, ExpiryDate, CVV, BillingAddr)
	VALUES(@Name, @CardNo, @ExpiryDate, @CVV, @BillingAddr)
    
END
GO


CREATE PROCEDURE [dbo].[Cart_SP]
	@Action VARCHAR(20),
	@sno INT = NULL,
	@ProductId INT = NULL,
	@Brand VARCHAR(50) = NULL,
	@Model VARCHAR(MAX) = NULL,
	@Price DECIMAL(18,2) = NULL,
	@Stock INT = NULL,
	@Email VARCHAR(50) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;

    IF @Action = 'SELECT'
      BEGIN
			SELECT sno,ProductId,Brand,Model,Price,Stock,Email FROM dbo.CartDetails
			WHERE Email = @Email
      END
 
    
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.CartDetails(sno,ProductId,Brand,Model,Price,Stock,Email)
            VALUES (@sno,@ProductId,@Brand,@Model,@Price,@Stock,@Email)
      END
 
 
    
    IF @Action = 'DELETE'
      BEGIN
            DELETE TOP (1) FROM dbo.CartDetails WHERE ProductId = @ProductId and Email = @Email
      END


    IF @Action = 'DELETEBYUSER'
      BEGIN
			DELETE FROM dbo.CartDetails WHERE Email = @Email
      END


	IF @Action = 'GETBYID'
	  BEGIN
			SELECT * FROM dbo.CartDetails WHERE ProductId = @ProductId and Email = @Email
	  END

	IF @Action = 'GETBYUSER'
	  BEGIN
			SELECT * FROM dbo.CartDetails WHERE Email = @Email
	  END
    
END
GO


CREATE PROCEDURE [dbo].[Category_SP]

	@Action VARCHAR(20),
	@CategoryId INT = NULL,
	@CategoryName VARCHAR(100) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;

     IF @Action = 'SELECT'
      BEGIN
            SELECT * FROM dbo.Category
      END
 
   
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.Category(CategoryName)
            VALUES (@CategoryName)
      END
 

    IF @Action = 'UPDATE'
      BEGIN
		UPDATE dbo.Category
		SET CategoryName = @CategoryName 
		WHERE CategoryId = @CategoryId
      END
 
  
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Category WHERE CategoryId = @CategoryId
      END

	
    IF @Action = 'GETBYID'
      BEGIN
            SELECT * FROM dbo.Category WHERE CategoryId = @CategoryId
      END


    IF @Action = 'GETBYNAME'
      BEGIN
            SELECT * FROM dbo.Category WHERE CategoryName = @CategoryName
      END

END
GO


CREATE PROCEDURE [dbo].[Order_SP]
	@Action VARCHAR(20),
	@orderid VARCHAR(MAX) = NULL,
	@sno INT = NULL,
	@productid INT = NULL,
	@Brand VARCHAR(50) = NULL,
	@price DECIMAL(18,2) = NULL,
	@quantity INT = NULL,
	@orderdate VARCHAR(50) = NULL,
	@status VARCHAR(50) = NULL,
	@email VARCHAR(50) = NULL
AS
BEGIN
	
	SET NOCOUNT ON;

    IF @Action = 'SELECT'
      BEGIN
			SELECT orderid as OrderId,Brand as Brand,price as Price, quantity as Quantity, 
			orderdate as OrderedDate, status as Status FROM dbo.OrderDetails
      END
 
  
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.OrderDetails(orderid,sno,productid,Brand,price,quantity,orderdate,[status],email)
            VALUES (@orderid,@sno,@productid,@Brand,@price,@quantity,@orderdate,@status,@email)
      END

    IF @Action = 'GETBYORDERID'
      BEGIN
			SELECT * FROM dbo.OrderDetails
			WHERE orderid = @orderid
      END
	
	IF @Action = 'GETBYDATE'
	  BEGIN
			SELECT orderid as OrderId,Brand as Brand,price as Price, quantity as Quantity, 
			orderdate as OrderedDate FROM dbo.OrderDetails 
			WHERE orderdate = @orderdate and status='Pending'
	  END

	 
    IF @Action = 'UPDATE'
      BEGIN
	  	UPDATE dbo.OrderDetails
	  	SET status = @status
	  	WHERE orderid = @orderid
	  END
 
END
GO


CREATE PROCEDURE [dbo].[Product_SP]
	@Action VARCHAR(20),
	@ProductId INT = NULL,
	@Brand VARCHAR(100) = NULL,
	@Model VARCHAR(MAX) = NULL,
	@Price DECIMAL(18,2) = 0,
	@Stock INT = NULL,
	@CategoryId INT = NULL
AS
BEGIN

	SET NOCOUNT ON;

	
    IF @Action = 'SELECT'
      BEGIN
            SELECT p.*,c.CategoryName FROM dbo.Product p
			INNER JOIN dbo.Category c ON c.CategoryId = p.CategoryId
      END
	
  
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.Product(Brand,Model, Price,Stock,CategoryId)
            VALUES (@Brand, @Model, @Price, @Stock, @CategoryId)
      END
 

    IF @Action = 'UPDATE'
      BEGIN
	  	UPDATE dbo.Product
	  	SET Brand = @Brand, Model = @Model, Price = @Price, Stock = @Stock,CategoryId = @CategoryId
	  	WHERE ProductId = @ProductId
	  END

	
    IF @Action = 'UPDATEQTY'
      BEGIN
	  	UPDATE dbo.Product
	  	SET Stock = @Stock WHERE ProductId = @ProductId
	  END
 

    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Product WHERE ProductId = @ProductId
      END
	  
	
    IF @Action = 'GETBYID'
      BEGIN
            SELECT * FROM dbo.Product WHERE ProductId = @ProductId
      END


    IF @Action = 'GETBYCATEGORY'
      BEGIN
            SELECT p.*,c.CategoryName FROM dbo.Product p
			INNER JOIN dbo.Category c ON c.CategoryId = p.CategoryId
			WHERE p.CategoryId = @CategoryId
      END


    IF @Action = 'GETBYNAMEORCATEGORY'
      BEGIN
			SELECT p.*,c.CategoryName FROM dbo.Product p
			INNER JOIN dbo.Category c ON c.CategoryId = p.CategoryId
			WHERE (p.Brand LIKE '%' +@Brand+ '%') OR (c.CategoryName LIKE '%' +@Brand+ '%')
	  END

END
GO


CREATE PROCEDURE [dbo].[User_SP]
	@Action VARCHAR(20),
	@id INT = NULL,
	@Name VARCHAR(50) = NULL,
	@Email VARCHAR(50) = NULL,
	@Gender VARCHAR(50) = NULL,
	@Address VARCHAR(MAX) = NULL,
	@Phone BIGINT = NULL,
	@Password VARCHAR(50) = NULL
AS
BEGIN

	SET NOCOUNT ON;
 

    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.Users([Name],Email, Gender, [Address], Phone, [Password])
            VALUES (@Name,@Email, @Gender, @Address, @Phone, @Password)
      END


    IF @Action = 'LOGIN'
      BEGIN
			SELECT * FROM dbo.Users
			WHERE Email = @Email AND Password = @Password
      END
	
END