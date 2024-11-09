create table Categories(
	CategoryId int primary key identity(1,1),
	CategoryName nvarchar(50) not null Unique
)

insert into Categories
values('Games'),('Film'),('Cartoon')

create table Tags(
	TagId int primary key identity(1,1),
	TagName nvarchar(50) not null Unique
)

insert into Tags
values('God of War'),('Deadpool'),('Tom and Jerry'),('Red Dead Redemption 2'),('Oggy and the Cockroaches'),('Kayu'),('The dark Knight'),('Interstellar')

create table Users(
	UserId int primary key identity(1,1),
	UserName nvarchar(50) not null Unique,
	FullName nvarchar(100) not null,
	UserAge int check(UserAge>0 and UserAge<150) not null
)

insert into Users
values ('Turco', 'Turan Mirze',21),
('Samir','Samir Habibov',19),
('Toghrul','Toghrul Mehdi',20),
('Kanan','Qurbanli',23),
('Anar', 'Balacayev',25)


create table Blogs(
	BlogId int primary key identity(1,1),
	BlogTitle nvarchar (50) not null,
	BlogDescription nvarchar(100) not null,
	UserId int foreign key references Users(UserId),
	CategoryId int foreign key references Categories(CategoryId)
)

insert into Blogs
values ('Rockstar Games','Rockstar Games, Inc. Nyu-Yorkda yerləşən Amerika video oyun naşiridir.',1,1),
('Marvel Studios','Marvel Comics Nyu-York şəhərində yerləşən komiks nəşriyyatıdır.',2,2),
('Cartoon Network','Tom və Cerri 1940-cı yaradılmış Amerika cizgi media komediya filmləri seriyasıdır.',3,3),
('Rockstar Games','Rockstar Games, Inc. Nyu-Yorkda yerləşən Amerika video oyun naşiridir.',4,1),
('DC','ABŞ komiks nəşriyyatı. Time Worner-in sahib olduğu Warner Bros şirkətinin bir hissəsidir.',5,2)

create table Comments(
	CommentId int primary key identity(1,1),
	CommentContext nvarchar(250) not null,
	UserId int foreign key references Users(UserId),
	BlogId int foreign key references Blogs(BlogId)
)

insert into Comments
values('Grand Theft Auto və Manhunt seriyaları, Max Payne və Midnight Club kimi məşhur oyunların müəllifidir.',1,1),
('Nəşr edilmiş komikslər arasında Fantastik Dördlük, Hörümçək-adam, Halk, Dəmir adam, Tor, Daredevil, Kapitan Amerika seriyaları var.',2,2),
('Əhvalatın mərkəzində pişik Tom və siçan Cerrinin rəqabəti durur. Tom və Cerrinın başqa digər personajları arasında məhəllə pişiyi Baç, Spayk, Tayk, siçan balası Taffi, ördək balası Kvaker və sarı bülbüldür.',3,3),
('DC Comics tərəfindən yaradılmış məşhur personajlara Supermen, Betmen, Möcüzə qadın, Yaşıl fənər, Fleş, Akvamen, Şahinqız, Yaşıl Ox və Şahin-adam aiddir.',4,5),
('Grand Theft Auto və Manhunt seriyaları, Max Payne və Midnight Club kimi məşhur oyunların müəllifidir.',5,4)

create table Tags_Blogs(
	Tags_BlogsId int primary key identity(1,1),
	TagId int foreign key references Tags(TagId),
	BlogId int foreign key references Blogs(BlogId)
)

insert into Tags_Blogs
values(1,1),(2,2),(3,3),(4,4),(5,3),(6,3),(7,5)



CREATE VIEW BlogUserInfo AS
SELECT b.BlogTitle AS BlogTitle, 
       u.UserName AS UserName, 
       u.FullName AS FullName
FROM Blogs b
JOIN Users u ON b.UserId = u.UserId;



CREATE VIEW BlogCategoryInfo AS
SELECT b.BlogTitle AS BlogTitle, 
       c.CategoryName AS CategoryName
FROM Blogs b
JOIN Categories c ON b.CategoryId = c.CategoryId;



create view CategoryCount as
SELECT  c.CategoryName AS CategoryName, Count(*) as [Count]
FROM Blogs b
JOIN Categories c 
ON b.CategoryId = c.CategoryId										
Group by c.CategoryName


CREATE FUNCTION GetBlogCount (@categoryId INT)
RETURNS INT
AS
BEGIN
    DECLARE @BlogCount INT;
    SELECT @BlogCount = COUNT(*) FROM Blogs as b
    WHERE b.CategoryId = @categoryId;  
    RETURN @BlogCount;
END


CREATE FUNCTION GetBlogTable (@userId int)
RETURNS table
AS
Return(
	SELECT b.BlogId, b.BlogTitle,b.BlogDescription, b.CategoryId,b.UserId 
	from Blogs as b
	where b.UserId  = @userId
)



Create Procedure usp_GetUserBlog @userId int
AS 
	SELECT b.BlogId, b.BlogTitle, b.BlogDescription, b.UserId, b.CategoryId
    FROM Blogs b
    WHERE b.UserId = @userId;


CREATE PROCEDURE usp_GetUserComment @userId int
AS
    SELECT c.CommentId, c.CommentContext, c.BlogId, c.UserId
    FROM Comments c
    WHERE c.UserId = @userId










select * from BlogUserInfo
select * from CategoryCount
select * from BlogCategoryInfo
EXEC usp_GetUserComment @userId = 3
EXEC usp_GetUserBlog @userId =2
select dbo.GetBlogCount(3) as BlogCount
select dbo.GetBlogTable(1)




select * from Categories
select * from Tags
select * from Users
select * from Blogs
select * from Comments
select * from Tags_Blogs







