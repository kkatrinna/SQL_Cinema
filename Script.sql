USE [master]
GO
/****** Object:  Database [Cinema]    Script Date: 26.06.2023 15:10:30 ******/
CREATE DATABASE [Cinema]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cinema', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\cinema.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'cinema_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\cinema_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Cinema] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Cinema].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Cinema] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Cinema] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Cinema] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Cinema] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Cinema] SET ARITHABORT OFF 
GO
ALTER DATABASE [Cinema] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Cinema] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Cinema] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Cinema] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Cinema] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Cinema] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Cinema] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Cinema] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Cinema] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Cinema] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Cinema] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Cinema] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Cinema] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Cinema] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Cinema] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Cinema] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Cinema] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Cinema] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Cinema] SET  MULTI_USER 
GO
ALTER DATABASE [Cinema] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Cinema] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Cinema] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Cinema] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Cinema] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Cinema] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Cinema] SET QUERY_STORE = OFF
GO
USE [Cinema]
GO
/****** Object:  Table [dbo].[Post]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Post](
	[IdPost] [int] IDENTITY(1,1) NOT NULL,
	[NamePost] [varchar](50) NOT NULL,
	[Salary] [decimal](10, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdPost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[IdEmpl] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[Patronymic] [varchar](20) NULL,
	[Gender] [int] NOT NULL,
	[IdPost] [int] NOT NULL,
	[Birthday] [date] NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK__Employee__09D638FA8A3501FE] PRIMARY KEY CLUSTERED 
(
	[IdEmpl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Client]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Client](
	[IdClient] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[Birthday] [date] NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](30) NOT NULL,
	[Gender] [int] NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[IdClient] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[IdOrd] [int] IDENTITY(1,1) NOT NULL,
	[IdClient] [int] NOT NULL,
	[IdEmployee] [int] NOT NULL,
	[OrdDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[IdOrd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Employee_Order]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Employee_Order]
as
select e.FirstName, e.LastName, e.Patronymic, e.Birthday, e.Phone, c.IdClient, OrdDate, c.Email
from [Order] o
	join Employee e on o.IdEmployee=e.IdEmpl
	join Client c on o.IdClient=c.IdClient
where IdEmployee in 
	(select IdEmployee from Client where IdPost in (select IdPost from Post where NamePost like 'кассир'))
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[IdGend] [int] IDENTITY(1,1) NOT NULL,
	[NameGend] [varchar](7) NOT NULL,
 CONSTRAINT [PK_Gender] PRIMARY KEY CLUSTERED 
(
	[IdGend] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Client_Ord]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Client_Ord] 
as
select FirstName, LastName, Phone, Email, NameGend, datediff(year,Birthday,getdate()) as Age, OrdDate
from [Order] o
	join Client c on o.IdClient=c.IdClient
	join Gender g on c.Gender=g.IdGend
group by FirstName, LastName, Phone, Email, NameGend, OrdDate, Birthday
GO
/****** Object:  Table [dbo].[CountryFilm]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CountryFilm](
	[IdFilm] [int] NOT NULL,
	[IdCountry] [int] NOT NULL,
 CONSTRAINT [PK_CountryFilm] PRIMARY KEY CLUSTERED 
(
	[IdFilm] ASC,
	[IdCountry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genre]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genre](
	[IdGenre] [int] IDENTITY(1,1) NOT NULL,
	[NameGenre] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdGenre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Film]    Script Date: 26.06.2023 15:10:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Film](
	[IdFilm] [int] IDENTITY(1,1) NOT NULL,
	[NameFilm] [varchar](50) NOT NULL,
	[StartDate] [date] NOT NULL,
	[Duration] [varchar](20) NOT NULL,
	[Rating] [decimal](10, 1) NOT NULL,
	[Age] [char](3) NOT NULL,
	[Description] [varchar](max) NOT NULL,
 CONSTRAINT [PK__Film__01E644E981D8B099] PRIMARY KEY CLUSTERED 
(
	[IdFilm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilmGenre]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmGenre](
	[IdFilmGenre] [int] IDENTITY(1,1) NOT NULL,
	[IdGenre] [int] NOT NULL,
	[IdFilm] [int] NOT NULL,
 CONSTRAINT [PK_FilmGenre] PRIMARY KEY CLUSTERED 
(
	[IdFilmGenre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Country]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[IdCountry] [int] IDENTITY(1,1) NOT NULL,
	[NameCountry] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[IdCountry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Film_Info]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Film_Info] as
select distinct f.IdFilm, NameFilm, Duration, Age, year(StartDate) as YearFilm, g.NameGenre, NameCountry
from Film f 
	join FilmGenre fg on f.IdFilm=fg.IdFilm 
	join Genre g on fg.IdGenre=g.IdGenre
	join CountryFilm cf on f.IdFilm=cf.IdFilm
	join Country c on c.IdCountry=cf.IdCountry
group by NameFilm, NameGenre, NameCountry, Duration, Age, g.NameGenre, StartDate, f.IdFilm
GO
/****** Object:  Table [dbo].[Actor]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actor](
	[IdActor] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Actor] PRIMARY KEY CLUSTERED 
(
	[IdActor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FilmActor]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilmActor](
	[IdFilmActor] [int] IDENTITY(1,1) NOT NULL,
	[IdFilm] [int] NOT NULL,
	[IdActor] [int] NOT NULL,
	[Post] [varchar](20) NOT NULL,
 CONSTRAINT [PK_FilmActor] PRIMARY KEY CLUSTERED 
(
	[IdFilmActor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Hall]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hall](
	[IdHall] [int] IDENTITY(1,1) NOT NULL,
	[NameHall] [varchar](20) NOT NULL,
	[IdType] [int] NOT NULL,
	[QuantityRow] [int] NOT NULL,
	[QuantitySeat] [int] NOT NULL,
 CONSTRAINT [PK_Hall] PRIMARY KEY CLUSTERED 
(
	[IdHall] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdItem]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdItem](
	[IdOrd] [int] NOT NULL,
	[IdTicket] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_OrdItem2] PRIMARY KEY CLUSTERED 
(
	[IdOrd] ASC,
	[IdTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Session]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Session](
	[IdSession] [int] IDENTITY(1,1) NOT NULL,
	[IdFilm] [int] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[IdHall] [int] NOT NULL,
	[Price] [decimal](10, 0) NOT NULL,
 CONSTRAINT [PK_Session] PRIMARY KEY CLUSTERED 
(
	[IdSession] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket](
	[IdTicket] [int] IDENTITY(1,1) NOT NULL,
	[IdTypeTicket] [int] NOT NULL,
	[IdOrd] [int] NOT NULL,
	[IdSession] [int] NOT NULL,
	[NumberRow] [int] NOT NULL,
	[NumberSeat] [int] NOT NULL,
	[Price] [decimal](10, 0) NOT NULL,
 CONSTRAINT [PK__Ticket__4B93C7E7E821EA55] PRIMARY KEY CLUSTERED 
(
	[IdTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeHall]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeHall](
	[IdType] [int] IDENTITY(1,1) NOT NULL,
	[NameType] [varchar](20) NOT NULL,
 CONSTRAINT [PK_TypeHall] PRIMARY KEY CLUSTERED 
(
	[IdType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypeTicket]    Script Date: 26.06.2023 15:10:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypeTicket](
	[IdTypeTicket] [int] IDENTITY(1,1) NOT NULL,
	[NameType] [varchar](20) NOT NULL,
	[Price] [decimal](10, 0) NOT NULL,
 CONSTRAINT [PK__TypeSeat__A778A27C49CFF366] PRIMARY KEY CLUSTERED 
(
	[IdTypeTicket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Actor] ON 

INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (1, N'Пако', N'Леон')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (2, N'Кэти', N'Паркер')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (3, N'Джерард', N'Батлер')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (4, N'Инка', N'Каллен')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (5, N'Ольга', N'Коскикаллио')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (6, N'Эмили', N'Коппель')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (7, N'Каролин', N'Ведель')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (8, N'Джейк', N'Джилленхол')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (9, N'Райан', N'Рейнольдс')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (10, N'Ольга', N'Дыховичная')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (11, N'Дакота', N'Джонсон')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (12, N'Миа', N'Гот')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (13, N'Елена', N'Фокина')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (14, N'Бенни', N'Сэфди')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (15, N'Матильда', N'Сенье')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (16, N'Фред', N'Тесто')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (17, N'Роуз', N'Бирн')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (18, N'Джек', N'Рейнор')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (19, N'Юлия', N'Пересильд')
INSERT [dbo].[Actor] ([IdActor], [FirstName], [LastName]) VALUES (20, N'Милош', N'Бикович')
SET IDENTITY_INSERT [dbo].[Actor] OFF
GO
SET IDENTITY_INSERT [dbo].[Client] ON 

INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (1, N'Грачев', N'Тимофей', CAST(N'1995-08-22' AS Date), N'pejal_okece71@yahoo.com', N'+79058769876', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (2, N'Кузнецова', N'Виолетта', NULL, N'hisize_xuju89@yahoo.com', N'+78967850945', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (3, N'', N'', CAST(N'1999-08-25' AS Date), N'vitul_ifewo80@aol.com', N'+78969056786', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (4, N'', N'', CAST(N'2000-12-06' AS Date), N'zahab_erepe79@gmail.com', N'+78456709856', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (5, N'Александрова', N'Виктория', CAST(N'2001-08-22' AS Date), N'gukotuj-udo75@mail.com', N'+78690567587', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (6, N'Андреева', N'Анастасия', CAST(N'2003-01-21' AS Date), N'zerufed-ari38@outlook.com', N'+78956784567', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (7, N'', N'', NULL, N'wide-yefalo6@hotmail.com', N'+78902348769', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (8, N'Горбунов', N'Марк', CAST(N'1997-12-09' AS Date), N'yopu_zemovu43@outlook.com', N'+78950678598', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (9, N'Некрасова', N'Александра', NULL, N'pocodoc_ene63@outlook.com', N'+78941670856', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (10, N'', N'', CAST(N'2000-06-30' AS Date), N'taducub-ibi78@yahoo.com', N'+78910275464', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (11, N'Новиков', N'Дмитрий', CAST(N'2001-07-25' AS Date), N'ruxehi-xugi77@yahoo.com', N'+78950947656', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (12, N'Иванова', N'Каролина', CAST(N'2003-05-29' AS Date), N'gop-icexato43@hotmail.com', N'+78954560328', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (13, N'Калинин', N'Константин', CAST(N'1997-01-20' AS Date), N'beti-cajide70@aol.com', N'+78967560487', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (14, N'Савин', N'Игорь', CAST(N'2002-08-23' AS Date), N'rogayi-novi13@outlook.com', N'+72879057687', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (15, N'', N'', CAST(N'2001-07-16' AS Date), N'motohom-uma93@outlook.com', N'+78965674039', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (16, N'Чернышев', N'Марк', CAST(N'2001-04-23' AS Date), N'xuded_ogeja59@gmail.com', N'+79056748767', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (17, N'Тихомиров', N'Александр', NULL, N'hoc_azagapo51@mail.com', N'+78695640912', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (18, N'', N'', CAST(N'2005-01-25' AS Date), N'poziz_ejoki87@aol.com', N'+78695458767', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (19, N'Киселева', N'Варвара', CAST(N'1996-05-17' AS Date), N'nefos-ivipo26@yahoo.com', N'+78905647586', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (20, N'Новикова', N'Сафия', CAST(N'2003-07-31' AS Date), N'celamuh_oxo40@aol.com', N'+78956038569', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (21, N'', N'', NULL, N'buxa-gogeru1@mail.com', N'+78960587694', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (22, N'Иванова', N'Александра', CAST(N'1997-08-14' AS Date), N'culot-evohe85@gmail.com', N'+78966578409', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (23, N'Скворцов', N'Давид', CAST(N'1995-11-06' AS Date), N'zap_opitura67@hotmail.com', N'+78564537869', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (24, N'Серов', N'Павел', CAST(N'2000-02-10' AS Date), N'docuw-ujuve49@yahoo.com', N'+78956473487', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (25, N'', N'', CAST(N'2006-11-06' AS Date), N'kanol-axojo81@hotmail.com', N'+78434548788', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (26, N'Иванов', N'Андрей', CAST(N'1996-04-23' AS Date), N'jijer_isixe28@aol.com', N'+79767675688', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (27, N'Филимонов', N'Филипп', NULL, N'pek_idijeyo43@gmail.com', N'+79787767889', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (28, N'Зайцева', N'Ева', CAST(N'1997-04-07' AS Date), N'xifaxob-ixu37@yahoo.com', N'+79384455853', 2)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (29, N'Карасев', N'Константин', NULL, N'kowov_ohuju93@gmail.com', N'+79845787799', 1)
INSERT [dbo].[Client] ([IdClient], [FirstName], [LastName], [Birthday], [Email], [Phone], [Gender]) VALUES (30, N'Герасимов', N'Павел', CAST(N'2005-03-02' AS Date), N'zijak_ireva11@mail.com', N'+75456548988', 1)
SET IDENTITY_INSERT [dbo].[Client] OFF
GO
SET IDENTITY_INSERT [dbo].[Country] ON 

INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (1, N'Бельгия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (2, N'Болгария')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (3, N'Германия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (4, N'Индия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (5, N'Испания')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (7, N'Казахстан')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (8, N'Канада')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (9, N'Китай')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (10, N'Колумбия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (11, N'Мексика')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (12, N'Новая Зеландия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (13, N'Норвегия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (14, N'Польша')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (15, N'Португалия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (16, N'Россия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (17, N'Румыния')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (18, N'Сербия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (19, N'США')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (20, N'Турция')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (21, N'Финляндия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (22, N'Франция')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (23, N'Чехия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (24, N'Швейцария')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (25, N'Швеция')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (26, N'Эстония')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (27, N'Югославия')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (28, N'Южная кореяя')
INSERT [dbo].[Country] ([IdCountry], [NameCountry]) VALUES (29, N'Япония')
SET IDENTITY_INSERT [dbo].[Country] OFF
GO
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (4, 3)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (5, 5)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (5, 15)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (7, 7)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (7, 10)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (8, 7)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (8, 29)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (9, 14)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (10, 18)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (11, 19)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (12, 13)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (13, 4)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (14, 3)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (15, 1)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (16, 8)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (17, 9)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (18, 13)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (19, 10)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (20, 16)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (21, 1)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (21, 11)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (22, 17)
INSERT [dbo].[CountryFilm] ([IdFilm], [IdCountry]) VALUES (23, 13)
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (1, N'Рогов', N'Вадим', N'Валерьевич', 1, 3, CAST(N'2005-02-09' AS Date), N'winan_ayosu30@mail.com', N'+79678590485')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (2, N'Воронова', N'Зоя', N'Степановна', 2, 4, CAST(N'2005-04-07' AS Date), N'debipe_gome63@gmail.com', N'+79787878789')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (3, N'Гришин', N'Михаил', N'Фёдорович', 1, 5, CAST(N'1999-07-06' AS Date), N'wohabe-bova16@mail.com', N'+79878787878')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (4, N'Юдина', N'Антонина', N'Эдуардовна', 2, 6, CAST(N'2005-10-28' AS Date), N'gupij_ajuxa64@hotmail.com', N'+75654457879')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (5, N'Носков', N'Валентин', N'Григориевич', 1, 7, CAST(N'2000-12-26' AS Date), N'jajogef-uzi23@outlook.com', N'+79347565658')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (6, N'Блохин', N'Василий', N'Валерьевич', 1, 8, CAST(N'1993-06-29' AS Date), N'wekefur_ice82@gmail.com', N'+78767555678')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (7, N'Степанов', N'Валерий', N'Ильич', 1, 9, CAST(N'1992-09-21' AS Date), N'wodi-widesi28@hotmail.com', N'+74837655244')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (8, N'Лаврентьева', N'Яна', N'Сергеевна', 2, 10, CAST(N'2000-07-11' AS Date), N'bamumul_egu28@aol.com', N'+78787896800')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (9, N'Молчанов', N'Валентин', N'Павлович', 1, 12, CAST(N'2004-05-24' AS Date), N'haj-ugixeyi8@hotmail.com', N'+79458438436')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (10, N'Мельникова', N'Яна', N'Арсениевна', 2, 13, CAST(N'2003-12-24' AS Date), N'rimetal-ozi40@mail.com', N'+78787567578')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (11, N'Галкин', N'Олег', N'Юрьевич', 1, 11, CAST(N'2004-08-23' AS Date), N'vaf_otininu81@yahoo.com', N'+79586898494')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (12, N'Воробьева', N'Алина', N'Александровна', 2, 4, CAST(N'2006-11-24' AS Date), N'bave_nufaba18@aol.com', N'+78974576899')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (13, N'Виноградова', N'Юлия', N'Степановна', 2, 3, CAST(N'1995-05-25' AS Date), N'bucamur_ozo96@mail.com', N'+79845868899')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (15, N'Савин', N'Геннадий', N'Антонович', 1, 3, CAST(N'1999-02-04' AS Date), N'vuwew_ebopi2@hotmail.com', N'+79588689348')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (16, N'Гурьева', N'Антонина', N'Анатольевна', 2, 5, CAST(N'2002-05-13' AS Date), N'yoye_hejavo86@aol.com', N'+79468564600')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (17, N'Голубев', N'Тимур', N'Даниилович', 1, 6, CAST(N'2006-06-27' AS Date), N'mawox-izite19@outlook.com', N'+79488643239')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (18, N'Елисеева', N'Дарина', N'Аркадиевна', 2, 4, CAST(N'2005-03-08' AS Date), N'nac-aruyana69@outlook.com', N'+70956435456')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (19, N'Кабанова', N'Юлия', N'Никитовна', 2, 3, CAST(N'2001-06-27' AS Date), N'pomu-kidoxi64@outlook.com', N'+79984954690')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (22, N'Мухина', N'Людмила', N'Дмитриевна', 2, 3, CAST(N'1992-03-18' AS Date), N'vocifow-iyo72@gmail.com', N'+74986547684')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (23, N'Константинова', N'Ольга', N'Олеговна', 2, 5, CAST(N'2002-02-14' AS Date), N'nal-itenera89@gmail.com', N'+76656789090')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (24, N'Силин', N'Василий', N'Арсениевич', 1, 4, CAST(N'1998-04-21' AS Date), N'vubehey_ade70@aol.com', N'+74868456889')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (25, N'Титов', N'Станислав', N'Матвеевич', 1, 8, CAST(N'1999-09-23' AS Date), N'haji_xesaxa72@mail.com', N'+79456585749')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (26, N'Овчинников', N'Григорий', N'Егорович', 1, 7, CAST(N'1994-12-08' AS Date), N'tawo_dojoza49@outlook.com', N'+74867848659')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (27, N'Тихонова', N'Жанна', N'Сергеевна', 2, 5, CAST(N'2001-09-26' AS Date), N'few_eruzudu13@aol.com', N'+74634098989')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (28, N'Авдеев', N'Даниил', N'Анатольевич', 1, 4, CAST(N'1993-03-04' AS Date), N'yidoy_alize63@yahoo.com', N'+75468878790')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (29, N'Зыкова', N'Дарья', N'Константиновна', 2, 6, CAST(N'2005-12-13' AS Date), N'cujega-bike87@outlook.com', N'+79745878989')
INSERT [dbo].[Employee] ([IdEmpl], [FirstName], [LastName], [Patronymic], [Gender], [IdPost], [Birthday], [Email], [Phone]) VALUES (30, N'Лапин', N'Виктор', N'Михайлович', 1, 3, CAST(N'2002-01-18' AS Date), N'ponuta_ruca98@yahoo.com', N'+78457689903')
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[Film] ON 

INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (4, N'Гренландия', CAST(N'2020-01-01' AS Date), N'1ч 59мин', CAST(4.5 AS Decimal(10, 1)), N'16+', N'Земле угрожает комета')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (5, N'Не стучи', CAST(N'2022-01-01' AS Date), N'1ч 25мин', CAST(5.0 AS Decimal(10, 1)), N'16+', N'Судьба лесного участка')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (7, N'Нимфоманка', CAST(N'2013-01-01' AS Date), N'1ч 57 мин', CAST(5.0 AS Decimal(10, 1)), N'18+', N'Разговор гиперсексуальной Джо и пожилого асексуала')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (8, N'Вызов', CAST(N'2023-01-01' AS Date), N'2ч 44мин', CAST(7.5 AS Decimal(10, 1)), N'12+', N'Хирург готовится к космическому полету')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (9, N'Нечто', CAST(N'2023-01-01' AS Date), N'1ч 40мин', CAST(5.0 AS Decimal(10, 1)), N'18+', N'Заброшенный дом на  морском побережье')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (10, N'Поезд в Пусан', CAST(N'2016-01-01' AS Date), N'1ч 58мин', CAST(7.2 AS Decimal(10, 1)), N'18+', N'Вирус превращает поезд в смертельную ловушку')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (11, N'Не дыши', CAST(N'2015-01-01' AS Date), N'1ч 28мин', CAST(6.8 AS Decimal(10, 1)), N'18+', N'Подростки забираются в дом слепого ветерана')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (12, N'Хорошее время', CAST(N'2016-01-01' AS Date), N'1ч 42мин', CAST(6.9 AS Decimal(10, 1)), N'16+', N'Вытащить брата из тюрьмы')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (13, N'Между мирами', CAST(N'2022-01-01' AS Date), N'1ч 48мин', CAST(5.5 AS Decimal(10, 1)), N'16+', N'Парочке незнакомцев предстоит вместе добраться до места суицида')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (14, N'Война пуговиц', CAST(N'2011-01-01' AS Date), N'1ч 49мин', CAST(7.4 AS Decimal(10, 1)), N'6+ ', N'Война деревенских мальчишек')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (15, N'Легкое знакомство', CAST(N'2023-01-01' AS Date), N'1ч 39мин', CAST(6.0 AS Decimal(10, 1)), N'16+', N'Психолог и незнакомка на курорте')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (16, N'Творцы снов', CAST(N'2020-01-01' AS Date), N'1ч 21мин', CAST(6.5 AS Decimal(10, 1)), N'6+ ', N'Девочка с особым даром')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (17, N'Суспирия', CAST(N'2018-01-01' AS Date), N'2ч 32мин', CAST(6.6 AS Decimal(10, 1)), N'18+', N'Злая академия танцев')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (18, N'Паразит', CAST(N'2020-01-01' AS Date), N'1ч 47мин', CAST(5.9 AS Decimal(10, 1)), N'18+', N'Плотник в шкафу в чужом доме')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (19, N'Переводчик', CAST(N'2022-01-01' AS Date), N'2ч 3мин', CAST(7.4 AS Decimal(10, 1)), N'18+', N'Ахмад спасает Джона')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (20, N'Чебурашка', CAST(N'2023-01-01' AS Date), N'1ч 53мин', CAST(7.3 AS Decimal(10, 1)), N'6+ ', N'Ушастый зверек')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (21, N'Достать ножи', CAST(N'2019-01-01' AS Date), N'2ч 10мин', CAST(8.0 AS Decimal(10, 1)), N'18+', N'Дело о смерти известного писателя')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (22, N'Солнцестояние', CAST(N'2019-01-01' AS Date), N'2ч 28мин', CAST(6.5 AS Decimal(10, 1)), N'18+', N'Шведские праздники - зловещие ритуалы')
INSERT [dbo].[Film] ([IdFilm], [NameFilm], [StartDate], [Duration], [Rating], [Age], [Description]) VALUES (23, N'Расплата ', CAST(N'2022-01-01' AS Date), N'2ч 8мин', CAST(7.4 AS Decimal(10, 1)), N'18+', N'Бухгалтер с синдромом Аспергера считает деньги мифии')
SET IDENTITY_INSERT [dbo].[Film] OFF
GO
SET IDENTITY_INSERT [dbo].[FilmActor] ON 

INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (1, 5, 1, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (2, 4, 2, N'Режисер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (3, 7, 2, N'Сценарист')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (4, 12, 4, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (5, 20, 5, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (6, 18, 6, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (7, 19, 7, N'Сценарист')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (8, 5, 8, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (9, 7, 9, N'Режисер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (10, 11, 10, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (11, 12, 5, N'Режисер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (12, 9, 4, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (13, 14, 5, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (14, 13, 11, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (15, 4, 12, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (16, 9, 15, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (17, 10, 14, N'Сценарист')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (18, 11, 5, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (19, 12, 9, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (20, 17, 10, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (21, 18, 7, N'Режисер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (22, 20, 6, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (23, 13, 9, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (24, 16, 6, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (25, 5, 4, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (26, 10, 2, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (27, 11, 16, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (28, 9, 19, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (29, 7, 20, N'Актер')
INSERT [dbo].[FilmActor] ([IdFilmActor], [IdFilm], [IdActor], [Post]) VALUES (30, 12, 18, N'Актер')
SET IDENTITY_INSERT [dbo].[FilmActor] OFF
GO
SET IDENTITY_INSERT [dbo].[FilmGenre] ON 

INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (2, 17, 13)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (3, 11, 11)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (4, 16, 5)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (5, 12, 8)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (6, 7, 9)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (7, 17, 5)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (8, 7, 8)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (9, 7, 7)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (10, 16, 8)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (13, 10, 11)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (14, 17, 12)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (15, 7, 13)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (16, 13, 14)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (17, 16, 15)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (18, 18, 16)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (19, 17, 17)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (20, 12, 18)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (21, 19, 19)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (22, 13, 20)
INSERT [dbo].[FilmGenre] ([IdFilmGenre], [IdGenre], [IdFilm]) VALUES (23, 12, 20)
SET IDENTITY_INSERT [dbo].[FilmGenre] OFF
GO
SET IDENTITY_INSERT [dbo].[Gender] ON 

INSERT [dbo].[Gender] ([IdGend], [NameGend]) VALUES (1, N'мужской')
INSERT [dbo].[Gender] ([IdGend], [NameGend]) VALUES (2, N'женский')
SET IDENTITY_INSERT [dbo].[Gender] OFF
GO
SET IDENTITY_INSERT [dbo].[Genre] ON 

INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (22, N'Анимация')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (1, N'Биография')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (2, N'Боевик')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (23, N'Вестерн')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (3, N'Военный')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (4, N'Детектив')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (5, N'Детский')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (6, N'Документальный')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (7, N'Драма')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (8, N'Исторический')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (9, N'Комедия')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (10, N'Криминал')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (11, N'Мелодрамма')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (12, N'Мультфильм')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (13, N'Приключения')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (14, N'Семейный')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (15, N'Спорт')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (16, N'Триллер')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (17, N'Ужасы')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (18, N'Фантастика')
INSERT [dbo].[Genre] ([IdGenre], [NameGenre]) VALUES (19, N'Фэнтези')
SET IDENTITY_INSERT [dbo].[Genre] OFF
GO
SET IDENTITY_INSERT [dbo].[Hall] ON 

INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (1, N'Белый 5', 1, 10, 100)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (2, N'Красный 9', 8, 20, 200)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (3, N'Зеленый 20', 7, 15, 150)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (4, N'Синий', 5, 10, 100)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (5, N'Зал 22', 7, 20, 200)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (6, N'Зал 20', 8, 30, 300)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (7, N'Синий 5', 1, 15, 150)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (8, N'Зал 10', 2, 20, 200)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (9, N'Синий 30', 4, 20, 200)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (10, N'Зеленый 25', 3, 20, 200)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (11, N'Зал 40', 5, 30, 300)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (12, N'Зал 1 ', 6, 40, 400)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (13, N'Зал 5', 5, 20, 200)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (14, N'Зал 3', 7, 40, 400)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (17, N'Зал 15', 2, 20, 200)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (18, N'Зал 17', 4, 15, 150)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (19, N'Зал 8', 3, 25, 250)
INSERT [dbo].[Hall] ([IdHall], [NameHall], [IdType], [QuantityRow], [QuantitySeat]) VALUES (20, N'Зал 23', 5, 30, 300)
SET IDENTITY_INSERT [dbo].[Hall] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (1, 1, 3, CAST(N'2023-06-19T21:02:18.770' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (2, 2, 13, CAST(N'2023-06-19T21:02:42.387' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (3, 3, 6, CAST(N'2023-06-19T21:02:42.427' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (4, 4, 15, CAST(N'2023-06-19T21:02:42.453' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (5, 5, 13, CAST(N'2023-06-19T21:02:42.480' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (6, 6, 15, CAST(N'2023-06-19T21:02:42.507' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (7, 7, 16, CAST(N'2023-06-19T21:02:42.540' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (8, 8, 22, CAST(N'2023-06-19T21:02:42.570' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (9, 9, 19, CAST(N'2023-06-19T21:02:42.597' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (10, 10, 19, CAST(N'2023-06-19T21:02:42.623' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (11, 11, 22, CAST(N'2023-06-19T21:02:42.653' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (12, 12, 15, CAST(N'2023-06-19T21:02:42.680' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (13, 13, 13, CAST(N'2023-06-19T21:02:42.800' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (14, 14, 3, CAST(N'2023-06-19T21:02:42.847' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (15, 15, 13, CAST(N'2023-06-19T21:02:42.877' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (16, 16, 25, CAST(N'2023-06-19T21:02:42.903' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (17, 17, 30, CAST(N'2023-06-19T21:02:42.930' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (18, 18, 27, CAST(N'2023-06-19T21:02:42.960' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (19, 19, 13, CAST(N'2023-06-19T21:02:42.987' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (20, 20, 15, CAST(N'2023-06-19T21:02:43.013' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (21, 21, 6, CAST(N'2023-06-19T21:02:43.040' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (22, 22, 3, CAST(N'2023-06-19T21:02:43.070' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (23, 23, 13, CAST(N'2023-06-19T21:02:43.100' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (24, 24, 22, CAST(N'2023-06-19T21:02:43.127' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (25, 25, 19, CAST(N'2023-06-19T21:02:43.153' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (26, 26, 13, CAST(N'2023-06-19T21:02:43.183' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (27, 27, 15, CAST(N'2023-06-19T21:02:43.210' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (28, 28, 25, CAST(N'2023-06-19T21:02:43.240' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (29, 29, 30, CAST(N'2023-06-19T21:02:43.270' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (30, 30, 6, CAST(N'2023-06-19T21:02:43.300' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (31, 2, 3, CAST(N'2023-06-19T21:02:43.327' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (32, 3, 13, CAST(N'2023-06-19T21:02:43.357' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (33, 6, 6, CAST(N'2023-06-19T21:02:43.370' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (34, 30, 15, CAST(N'2023-06-19T21:02:43.400' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (35, 26, 3, CAST(N'2023-06-19T21:02:43.430' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (36, 25, 22, CAST(N'2023-06-19T21:02:43.457' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (37, 24, 19, CAST(N'2023-06-19T21:02:43.483' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (38, 23, 25, CAST(N'2023-06-19T21:02:43.513' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (39, 27, 16, CAST(N'2023-06-19T21:02:43.540' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (40, 28, 13, CAST(N'2023-06-19T21:02:43.570' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (41, 11, 15, CAST(N'2023-06-19T21:02:43.600' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (42, 16, 3, CAST(N'2023-06-19T21:02:43.627' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (43, 17, 6, CAST(N'2023-06-19T21:02:43.657' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (44, 20, 25, CAST(N'2023-06-19T21:02:43.683' AS DateTime))
INSERT [dbo].[Order] ([IdOrd], [IdClient], [IdEmployee], [OrdDate]) VALUES (45, 27, 19, CAST(N'2023-06-19T21:02:43.713' AS DateTime))
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (2, 3, 1, CAST(500.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (4, 2, 1, CAST(450.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (7, 10, 1, CAST(300.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (7, 14, 1, CAST(250.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (9, 8, 2, CAST(400.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (9, 18, 1, CAST(475.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (14, 12, 1, CAST(658.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (16, 17, 2, CAST(390.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (18, 20, 1, CAST(475.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (19, 1, 1, CAST(230.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (19, 21, 1, CAST(500.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (23, 4, 1, CAST(700.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (26, 7, 1, CAST(367.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (29, 11, 1, CAST(600.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (32, 16, 2, CAST(655.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (32, 19, 1, CAST(398.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (33, 22, 2, CAST(476.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (34, 4, 1, CAST(400.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (45, 5, 1, CAST(500.00 AS Decimal(10, 2)))
INSERT [dbo].[OrdItem] ([IdOrd], [IdTicket], [Quantity], [Price]) VALUES (45, 13, 1, CAST(550.00 AS Decimal(10, 2)))
GO
SET IDENTITY_INSERT [dbo].[Post] ON 

INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (3, N'Администратор', CAST(100000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (4, N'Бухгалтер', CAST(70000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (5, N'Кассир', CAST(50000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (6, N'Охранник', CAST(30000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (7, N'Уборщик', CAST(30000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (8, N'Бармен', CAST(50000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (9, N'Старший кассир', CAST(60000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (10, N'Контролер', CAST(30000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (11, N'Киноинженер', CAST(50000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (12, N'Киноимеханик', CAST(50000 AS Decimal(10, 0)))
INSERT [dbo].[Post] ([IdPost], [NamePost], [Salary]) VALUES (13, N'Менеджер по рекламе', CAST(70000 AS Decimal(10, 0)))
SET IDENTITY_INSERT [dbo].[Post] OFF
GO
SET IDENTITY_INSERT [dbo].[Session] ON 

INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (4, 7, CAST(N'2023-06-12T12:00:00.000' AS DateTime), CAST(N'2023-06-12T13:30:00.000' AS DateTime), 4, CAST(350 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (5, 4, CAST(N'2023-06-22T12:00:00.000' AS DateTime), CAST(N'2023-06-22T13:50:00.000' AS DateTime), 2, CAST(400 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (6, 5, CAST(N'2023-06-01T22:00:00.000' AS DateTime), CAST(N'2023-06-01T23:40:00.000' AS DateTime), 3, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (7, 9, CAST(N'2023-06-04T20:30:00.000' AS DateTime), CAST(N'2023-06-04T21:30:00.000' AS DateTime), 4, CAST(600 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (8, 7, CAST(N'2023-06-14T14:40:00.000' AS DateTime), CAST(N'2023-06-14T16:40:00.000' AS DateTime), 6, CAST(650 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (9, 8, CAST(N'2023-06-22T12:00:00.000' AS DateTime), CAST(N'2023-06-22T13:35:00.000' AS DateTime), 5, CAST(350 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (10, 9, CAST(N'2023-06-22T12:30:00.000' AS DateTime), CAST(N'2023-06-22T14:00:00.000' AS DateTime), 7, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (11, 10, CAST(N'2023-06-08T15:00:00.000' AS DateTime), CAST(N'2023-06-08T16:20:00.000' AS DateTime), 20, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (12, 11, CAST(N'2023-06-16T14:00:00.000' AS DateTime), CAST(N'2023-06-16T15:50:00.000' AS DateTime), 17, CAST(500 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (13, 12, CAST(N'2023-06-28T10:00:00.000' AS DateTime), CAST(N'2023-06-28T12:00:00.000' AS DateTime), 18, CAST(475 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (14, 13, CAST(N'2023-06-20T22:00:00.000' AS DateTime), CAST(N'2023-06-20T23:50:00.000' AS DateTime), 19, CAST(650 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (15, 14, CAST(N'2023-06-18T21:30:00.000' AS DateTime), CAST(N'2023-06-18T23:00:00.000' AS DateTime), 14, CAST(556 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (18, 17, CAST(N'2023-06-01T11:00:00.000' AS DateTime), CAST(N'2023-06-01T13:20:00.000' AS DateTime), 3, CAST(345 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (19, 18, CAST(N'2023-06-13T12:45:00.000' AS DateTime), CAST(N'2023-06-13T14:20:00.000' AS DateTime), 2, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (20, 19, CAST(N'2023-06-25T19:00:00.000' AS DateTime), CAST(N'2023-06-25T20:25:00.000' AS DateTime), 7, CAST(300 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (21, 20, CAST(N'2023-06-24T20:45:00.000' AS DateTime), CAST(N'2023-06-24T22:35:00.000' AS DateTime), 8, CAST(600 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (22, 21, CAST(N'2023-06-26T12:35:00.000' AS DateTime), CAST(N'2023-06-26T13:50:00.000' AS DateTime), 9, CAST(700 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (23, 22, CAST(N'2023-06-01T20:20:00.000' AS DateTime), CAST(N'2023-06-01T22:20:00.000' AS DateTime), 2, CAST(650 AS Decimal(10, 0)))
INSERT [dbo].[Session] ([IdSession], [IdFilm], [StartDate], [EndDate], [IdHall], [Price]) VALUES (24, 23, CAST(N'2023-06-20T18:30:00.000' AS DateTime), CAST(N'2023-06-20T19:55:00.000' AS DateTime), 1, CAST(755 AS Decimal(10, 0)))
SET IDENTITY_INSERT [dbo].[Session] OFF
GO
SET IDENTITY_INSERT [dbo].[Ticket] ON 

INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (1, 1, 39, 8, 10, 2, CAST(500 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (2, 2, 20, 20, 2, 3, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (3, 4, 1, 13, 3, 5, CAST(300 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (4, 6, 13, 7, 5, 4, CAST(350 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (5, 7, 12, 5, 6, 6, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (7, 5, 43, 22, 4, 3, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (8, 3, 6, 18, 10, 2, CAST(500 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (9, 2, 24, 22, 2, 1, CAST(550 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (10, 1, 20, 22, 3, 10, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (11, 4, 27, 19, 1, 12, CAST(750 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (12, 6, 29, 18, 5, 14, CAST(700 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (13, 8, 1, 21, 7, 15, CAST(360 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (14, 7, 19, 21, 6, 2, CAST(380 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (16, 4, 34, 21, 9, 8, CAST(550 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (17, 2, 2, 5, 10, 9, CAST(600 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (18, 1, 39, 11, 12, 10, CAST(645 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (19, 3, 24, 14, 2, 11, CAST(555 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (20, 4, 6, 6, 4, 2, CAST(650 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (21, 5, 43, 10, 7, 6, CAST(350 AS Decimal(10, 0)))
INSERT [dbo].[Ticket] ([IdTicket], [IdTypeTicket], [IdOrd], [IdSession], [NumberRow], [NumberSeat], [Price]) VALUES (22, 6, 35, 15, 3, 5, CAST(565 AS Decimal(10, 0)))
SET IDENTITY_INSERT [dbo].[Ticket] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeHall] ON 

INSERT [dbo].[TypeHall] ([IdType], [NameType]) VALUES (2, N'2D')
INSERT [dbo].[TypeHall] ([IdType], [NameType]) VALUES (1, N'3D')
INSERT [dbo].[TypeHall] ([IdType], [NameType]) VALUES (7, N'D-BOX')
INSERT [dbo].[TypeHall] ([IdType], [NameType]) VALUES (4, N'Dolby Atmos')
INSERT [dbo].[TypeHall] ([IdType], [NameType]) VALUES (6, N'IMAX')
INSERT [dbo].[TypeHall] ([IdType], [NameType]) VALUES (3, N'VIP')
INSERT [dbo].[TypeHall] ([IdType], [NameType]) VALUES (8, N'Детский')
INSERT [dbo].[TypeHall] ([IdType], [NameType]) VALUES (5, N'Комфорт')
SET IDENTITY_INSERT [dbo].[TypeHall] OFF
GO
SET IDENTITY_INSERT [dbo].[TypeTicket] ON 

INSERT [dbo].[TypeTicket] ([IdTypeTicket], [NameType], [Price]) VALUES (1, N'Эконом', CAST(350 AS Decimal(10, 0)))
INSERT [dbo].[TypeTicket] ([IdTypeTicket], [NameType], [Price]) VALUES (2, N'Стандарт', CAST(400 AS Decimal(10, 0)))
INSERT [dbo].[TypeTicket] ([IdTypeTicket], [NameType], [Price]) VALUES (3, N'Комфорт', CAST(600 AS Decimal(10, 0)))
INSERT [dbo].[TypeTicket] ([IdTypeTicket], [NameType], [Price]) VALUES (4, N'VIP', CAST(700 AS Decimal(10, 0)))
INSERT [dbo].[TypeTicket] ([IdTypeTicket], [NameType], [Price]) VALUES (5, N'D-BOX', CAST(650 AS Decimal(10, 0)))
INSERT [dbo].[TypeTicket] ([IdTypeTicket], [NameType], [Price]) VALUES (6, N'VIP D-BOX', CAST(800 AS Decimal(10, 0)))
INSERT [dbo].[TypeTicket] ([IdTypeTicket], [NameType], [Price]) VALUES (7, N'Love', CAST(500 AS Decimal(10, 0)))
INSERT [dbo].[TypeTicket] ([IdTypeTicket], [NameType], [Price]) VALUES (8, N'Для инвалидов', CAST(400 AS Decimal(10, 0)))
SET IDENTITY_INSERT [dbo].[TypeTicket] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Email]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[Client] ADD  CONSTRAINT [IX_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Phone]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[Client] ADD  CONSTRAINT [IX_Phone] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Country]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [IX_Country] UNIQUE NONCLUSTERED 
(
	[NameCountry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmpEmail]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [IX_EmpEmail] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_EmpPhone]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[Employee] ADD  CONSTRAINT [IX_EmpPhone] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_GenreName]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[Genre] ADD  CONSTRAINT [IX_GenreName] UNIQUE NONCLUSTERED 
(
	[NameGenre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_HallName]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[Hall] ADD  CONSTRAINT [IX_HallName] UNIQUE NONCLUSTERED 
(
	[NameHall] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PostName]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[Post] ADD  CONSTRAINT [IX_PostName] UNIQUE NONCLUSTERED 
(
	[NamePost] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TypeHallName]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[TypeHall] ADD  CONSTRAINT [IX_TypeHallName] UNIQUE NONCLUSTERED 
(
	[NameType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TypeSeatName]    Script Date: 26.06.2023 15:10:31 ******/
ALTER TABLE [dbo].[TypeTicket] ADD  CONSTRAINT [IX_TypeSeatName] UNIQUE NONCLUSTERED 
(
	[NameType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order] ADD  CONSTRAINT [DF_Order_OrdDate]  DEFAULT (getdate()) FOR [OrdDate]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [FK_Client_Gender] FOREIGN KEY([Gender])
REFERENCES [dbo].[Gender] ([IdGend])
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [FK_Client_Gender]
GO
ALTER TABLE [dbo].[CountryFilm]  WITH CHECK ADD  CONSTRAINT [FK_CountryFilm_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[Country] ([IdCountry])
GO
ALTER TABLE [dbo].[CountryFilm] CHECK CONSTRAINT [FK_CountryFilm_Country]
GO
ALTER TABLE [dbo].[CountryFilm]  WITH CHECK ADD  CONSTRAINT [FK_CountryFilm_Film] FOREIGN KEY([IdFilm])
REFERENCES [dbo].[Film] ([IdFilm])
GO
ALTER TABLE [dbo].[CountryFilm] CHECK CONSTRAINT [FK_CountryFilm_Film]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Gender] FOREIGN KEY([Gender])
REFERENCES [dbo].[Gender] ([IdGend])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Gender]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Post] FOREIGN KEY([IdPost])
REFERENCES [dbo].[Post] ([IdPost])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Post]
GO
ALTER TABLE [dbo].[FilmActor]  WITH CHECK ADD  CONSTRAINT [FK_FilmActor_Actor] FOREIGN KEY([IdActor])
REFERENCES [dbo].[Actor] ([IdActor])
GO
ALTER TABLE [dbo].[FilmActor] CHECK CONSTRAINT [FK_FilmActor_Actor]
GO
ALTER TABLE [dbo].[FilmActor]  WITH CHECK ADD  CONSTRAINT [FK_FilmActor_Film] FOREIGN KEY([IdFilm])
REFERENCES [dbo].[Film] ([IdFilm])
GO
ALTER TABLE [dbo].[FilmActor] CHECK CONSTRAINT [FK_FilmActor_Film]
GO
ALTER TABLE [dbo].[FilmGenre]  WITH CHECK ADD  CONSTRAINT [FK_FilmGenre_Film] FOREIGN KEY([IdGenre])
REFERENCES [dbo].[Film] ([IdFilm])
GO
ALTER TABLE [dbo].[FilmGenre] CHECK CONSTRAINT [FK_FilmGenre_Film]
GO
ALTER TABLE [dbo].[FilmGenre]  WITH CHECK ADD  CONSTRAINT [FK_FilmGenre_Genre] FOREIGN KEY([IdGenre])
REFERENCES [dbo].[Genre] ([IdGenre])
GO
ALTER TABLE [dbo].[FilmGenre] CHECK CONSTRAINT [FK_FilmGenre_Genre]
GO
ALTER TABLE [dbo].[Hall]  WITH CHECK ADD  CONSTRAINT [FK_Hall_TypeHall] FOREIGN KEY([IdType])
REFERENCES [dbo].[TypeHall] ([IdType])
GO
ALTER TABLE [dbo].[Hall] CHECK CONSTRAINT [FK_Hall_TypeHall]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Client] FOREIGN KEY([IdClient])
REFERENCES [dbo].[Client] ([IdClient])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Client]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Employee] FOREIGN KEY([IdEmployee])
REFERENCES [dbo].[Employee] ([IdEmpl])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Employee]
GO
ALTER TABLE [dbo].[OrdItem]  WITH CHECK ADD  CONSTRAINT [FK_OrdItem2_Order] FOREIGN KEY([IdOrd])
REFERENCES [dbo].[Order] ([IdOrd])
GO
ALTER TABLE [dbo].[OrdItem] CHECK CONSTRAINT [FK_OrdItem2_Order]
GO
ALTER TABLE [dbo].[OrdItem]  WITH CHECK ADD  CONSTRAINT [FK_OrdItem2_Ticket] FOREIGN KEY([IdTicket])
REFERENCES [dbo].[Ticket] ([IdTicket])
GO
ALTER TABLE [dbo].[OrdItem] CHECK CONSTRAINT [FK_OrdItem2_Ticket]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Film] FOREIGN KEY([IdFilm])
REFERENCES [dbo].[Film] ([IdFilm])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Film]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [FK_Session_Hall] FOREIGN KEY([IdHall])
REFERENCES [dbo].[Hall] ([IdHall])
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [FK_Session_Hall]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_Session1] FOREIGN KEY([IdSession])
REFERENCES [dbo].[Session] ([IdSession])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_Session1]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [FK_Ticket_TypeTicket] FOREIGN KEY([IdTypeTicket])
REFERENCES [dbo].[TypeTicket] ([IdTypeTicket])
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [FK_Ticket_TypeTicket]
GO
ALTER TABLE [dbo].[Client]  WITH CHECK ADD  CONSTRAINT [CK_Phone] CHECK  (([Phone] like '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Client] CHECK CONSTRAINT [CK_Phone]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [CK_EmpPhone] CHECK  (([Phone] like '+7[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [CK_EmpPhone]
GO
ALTER TABLE [dbo].[Post]  WITH CHECK ADD  CONSTRAINT [CK_PostSalary] CHECK  (([Salary]>(0)))
GO
ALTER TABLE [dbo].[Post] CHECK CONSTRAINT [CK_PostSalary]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [CK_SessionDate] CHECK  (([EndDate]>[StartDate]))
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [CK_SessionDate]
GO
ALTER TABLE [dbo].[Session]  WITH CHECK ADD  CONSTRAINT [CK_SessionPrice] CHECK  (([Price]>(0)))
GO
ALTER TABLE [dbo].[Session] CHECK CONSTRAINT [CK_SessionPrice]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD  CONSTRAINT [CK_TicketPrice] CHECK  (([Price]>(0)))
GO
ALTER TABLE [dbo].[Ticket] CHECK CONSTRAINT [CK_TicketPrice]
GO
ALTER TABLE [dbo].[TypeTicket]  WITH CHECK ADD  CONSTRAINT [CK_TypePrice] CHECK  (([Price]>(0)))
GO
ALTER TABLE [dbo].[TypeTicket] CHECK CONSTRAINT [CK_TypePrice]
GO
USE [master]
GO
ALTER DATABASE [Cinema] SET  READ_WRITE 
GO
