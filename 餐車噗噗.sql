USE [master]
GO
/****** Object:  Database [trytry]    Script Date: 2022/11/20 下午 06:39:43 ******/
CREATE DATABASE [trytry]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'trytry', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER_2019\MSSQL\DATA\trytry.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'trytry_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER_2019\MSSQL\DATA\trytry_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [trytry] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [trytry].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [trytry] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [trytry] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [trytry] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [trytry] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [trytry] SET ARITHABORT OFF 
GO
ALTER DATABASE [trytry] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [trytry] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [trytry] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [trytry] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [trytry] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [trytry] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [trytry] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [trytry] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [trytry] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [trytry] SET  DISABLE_BROKER 
GO
ALTER DATABASE [trytry] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [trytry] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [trytry] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [trytry] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [trytry] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [trytry] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [trytry] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [trytry] SET RECOVERY FULL 
GO
ALTER DATABASE [trytry] SET  MULTI_USER 
GO
ALTER DATABASE [trytry] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [trytry] SET DB_CHAINING OFF 
GO
ALTER DATABASE [trytry] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [trytry] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [trytry] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [trytry] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'trytry', N'ON'
GO
ALTER DATABASE [trytry] SET QUERY_STORE = OFF
GO
USE [trytry]
GO
/****** Object:  Table [dbo].[Customer_Favorite]    Script Date: 2022/11/20 下午 06:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Favorite](
	[FavoriteID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
 CONSTRAINT [pk_Favorite_Id] PRIMARY KEY CLUSTERED 
(
	[FavoriteID] ASC,
	[CustomerID] ASC,
	[StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store_Products]    Script Date: 2022/11/20 下午 06:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store_Products](
	[StoreID] [int] NOT NULL,
	[ProductID] [int] IDENTITY(1001,1) NOT NULL,
	[Product_Name] [nvarchar](50) NULL,
	[Product_Price] [int] NULL,
	[Product_Picture] [nvarchar](200) NULL,
 CONSTRAINT [pk_StoreProducts_Id] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store_Business]    Script Date: 2022/11/20 下午 06:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store_Business](
	[StoreID] [int] NOT NULL,
	[CalendarID] [int] NOT NULL,
	[longitude] [nvarchar](50) NULL,
	[latitude] [nvarchar](50) NULL,
	[Address_City] [nvarchar](50) NULL,
	[Address_Local] [nvarchar](50) NULL,
	[Store_Address] [nvarchar](50) NULL,
	[Punch_day] [timestamp] NULL,
	[Punch_Start] [nvarchar](50) NULL,
	[Punch_End] [nvarchar](50) NULL,
	[OnBusiness] [bit] NULL,
 CONSTRAINT [pk_Store_Business_Id] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC,
	[CalendarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store]    Script Date: 2022/11/20 下午 06:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store](
	[StoreID] [int] IDENTITY(1,1) NOT NULL,
	[Store_Name] [nvarchar](50) NULL,
	[Store_Class] [nvarchar](50) NULL,
	[Address_Area] [nvarchar](50) NULL,
	[Address_City] [nvarchar](50) NULL,
	[Address_Local] [nvarchar](50) NULL,
	[Introduce] [nvarchar](300) NULL,
	[Owner_Name] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email_Account] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Creation_At] [date] NULL,
	[Picture] [nvarchar](100) NULL,
	[EmailIdentify] [nvarchar](10) NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_Customer_Favorite]    Script Date: 2022/11/20 下午 06:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Customer_Favorite]
AS
SELECT          dbo.Customer_Favorite.StoreID, dbo.Store.Store_Name, dbo.Store.Store_Class, dbo.Store_Business.Address_City, 
                            dbo.Store_Business.Address_Local, dbo.Store_Business.Store_Address, dbo.Store_Products.ProductID, 
                            dbo.Store_Products.Product_Name, dbo.Store_Products.Product_Price
FROM              dbo.Customer_Favorite INNER JOIN
                            dbo.Store ON dbo.Customer_Favorite.StoreID = dbo.Store.StoreID INNER JOIN
                            dbo.Store_Business ON dbo.Store.StoreID = dbo.Store_Business.StoreID INNER JOIN
                            dbo.Store_Products ON dbo.Store.StoreID = dbo.Store_Products.StoreID
GO
/****** Object:  Table [dbo].[Calendar]    Script Date: 2022/11/20 下午 06:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calendar](
	[CalendarID] [int] IDENTITY(1,1) NOT NULL,
	[Planday] [int] NULL,
 CONSTRAINT [PK_Calendar] PRIMARY KEY CLUSTERED 
(
	[CalendarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2022/11/20 下午 06:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Email_Account] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Address_City] [nvarchar](50) NULL,
	[Address_Local] [nvarchar](50) NULL,
	[Address_Road] [nvarchar](50) NULL,
	[Created_At] [datetime] NULL,
	[EmailIdentify] [nvarchar](10) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Message_Board]    Script Date: 2022/11/20 下午 06:39:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message_Board](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[StoreID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Text_Content] [nvarchar](200) NULL,
	[Star_Rating] [int] NULL,
	[Picture] [nvarchar](100) NULL,
	[Create_At] [date] NULL,
 CONSTRAINT [pk_Message_Id] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC,
	[StoreID] ASC,
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Calendar] ON 

INSERT [dbo].[Calendar] ([CalendarID], [Planday]) VALUES (1, 1)
INSERT [dbo].[Calendar] ([CalendarID], [Planday]) VALUES (2, 2)
INSERT [dbo].[Calendar] ([CalendarID], [Planday]) VALUES (3, 3)
INSERT [dbo].[Calendar] ([CalendarID], [Planday]) VALUES (4, 4)
INSERT [dbo].[Calendar] ([CalendarID], [Planday]) VALUES (5, 5)
SET IDENTITY_INSERT [dbo].[Calendar] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerID], [Name], [Phone], [Email_Account], [Password], [Address_City], [Address_Local], [Address_Road], [Created_At], [EmailIdentify]) VALUES (1, N'Alan', N'0912345678', N'gimamimi', N'123', N'高雄市', N'苓雅區', N'三多路', CAST(N'2022-09-26T15:44:59.560' AS DateTime), NULL)
INSERT [dbo].[Customer] ([CustomerID], [Name], [Phone], [Email_Account], [Password], [Address_City], [Address_Local], [Address_Road], [Created_At], [EmailIdentify]) VALUES (2, N'123', N'123', N'123', N'123', N'132', N'132', N'132', CAST(N'2022-09-26T15:44:59.560' AS DateTime), NULL)
INSERT [dbo].[Customer] ([CustomerID], [Name], [Phone], [Email_Account], [Password], [Address_City], [Address_Local], [Address_Road], [Created_At], [EmailIdentify]) VALUES (3, N'阿包', N'5252', N'5252', N'5252', N'台南市', N'1', N'1', CAST(N'2022-09-26T15:44:59.560' AS DateTime), NULL)
INSERT [dbo].[Customer] ([CustomerID], [Name], [Phone], [Email_Account], [Password], [Address_City], [Address_Local], [Address_Road], [Created_At], [EmailIdentify]) VALUES (6, N'曾于倢', N'0935687152', N'ycyccyc844@gmail.com', N'password0930', N'臺南市', N'東區', N'大學路12巷24號', CAST(N'2022-09-28T16:37:36.353' AS DateTime), N'1')
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer_Favorite] ON 

INSERT [dbo].[Customer_Favorite] ([FavoriteID], [CustomerID], [StoreID]) VALUES (1, 1, 1)
INSERT [dbo].[Customer_Favorite] ([FavoriteID], [CustomerID], [StoreID]) VALUES (2, 1, 2)
INSERT [dbo].[Customer_Favorite] ([FavoriteID], [CustomerID], [StoreID]) VALUES (3, 1, 3)
INSERT [dbo].[Customer_Favorite] ([FavoriteID], [CustomerID], [StoreID]) VALUES (4, 1, 4)
SET IDENTITY_INSERT [dbo].[Customer_Favorite] OFF
GO
SET IDENTITY_INSERT [dbo].[Message_Board] ON 

INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (30, 1, 1, N'好吃讚讚', 5, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-22' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (31, 1, 2, N'披薩等待時間長，但餡料多，整體CP值還不錯', 4, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-23' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (32, 1, 3, N'還行', 4, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-23' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (33, 2, 1, N'或許還不錯?', 5, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-23' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (34, 2, 2, N'或許還不錯?', 3, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-23' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (36, 2, 3, N'或許還不錯?', 1, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-23' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (37, 3, 1, N'或許還不錯?', 2, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-23' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (38, 4, 1, N'或許還不錯?', 4, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-23' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (39, 5, 1, N'或許還不錯?', 5, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-23' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (40, 6, 1, N'或許還不錯?', 4, N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', CAST(N'2022-09-23' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (42, 7, 2, N'或許還不錯?', 3, N'/FileUpload/Store/92022-09-2202-43-51.jpg', CAST(N'2022-09-22' AS Date))
INSERT [dbo].[Message_Board] ([MessageID], [StoreID], [CustomerID], [Text_Content], [Star_Rating], [Picture], [Create_At]) VALUES (43, 8, 2, N'好吃喔', 4, N'/FileUpload/Store/102022-09-2202-47-20.jpg', CAST(N'2022-09-22' AS Date))
SET IDENTITY_INSERT [dbo].[Message_Board] OFF
GO
SET IDENTITY_INSERT [dbo].[Store] ON 

INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (1, N'Lighthouse Food Truck燈塔餐車', N'美式', N'北部', N'台北市/新北市', N'大安區', N'風格美式餐車，販售不同口味的古巴三明治，以浪廚獨家的德州煙燻烤肉為靈魂，宛如電影《五星主廚快餐車》走進現實中。不固定出沒在各場合，喜歡與人交流，以食會友並發掘各地方獨特的美好。', N'燈塔餐車', N'0952 766 427', N'lighthousefoodtruck1@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/lighthousefoodtruck1@gmail.com2022-09-2122-36-33.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (2, N'Skrabur黑膠漢堡', N'美式', N'北部', N'台北市', N'信義區', N'Scratch Burger黑膠漢堡的概念是來自於DJ界的靈魂之一黑膠唱片，其店名scratch 在DJ界裡是指刷碟。希望藉由美食與DJ刷碟作結合且推廣『scratch』的精神，故用黑膠唱片的概念來研發漢堡，讓漢堡呈現黑色的樣子來襯托黑膠唱片在DJ理的重要性，且堅持手工拍打而成。', N'黑膠漢堡', N'0983 007 142', N'clancy0430@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/clancy0430@gmail.com2022-09-2123-00-32.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (3, N'Corgyro柯基倚肉-希臘烤肉捲', N'西式', N'北部', N'台北市', N'松山區', N'Corgyro 結合 corgi 和 gyros 希臘特色小吃 ，帶著柯基店長一起上班(山)下班(海)?', N'Gyro基', N'0930 517 766', N'corgyro@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/corgyro@gmail.com2022-09-2123-09-28.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (4, N'附近漢堡 Nearby Burger', N'美式', N'北部', N'台北市', N'萬華區', N'漢堡都是現做，需要一點時間，請大家耐心等候美味漢堡堡，售完為止，請沒買到的各位捧油請多多見諒。', N'附近漢堡', N'無', N'nearbyburger@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/nearbyburger@gmail.com2022-09-2123-23-57.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (5, N'River&Truck披薩車', N'西式', N'北部', N'台北市', N'士林區/大安區', N'兩個人與一台煙囪貨車，夢想是能開遍台灣大街小巷，分享我們的創意拿坡里窯烤披薩。', N'River&Truck', N'無', N'water62998@yahoo.com.tw', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/water62998@yahoo.com.tw2022-09-2220-12-03.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (6, N'UMAI沖繩飯糰', N'日式', N'北部', N'台北市', N'大安區', N'沖繩飯糰、有機豆漿、古早味紅茶、全台第一餐車飯糰、餐車&露營車客製販售租賃。', N'沖繩飯糰', N'02 2703 5598', N'clicktin@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/clicktin@gmail.com2022-09-2220-16-27.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (7, N'Rainbow Hot Dog 彩虹熱狗', N'美式', N'北部', N'台北市', N'信義區', N'🌈純手工製作的健康熱狗~無添加 真食材 好美味
彩虹是幸福幸運的象徵 ', N'彩虹熱狗', N'0963 636 677', N'jpprchen@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/jpprchen@gmail.com2022-09-2220-22-09.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (8, N'GOGOBOX餐車誌in樂灣基地', N'美式', N'北部', N'桃園市', N'大溪區', N'樂灣基地是BOX餐車的常態據點，擁有大片綠地免費開放遊客共享，園區內無低消免門票；友善毛孩及親子的環境，『GOGOBOX美味快餐車』外出在外、隨手食用的餐點也絕不馬虎，手作的健康美味等你來品嘗！期待同樣愛好戶外的你來交個朋友…我們的落腳處就在復興路二段138號-樂灣基地園區。', N'GOGOBOX美味快餐車', N'0915 281 828', N'mgm19920@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/mgm19920@gmail.com2022-09-2220-34-28.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (9, N'密食堂古巴三明治', N'西式', N'北部', N'新竹市', N'東區', N'#新竹不是美食沙漠
#隱藏版宵夜就在密食堂
#點心
#下午茶
#歡迎團體預定外送', N'密食堂古巴三明治', N'0937 189 760', N'0937189760@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/0937189760@gmail.com2022-09-2220-40-21.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (11, N'mornings 流浪早餐車', N'早午餐', N'北部', N'台北市', N'信義區', N'mornings
店名很單純，就是我們每天最常說的那句話：）
當你也說Good morning的', N'mornings', N'0968 072 080', N'morningsfoodtruck@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/morningsfoodtruck@gmail.com2022-09-2220-49-17.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (12, N'KK手工窯烤pizza ', N'西式', N'北部', N'台北市', N'新店區', N'KK手工窯烤Pizza是一部專業的行動pizza車，遊走在台北的大街小巷。我們每日精選食材、手工現擀餅皮，堅持使用傳統果樹（龍眼木或荔枝木）柴燒窯烤，就是要呈現出視覺與味覺的雙重極致享受。', N'KK披薩', N'0963 007 862', N'kkpizzataipei@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/kkpizzataipei@gmail.com2022-09-2221-01-26.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (14, N'胖子修行動餐車', N'台式', N'中部', N'台中市', N'大里區', N'堅持使用合格屠宰新鮮溫體豬的豬大腸，經過細心處理，讓消費者安心食用。大腸內絕對百分百台灣出產米、土豆、油蔥酥，還有還有在加入家傳的調味料，在配上美味小菜，讓您每一口都有不一樣的層次,不用加醬油膏就非常的好吃，絕對讓你讚不絕口，吃了還會在想吃。', N'雙胞胎', N'0955 987 778', N'momo0925363@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/momo0925363@gmail.com2022-09-2221-22-18.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (15, N'超三代蔥油餅', N'台式', N'中部', N'台中市', N'南區', N'超人氣!酥脆蔥油餅!', N'超三代', N'0925 509 999', N'0925509999@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/0925509999@gmail.com2022-09-2221-26-49.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (21, N'戀豆成癮', N'甜點', N'中部', N'台中市', N'北屯區', N'來個清涼的冰沙，配上可口的豆花，讓你涼感升級!
紅豆、綠豆、小麥、花生、珍珠、芋園', N'戀豆成癮', N'0910 438 733', N'0910438733@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/0910438733@gmail.com2022-09-2221-59-55.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (22, N'尤牧', N'西式', N'中部', N'台中市', N'西區', N'《每週日20:30公佈行程及開放私訊預訂》
尋找台灣野生的風味
搭配上手作軟法🥖
以餐車形式沒有固定的場所
結合許多料理方式
來跟著我們流浪追尋台灣食材美味的地方
我們目前以台中，彰化為主🚚', N'尤牧', N'無', N'nomad_flavor@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/nomad_flavor@gmail.com2022-09-2223-56-40.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (24, N'The Bretzel 手工德國扭結', N'西式', N'中部', N'台中市', N'西屯區', N'全台唯一一間德國結主題餐廳
提供全日早午餐以及麵包外帶(周末會於勤美誠品綠園道擺攤)
', N'The Bretzel', N'0918 920 694', N'stanleywei7@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/stanleywei7@gmail.com2022-09-2222-34-18.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (25, N'香蛋餅', N'台式', N'中部', N'台中市', N'太平區', N'為了讓已經經營了十幾年的小吃攤能夠繼續營業，讓其他沒吃過的人，都能享用到古早味的美味。', N'蛋餅', N'無', N'xiangdanbing@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/xiangdanbing@gmail.com2022-09-2222-42-59.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (26, N'善田素油飯', N'台式', N'中部', N'台中市', N'北屯區', N'黃金比例的素油飯，是使用老薑磨成細泥，再加上長糯米、麻油、香菇及素肉一起料理。長糯米吃起來Q彈有口感，麻油老薑香氣十足，越吃越涮嘴!

…吃素，希望可以從油飯開始《林秉閎》…', N'林秉閎', N'0953 613 106', N'Shantienso@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/Shantienso@gmail.com2022-09-2223-03-31.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (27, N'川東味臭豆腐', N'台式', N'中部', N'台中市', N'北屯區', N'川東味臭豆腐
小吃攤
川東味臭豆腐/麵線糊
臭豆腐現點現炸外酥內嫩保有汁
麵線糊真材實料，麵線多保有飽足
全台巡迴行動餐車', N'川東味', N'04 2297 5589', N'lele3271014@yahoo.com.tw', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/lele3271014@yahoo.com.tw2022-09-2223-11-26.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (28, N'角樂子HappyCorner', N'港式', N'中部', N'台中市', N'南屯區', N'從香港飄洋到台灣的一對夫妻, 希望透過角樂子行動餐車到處介紹香港本土在地小食~
人在異鄉~希望讓大家感受到暖暖的滋味~', N'角樂子', N'無', N'happycornerintw@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/happycornerintw@gmail.com2022-09-2223-24-16.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (29, N'彭城大溪現滷豆干', N'台式', N'中部', N'台中市', N'潭子區', N'宗桃園大溪的滷味，一個在地的好味道。葷素皆可，整鍋都是純素製成，只有醬料分葷素（五辛素也可以吃喔）', N'彭城', N'0968 503 366', N'0968503366@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/0968503366@gmail.com2022-09-2300-14-21.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (30, N'江湖客棧龍蝦海鮮粥', N'台式', N'中部', N'台中市', N'豐原區', N'江湖客棧鱘龍魚龍蝦海鮮粥是間專賣晚餐、宵夜的粥品攤車

可別小看這碗粥 每一匙舀起來都是滿滿的海鮮料理 目前可說是豐原必吃的美食之一', N'江湖客棧', N'0963 010 550', N'bvc338@yahoo.com.tw ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/bvc338@yahoo.com.tw2022-09-2300-22-50.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (31, N'Brekky of Brissy布村早茶', N'早午餐', N'中部', N'台中市', N'豐原區', N'Brekky of Brissy 布村早茶
Instagram @brekky_of_brissy
來自澳洲小布村
用澳洲質樸的茶，溫暖大家的心。', N'布村早茶', N'0908 335 723', N'brekkyofbrissy@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/brekkyofbrissy@gmail.com2022-09-2300-37-19.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (36, N'多肉薯條 ', N'美式', N'南部', N'高雄市', N'鹽埕區 ', N'曾經在加拿大吃到熱騰騰的pontine，這份美味深刻的印在腦海裡。不斷嘗試各種方式，終於還原出這份味道，期待把這份味道帶給你們。
', N'多肉薯條', N'無', N'julain928@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/julain928@gmail.com2022-09-2309-56-34.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (37, N'Small Cake雞蛋糕 ', N'甜點', N'南部', N'高雄市', N'小港區 ', N'天然，已是主流
"簡單的事情重複做，你就是行家"
秉持著這個信念，每天帶給你最簡單樸實的美味', N'Small Cake', N'0903 292 615', N'chen_72700@yahoo.com.tw ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/chen_72700@yahoo.com.tw2022-09-2309-59-35.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (38, N'林針嬤鹹水G ', N'台式', N'南部', N'高雄市', N'左營區 ', N'（不用啦！這是要做給我孫子吃的！）笑得合不攏嘴的阿嬤不擅言詞，但依舊堅持把這份美味帶給大家。

', N'林針嬤', N'07 346 9999', N'a3711895@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/a3711895@gmail.com2022-09-2310-02-42.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (39, N'蔬嬴s 手作香椿餅 ', N'台式', N'南部', N'高雄市', N'新興區', N'簡介:
素食 香椿餅 素食 蔥肉 餅', N'蔬嬴', N'0986 885 553', N'0986885553@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/0986885553@gmail.com2022-09-2310-06-36.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (40, N'頑固油飯', N'台式', N'南部', N'高雄市', N'前鎮區', N'頑固的不只是性格 更多的是帶著職人感的堅持氣息
融合及傳承 本身就是一件很酷的事情
能讓眼神閃閃發光的 就絕對能感動人心
讓老油飯以新世代的紳士車 繼續頑固上路 療癒靈魂
', N'OneGu', N'無', N'pcsg329th@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/pcsg329th@gmail.com2022-09-2310-11-04.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (42, N'熊老闆地瓜球 ', N'炸物', N'南部', N'高雄市', N'三民區', N'手工地瓜球三輪車/用愛、勇氣與希望製成
使用AV-CHECK油脂劣化判定試紙/3M油脂老化測試紙，監控油脂品質，吃的更安心
', N'熊老闆', N'0961 229 268', N'bossbearqq@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/bossbearqq@gmail.com2022-09-2310-21-39.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (43, N'妹子芭樂', N'台式', N'南部', N'高雄市', N'林園區', N'手中小農燕巢芭樂，
用獨家比例的醬汁，
把每一顆芭樂變成閃亮的綠寶石', N'妹子芭樂', N'無', N'asdf556623@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/asdf556623@gmail.com2022-09-2310-25-40.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (44, N'豪豪蔥抓餅 ', N'台式', N'南部', N'高雄市', N'苓雅區', N'一個喜歡中式麵食的男子
騎著三輪車帶著餅皮
與饕客們分享純手工的美味', N'阿豪', N'0960 595 959', N'hao_hao_bean1214@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/hao_hao_bean1214@gmail.com2022-09-2310-29-28.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (45, N'耀耀雞蛋糕', N'甜點', N'南部', N'高雄市', N'前鎮區', N'散步美食甜點，下午茶點心 耀耀雞蛋糕 ，把拼圖變成可口雞蛋糕
街頭風點心甜點，創意雞蛋糕，有路過可以嘗鮮唷!
', N'耀耀', N'0986 439 855', N'jason830402@icloud.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/jason830402@icloud.com2022-09-2310-35-57.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (47, N'尋路炸物 ', N'炸物', N'南部', N'高雄市', N'鳳山區 ', N'累了，就讓自己休息一歇。
再為你的夢想加油、尋路。
', N'尋路', N'0986 566 636', N'navigate@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/navigate@gmail.com2022-09-2310-41-11.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (49, N'川田手切冰淇淋 ', N'甜點', N'南部', N'高雄市', N'前鎮區', N'熱熱的天氣，吃冰是一定要的阿，來自新加坡的小吃手切冰淇淋🍦不用出國，在高雄就吃的到了，多種口味可以選擇，尤其泰奶好好吃喲～～相當濃郁好吃，還有限量榴槤口味的當然要吃！推薦給愛吃冰的朋友們～
', N'川田', N'0927 357 010', N'baotien2001@yahoo.com.tw ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/baotien2001@yahoo.com.tw2022-09-2310-48-32.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (51, N'澎膨炸物 ', N'炸物', N'南部', N'高雄市', N'鼓山區', N'烘烤過的墨西哥餅皮，放上豐富的蔬菜以及現炸的主食，淋上獨特的醬料，給你最原汁原味的墨西哥風暴。
', N'澎膨', N'0926 899 283', N'0926899283@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/0926899283@gmail.com2022-09-2310-52-20.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (52, N'Mr.Lonely寂寞先生 ', N'甜點', N'南部', N'高雄市', N'前金區', N'新鮮手工製作的甜點，這是應該堅持的義務，不過度裝飾，只求呈現食物原型，與最原始的美味風暴。', N'寂寞先生 ', N'0977 551 081', N'_wei0512@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/_wei0512@gmail.com2022-09-2310-57-47.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (53, N'逐夢烤餅 ', N'西式', N'南部', N'高雄市', N'三民區', N'夢是一種慾望

想是一種行動

追逐夢想而誕生的逐夢烤餅

每日新鮮採購食材
', N'逐夢', N'0976 359 319', N'dream_scones2019@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/dream_scones2019@gmail.com2022-09-2311-01-05.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (54, N'Maru日式糰子 ', N'日式', N'南部', N'高雄市', N'三民區 ', N'🌸maruまる日式糰子🌸
✨日式烤糰子🍡✨
每一顆糰子每一滴醬料
都是闆娘', N'Maru', N'無', N'maru_dango@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/maru_dango@gmail.com2022-09-2311-04-52.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (56, N'享Eat雞蛋糕 ', N'甜點', N'南部', N'高雄市', N'前鎮區', N'🐿有著松鼠最愛的橡果造型
🐿每日新鮮現打麵糊
🐿不定時更新限定口味
', N'享Eat', N'0917 839 151', N'enjoy_eat_2020@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/enjoy_eat_2020@gmail.com2022-09-2311-10-24.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (57, N'森晴甜坊 ', N'甜點', N'南部', N'高雄市', N'前鎮區', N'甜點與日常生活密不可分，老闆娘堅持用自己的方式描繪出屬於甜點的樣子。森晴甜坊所賣的蛋糕是有別於大多的蛋糕店，一車攤位，卻能包含許多層次的蛋糕口味，不管是自己享受；或是拿蛋糕送給別人都很適合；森晴甜坊是一間很文青質感的餐車店，走在市集裡，眼睛會不自覺被這些質感擺設、蛋糕給吸引過去。
', N'森晴', N'無', N'girl1027boy925@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/girl1027boy925@gmail.com2022-09-2311-15-48.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (58, N'Yaki仙人掌雞蛋糕 ', N'甜點', N'南部', N'高雄市', N'鼓山區', N'有一台喜愛的小餐車、製作著自己喜愛的餐食。', N'yakiyaki', N'無', N'yakiyaki.2017@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/yakiyaki.2017@gmail.com2022-09-2311-19-03.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (60, N'巧遇雞蛋糕燒菓子', N'甜點', N'南部', N'高雄市', N'鳳山區 ', N'每日限量、外皮酥脆 、吃起來甜而不膩。
內餡會不定期的做更換唷~~~
', N'巧遇雞蛋糕', N'無', N'solitarypig384@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/solitarypig384@gmail.com2022-09-2311-25-10.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (61, N'KAJU義式手作冰淇淋飲品 ', N'甜點', N'南部', N'高雄市', N'鹽埕區', N'KAJU義式手作冰淇淋不只能吃到美味的義式冰淇淋，還有罪惡感爆表的惡魔奶昔，豐富的配料光是用看的就口水直流！另外還有搭配不同甜點變化出各種樣式的冰淇淋，精彩程度百分百！
', N'KAJU義式冰淇淋', N'0922 764 115', N'kajugelato@gmail.com', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/kajugelato@gmail.com2022-09-2311-31-33.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (62, N'Uben油飯 古早味油飯', N'台式', N'南部', N'高雄市', N'鹽埕區 ', N'Uben油飯是一家隱身在鹽埕區巷弄的油飯專賣店，在自由黃昏市場也有攤位。取名靈感來自油飯台語音，闆娘在創店時想法希望新世代及老外能知道Uben＝油飯（台語）是臺灣的傳統美食。傳統總鋪師的辦桌風味，結合時下流行的質感設計元素，很快地便在網路上擁有一定的討論聲量。從長輩傳承下來的純正古早味，不只擄獲老一輩的懷舊胃口，連帶收割了年輕世代的一片讚好，所推出的彌月禮盒，更是讓一票媽媽們坐收親友的祝福與呵樂！
', N'Uben', N'0966 449 581', N'uben1268@gmail.com ', N'0000', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/uben1268@gmail.com2022-09-2311-37-05.jpg', NULL)
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (64, N'牛肉麵', N'台式', N'南部', N'臺南市', N'東區大學路', N'好吃的牛肉麵', N'胡鈞智', N'0929594222', N't062914529@gmail.com', N'a3226123', CAST(N'2022-11-20' AS Date), N'/FileUpload/Store/t062914529@gmail.com2022-09-2816-16-24.png', N'1')
INSERT [dbo].[Store] ([StoreID], [Store_Name], [Store_Class], [Address_Area], [Address_City], [Address_Local], [Introduce], [Owner_Name], [Phone], [Email_Account], [Password], [Creation_At], [Picture], [EmailIdentify]) VALUES (65, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Store] OFF
GO
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (1, 1, NULL, NULL, N'臺北市', N'南港區', N'玉成街149號', N'2022-11-25 17:00', N'2022-11-25 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (1, 2, NULL, NULL, N'臺北市', N'南港區', N'玉成街149號', N'2022-11-29 17:00', N'2022-11-29 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (2, 1, NULL, NULL, N'臺北市', N'信義區', N'基隆路一段145號', N'2022-11-30 11:00', N'2022-11-30 14:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (3, 1, NULL, NULL, N'新北市', N'新莊區', N'頭前路123號', N'2022-11-25 16:00', N'2022-11-25 18:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (4, 1, NULL, NULL, N'新北市', N'中和區', N'捷運路157號', N'2022-11-25 10:00', N'2022-11-25 14:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (5, 1, NULL, NULL, N'新北市', N'五股區', N'新五路三段118號', N'2022-11-29 16:00', N'2022-11-29 20:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (5, 2, NULL, NULL, N'台北市', N'萬華區', N'萬華路', N'2022-11-13 16:00', N'2022-11-13 17:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (6, 1, NULL, NULL, N'臺北市', N'大安區', N'光復南路240巷26號', N'2022-11-29 08:00', N'2022-11-29 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (7, 1, NULL, NULL, N'臺北市', N'大安區', N'光復南路316號', N'2022-11-30 11:00', N'2022-11-30 20:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (8, 1, NULL, NULL, N'桃園市', N'大溪區', N'復興路二段138號', N'2022-11-27 09:00', N'2022-11-27 17:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (9, 1, NULL, NULL, N'新竹縣', N'竹北市', N'勝利15街', N'2022-11-25 16:00', N'2022-11-25 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (11, 1, NULL, NULL, N'臺北市', N'大安區', N'敦化南路二段103巷', N'2022-11-28 07:00', N'2022-11-28 10:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (12, 1, NULL, NULL, N'新竹縣', N'竹北市', N'環北路一段107巷', N'2022-11-25 15:30', N'2022-11-25 20:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (14, 1, NULL, NULL, N'臺中市', N'西屯區', N'中清路二段1295號', N'2022-11-23 15:00', N'2022-11-23 19:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (15, 1, NULL, NULL, N'臺中市', N'南區', N'美村南路61號', N'2022-11-27 13:00', N'2022-11-27 18:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (21, 1, NULL, NULL, N'臺中市', N'北屯區', N'北平路四段68號', N'2022-11-26 18:30', N'2022-11-26 20:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (22, 1, NULL, NULL, N'臺中市', N'南屯區', N'文心南五路一段331號', N'2022-11-24 15:30', N'2022-11-24 17:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (24, 1, NULL, NULL, N'臺中市', N'北區', N'五常街261巷18號', N'2022-11-26 10:00', N'2022-11-26 20:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (25, 1, NULL, NULL, N'臺中市', N'太平區', N'中山路二段384號', N'2022-11-26 14:00', N'2022-11-26 19:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (26, 1, NULL, NULL, N'臺中市', N'北屯區', N'敦富一街133號', N'2022-11-24 17:00', N'2022-11-24 22:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (27, 1, NULL, NULL, N'臺中市', N'大里區', N'塗城路252號', N'2022-11-23 17:00', N'2022-11-23 20:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (28, 1, NULL, NULL, N'臺中市', N'西屯區', N'國安一路87號', N'2022-11-22 16:30', N'2022-11-22 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (29, 1, NULL, NULL, N'臺中市', N'潭子區', N'潭興路二段476號', N'2022-11-27 17:00', N'2022-11-27 22:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (30, 1, NULL, NULL, N'臺中市', N'豐原區', N'豐東路602-1號', N'2022-11-26 17:30', N'2022-11-26 23:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (31, 1, NULL, NULL, N'臺中市', N'南屯區', N'五權西路二段2號', N'2022-11-22 17:00', N'2022-11-22 23:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (36, 1, NULL, NULL, N'高雄市', N'苓雅區', N'光榮碼頭站', N'2022-11-25 15:00', N'2022-11-25 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (37, 1, NULL, NULL, N'高雄市', N'小港區', N'桂華街345號', N'2022-11-23 15:30', N'2022-11-23 18:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (38, 1, NULL, NULL, N'高雄市', N'鹽埕區', N'河西路10號', N'2022-11-24 16:00', N'2022-11-24 18:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (39, 1, NULL, NULL, N'高雄市', N'大寮區', N'開封街120號', N'2022-11-24 10:00', N'2022-11-24 18:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (40, 1, NULL, NULL, N'臺北市', N'大安區', N'建國南路一段177號', N'2022-11-25 14:00', N'2022-11-25 20:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (42, 1, NULL, NULL, N'高雄市', N'鹽埕區', N'河西路150號', N'2022-11-24 15:00', N'2022-11-24 22:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (43, 1, NULL, NULL, N'高雄市', N'林園區', N'832高雄市林園區半廓路', N'2022-11-18 16:30', N'2022-11-18 19:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (44, 1, NULL, NULL, N'高雄市', N'苓雅區', N'大順三路72號', N'2022-11-27 15:30', N'2022-11-27 18:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (45, 1, NULL, NULL, N'高雄市', N'苓雅區', N'中正一路8號', N'2022-11-21 15:30', N'2022-11-21 18:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (47, 1, NULL, NULL, N'高雄市', N'苓雅區', N'光榮碼頭站', N'2022-11-25 15:00', N'2022-11-25 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (49, 1, NULL, NULL, N'高雄市', N'前鎮區', N'中安路1-1號', N'2022-11-29 14:00', N'2022-11-29 19:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (51, 1, NULL, NULL, N'高雄市', N'鹽埕區', N'大勇路1號', N'2022-11-25 15:00', N'2022-11-25 20:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (52, 1, NULL, NULL, N'高雄市', N'新興區', N'新田路168號', N'2022-12-01 15:30', N'2022-12-01 20:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (53, 1, NULL, NULL, N'高雄市', N'鹽埕區', N'真愛路1號', N'2022-11-25 15:00', N'2022-11-25 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (54, 1, NULL, NULL, N'高雄市', N'苓雅區', N'高雄市苓雅區海邊路31號', N'2022-11-25 15:00', N'2022-11-25 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (56, 1, NULL, NULL, N'高雄市', N'前鎮區', N'瑞北路153號', N'2022-11-25 14:00', N'2022-11-25 18:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (57, 1, NULL, NULL, N'高雄市', N'前鎮區', N'新光路61號', N'2022-11-25 13:00', N'2022-11-25 20:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (58, 1, NULL, NULL, N'高雄市', N'鼓山區', N'美明路81號', N'2022-11-29 15:00', N'2022-11-29 19:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (60, 1, NULL, NULL, N'高雄市', N'苓雅區', N'二聖一路58號', N'2022-11-27 15:30', N'2022-11-27 18:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (61, 1, NULL, NULL, N'高雄市', N'鹽埕區', N'河西路', N'2022-11-25 15:00', N'2022-11-25 21:00', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (62, 1, NULL, NULL, N'高雄市', N'鹽埕區', N'鹽埕街126號', N'2022-11-26 10:30', N'2022-11-26 17:30', NULL)
INSERT [dbo].[Store_Business] ([StoreID], [CalendarID], [longitude], [latitude], [Address_City], [Address_Local], [Store_Address], [Punch_Start], [Punch_End], [OnBusiness]) VALUES (64, 1, NULL, NULL, N'臺南市', N'東區', N'大學路1號', N'2022-11-30 13:00', N'2022-11-30 16:00', NULL)
GO
SET IDENTITY_INSERT [dbo].[Store_Products] ON 

INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (1, 1001, N'古巴的德式狂野三明治 ', 230, N'/FileUpload/Product/12022-09-2122-23-11.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (1, 1002, N'美式煙燻手撕豬三明治 ', 150, N'/FileUpload/Product/12022-09-2122-23-29.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (1, 1003, N'卡布里的義式浪漫三明治 ', 100, N'/FileUpload/Product/12022-09-2122-23-40.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (1, 1004, N'松露白醬抱抱蝦三明治 ', 220, N'/FileUpload/Product/12022-09-2122-24-05.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (1, 1005, N'煙燻爐烤雞肉盤 ', 150, N'/FileUpload/Product/12022-09-2122-24-13.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (2, 1006, N'黑膠牛肉漢堡', 130, N'/FileUpload/Product/22022-09-2122-52-57.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (2, 1010, N'黑膠雞腿漢堡', 130, N'/FileUpload/Product/22022-09-2122-53-46.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (2, 1011, N'滑板雞腿漢堡', 140, N'/FileUpload/Product/22022-09-2122-53-53.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (2, 1014, N'起司醬熱狗堡', 65, N'/FileUpload/Product/22022-09-2122-54-03.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (2, 1020, N'雞塊', 55, N'/FileUpload/Product/22022-09-2122-54-28.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (2, 1022, N'+升級套餐', 55, N'/FileUpload/Product/22022-09-2122-54-46.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (3, 1023, N'希臘烤肉捲', 145, N'/FileUpload/Product/32022-09-2123-05-50.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (3, 1024, N'鷹嘴豆球捲', 130, N'/FileUpload/Product/32022-09-2123-05-56.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (3, 1025, N'綠巨人捲', 155, N'/FileUpload/Product/32022-09-2123-06-02.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (3, 1027, N'希臘拼盤', 100, N'/FileUpload/Product/32022-09-2123-06-26.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (3, 1028, N'希臘大餐盒', 230, N'/FileUpload/Product/32022-09-2123-06-53.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (4, 1031, N'招牌煎起司牛肉漢堡', 150, N'/FileUpload/Product/42022-09-2123-15-29.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (4, 1032, N'綜合莓果花生醬牛肉漢堡', 150, N'/FileUpload/Product/42022-09-2123-15-41.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (4, 1033, N'剝皮辣椒莎莎醬牛肉漢堡', 140, N'/FileUpload/Product/42022-09-2123-15-49.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (4, 1034, N'經典雙色起司牛肉漢堡', 140, N'/FileUpload/Product/42022-09-2123-15-58.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (4, 1035, N'原味杏仁茶', 40, N'/FileUpload/Product/42022-09-2123-19-15.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (5, 1037, N'香草小肥豬', 350, N'/FileUpload/Product/52022-09-2220-09-21.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (5, 1038, N'韓國包菜肉', 350, N'/FileUpload/Product/52022-09-2220-09-31.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (5, 1039, N'經典瑪格麗特', 250, N'/FileUpload/Product/52022-09-2220-09-38.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (5, 1040, N'三種起司', 350, N'/FileUpload/Product/52022-09-2220-09-46.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (5, 1041, N'義式薩拉米', 350, N'/FileUpload/Product/52022-09-2220-10-00.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (5, 1042, N'水手瑪麗娜', 200, N'/FileUpload/Product/52022-09-2220-10-07.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (5, 1043, N'起司黃檸海鮮', 350, N'/FileUpload/Product/52022-09-2220-10-14.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (6, 1044, N'炸蝦明太子豬肉玉子', 110, N'/FileUpload/Product/62022-09-2220-15-21.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (6, 1045, N'蟹風明太子豬肉玉子', 110, N'/FileUpload/Product/62022-09-2220-15-30.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (6, 1046, N'蟹風豬肉玉子', 100, N'/FileUpload/Product/62022-09-2220-15-35.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (6, 1047, N'炸蝦豬肉玉子', 100, N'/FileUpload/Product/62022-09-2220-15-41.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (6, 1048, N'明太子豬肉玉子', 90, N'/FileUpload/Product/62022-09-2220-15-47.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (6, 1049, N'SPAM豬肉玉子', 75, N'/FileUpload/Product/62022-09-2220-15-52.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (6, 1050, N'日本昆布豬肉玉子', 95, N'/FileUpload/Product/62022-09-2220-16-00.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (7, 1051, N'彩虹香脆熱狗堡(偏小辣)', 177, N'/FileUpload/Product/72022-09-2220-19-10.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (7, 1053, N'起士肉醬熱狗堡', 177, N'/FileUpload/Product/72022-09-2220-19-40.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (7, 1056, N'焦糖洋蔥牛肉熱狗堡', 207, N'/FileUpload/Product/72022-09-2220-19-53.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (7, 1057, N'香草冰淇淋熱狗堡', 207, N'/FileUpload/Product/72022-09-2220-20-03.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (7, 1059, N'番茄玉米嫩雞比薩', 177, N'/FileUpload/Product/72022-09-2220-20-28.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (7, 1075, N'雞翅(4隻)', 97, N'/FileUpload/Product/72022-09-2220-20-42.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (8, 1080, N'起司牛肉堡', 100, N'/FileUpload/Product/82022-09-2220-32-51.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (8, 1090, N'焦糖拿鐵', 120, N'/FileUpload/Product/82022-09-2220-33-03.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (9, 1099, N'爐烤祕製豚三明治', 110, N'/FileUpload/Product/92022-09-2220-37-55.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (9, 1102, N'墨西哥奶汁火腿三明治', 130, N'/FileUpload/Product/92022-09-2220-38-02.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (11, 1112, N'醬爆豬三明治', 85, N'/FileUpload/Product/112022-09-2220-47-34.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (11, 1113, N'韓式烤肉三明治', 85, N'/FileUpload/Product/112022-09-2220-47-56.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (11, 1114, N'紐奧良辣雞三明治', 85, N'/FileUpload/Product/112022-09-2220-48-15.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (12, 1115, N'田園鄉蔬披薩', 250, N'/FileUpload/Product/122022-09-2220-53-42.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (12, 1116, N'夏威夷披薩', 250, N'/FileUpload/Product/122022-09-2220-59-21.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (12, 1117, N'燻雞培根', 280, N'/FileUpload/Product/122022-09-2220-59-43.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (14, 1118, N'豐竹特餐', 150, N'/FileUpload/Product/142022-09-2221-18-47.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (14, 1119, N'小豬特餐', 170, N'/FileUpload/Product/142022-09-2221-19-18.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (15, 1120, N'蔥油餅(一律加蛋)', 30, N'/FileUpload/Product/152022-09-2221-25-45.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (21, 1121, N'綜合豆花', 40, N'/FileUpload/Product/212022-09-2221-58-12.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (22, 1129, N'軟法堡(油條/桂丁雞/豬腹肉)', 120, N'/FileUpload/Product/222022-09-2223-55-52.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (22, 1130, N'肉桂捲', 90, N'/FileUpload/Product/222022-09-2223-55-30.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (24, 1122, N'經典傳統風味扭結', 40, N'/FileUpload/Product/242022-09-2222-31-33.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (25, 1123, N'香蛋餅', 40, N'/FileUpload/Product/252022-09-2222-40-43.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (26, 1124, N'招牌油飯', 50, N'/FileUpload/Product/262022-09-2222-56-35.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (27, 1125, N'麵線糊', 55, N'/FileUpload/Product/272022-09-2223-08-19.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (27, 1126, N'臭豆腐(6顆)', 60, N'/FileUpload/Product/272022-09-2223-08-58.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (28, 1127, N'港式卡邦尼撈麵', 150, N'/FileUpload/Product/282022-09-2223-19-46.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (28, 1128, N'土匪炸雞', 100, N'/FileUpload/Product/282022-09-2223-20-02.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (29, 1131, N'大綜合', 200, N'/FileUpload/Product/292022-09-2300-12-57.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (29, 1132, N'菜單', 0, N'/FileUpload/Product/292022-09-2300-13-45.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (30, 1133, N'鮑魚海鮮湯飯', 280, N'/FileUpload/Product/302022-09-2300-17-38.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (30, 1134, N'生食級干貝海鮮湯飯', 390, N'/FileUpload/Product/302022-09-2300-17-56.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (30, 1135, N'螃蟹海鮮湯飯', 350, N'/FileUpload/Product/302022-09-2300-18-11.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (31, 1136, N'活力歐姆培根蛋堡', 100, N'/FileUpload/Product/312022-09-2300-24-18.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (31, 1137, N'費城風牛肉起司三明治', 160, N'/FileUpload/Product/312022-09-2300-24-41.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (31, 1138, N'墨西哥莎莎堡', 150, N'/FileUpload/Product/312022-09-2300-25-11.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (36, 1139, N' 多肉培根', 70, N'/FileUpload/Product/362022-09-2309-53-06.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (36, 1140, N'炸物拼盤', 90, N'/FileUpload/Product/362022-09-2309-53-24.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (36, 1141, N'雞丁薯條', 80, N'/FileUpload/Product/362022-09-2309-53-34.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (37, 1142, N'奶油卡士達', 45, N'/FileUpload/Product/372022-09-2309-57-28.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (37, 1143, N'焦糖', 45, N'/FileUpload/Product/372022-09-2309-57-40.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (38, 1144, N' 鹹水雞組合包', 160, N'/FileUpload/Product/382022-09-2310-00-30.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (38, 1145, N'串燒組合包', 140, N'/FileUpload/Product/382022-09-2310-00-46.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (39, 1146, N'輸贏掛包', 45, N'/FileUpload/Product/392022-09-2310-04-11.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (39, 1147, N'燒肉捲餅', 55, N'/FileUpload/Product/392022-09-2310-04-21.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (40, 1148, N'頑固油飯 $70', 70, N'/FileUpload/Product/402022-09-2310-09-24.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (42, 1149, N'原味地瓜球(大)(原味/海苔椒鹽/梅粉)', 50, N'/FileUpload/Product/422022-09-2310-17-01.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (42, 1150, N'煉乳地瓜球(小)', 40, N'/FileUpload/Product/422022-09-2310-17-21.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (42, 1151, N'可可脆片地瓜球(小)', 50, N'/FileUpload/Product/422022-09-2310-19-41.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (43, 1152, N' 芭樂汁', 50, N'/FileUpload/Product/432022-09-2310-24-22.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (43, 1153, N'百香果芭樂', 50, N'/FileUpload/Product/432022-09-2310-24-34.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (44, 1154, N'原味抓餅', 45, N'/FileUpload/Product/442022-09-2310-26-59.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (45, 1155, N'原味雞蛋糕', 50, N'/FileUpload/Product/452022-09-2310-34-09.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (47, 1156, N'美式脆薯&椒鹽酥脆雞', 140, N'/FileUpload/Product/472022-09-2310-38-10.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (47, 1157, N'泰式檸檬', 70, N'/FileUpload/Product/472022-09-2310-38-19.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (49, 1158, N' 草莓', 50, N'/FileUpload/Product/492022-09-2310-46-29.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (49, 1159, N'哈密瓜', 55, N'/FileUpload/Product/492022-09-2310-46-38.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (49, 1160, N'抹茶起司雙重奏', 60, N'/FileUpload/Product/492022-09-2310-46-47.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (51, 1161, N'東坡肉烤餅', 80, N'/FileUpload/Product/512022-09-2310-51-52.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (51, 1162, N'蜂蜜雞腿排', 75, N'/FileUpload/Product/512022-09-2310-52-04.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (52, 1163, N'芒果乳酪塔', 45, N'/FileUpload/Product/522022-09-2310-57-03.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (52, 1164, N'焦糖烤布蕾', 45, N'/FileUpload/Product/522022-09-2310-57-16.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (52, 1165, N'巧克力乳酪塔2.0', 50, N'/FileUpload/Product/522022-09-2310-57-31.jpg')
GO
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (53, 1166, N'大口takou', 140, N'/FileUpload/Product/532022-09-2310-59-40.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (53, 1167, N'巧克力香蕉', 90, N'/FileUpload/Product/532022-09-2310-59-51.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (53, 1168, N'羅勒打拋豬', 95, N'/FileUpload/Product/532022-09-2311-00-00.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (54, 1169, N'焦糖雪霜', 45, N'/FileUpload/Product/542022-09-2311-03-36.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (54, 1170, N'繽紛巧克力', 50, N'/FileUpload/Product/542022-09-2311-03-44.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (54, 1171, N'花生烤麻糬', 45, N'/FileUpload/Product/542022-09-2311-03-53.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (56, 1172, N' OREO小小酥', 60, N'/FileUpload/Product/562022-09-2311-09-22.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (56, 1173, N'原味松鼠', 45, N'/FileUpload/Product/562022-09-2311-09-41.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (57, 1174, N' 可可貝禮詩奶酒', 75, N'/FileUpload/Product/572022-09-2311-14-58.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (57, 1175, N'圓珠茶梅酒', 70, N'/FileUpload/Product/572022-09-2311-15-10.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (57, 1176, N'酸溜溜檸檬塔', 100, N'/FileUpload/Product/572022-09-2311-15-18.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (58, 1177, N' OREO甜在心', 50, N'/FileUpload/Product/582022-09-2311-16-53.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (58, 1178, N'海鹽紅豆牛奶', 60, N'/FileUpload/Product/582022-09-2311-17-08.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (58, 1179, N'冬季草莓藍莓盒', 85, N'/FileUpload/Product/582022-09-2311-17-24.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (60, 1180, N' 巧克力', 50, N'/FileUpload/Product/602022-09-2311-24-19.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (60, 1181, N'珍珠奶茶', 50, N'/FileUpload/Product/602022-09-2311-24-32.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (60, 1182, N'草莓卡士達', 60, N'/FileUpload/Product/602022-09-2311-24-41.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (61, 1183, N'蘋果牛奶', 85, N'/FileUpload/Product/612022-09-2311-30-44.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (61, 1184, N'薄荷巧克力布朗尼', 90, N'/FileUpload/Product/612022-09-2311-30-54.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (61, 1185, N'提拉米蘇冰淇淋', 70, N'/FileUpload/Product/612022-09-2311-31-02.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (62, 1186, N' 古早味油飯(小)', 60, N'/FileUpload/Product/622022-09-2311-35-07.png')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (62, 1187, N'辦桌羹', 70, N'/FileUpload/Product/622022-09-2311-36-43.png')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (64, 1190, N'牛肉湯麵', 95, N'/FileUpload/Product/642022-09-2816-24-40.jpg')
INSERT [dbo].[Store_Products] ([StoreID], [ProductID], [Product_Name], [Product_Price], [Product_Picture]) VALUES (64, 1191, N'牛肉乾拌麵', 90, N'/FileUpload/Product/642022-09-2816-24-53.jpg')
SET IDENTITY_INSERT [dbo].[Store_Products] OFF
GO
ALTER TABLE [dbo].[Customer_Favorite]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Favorite_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Customer_Favorite] CHECK CONSTRAINT [FK_Customer_Favorite_Customer]
GO
ALTER TABLE [dbo].[Customer_Favorite]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Favorite_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([StoreID])
GO
ALTER TABLE [dbo].[Customer_Favorite] CHECK CONSTRAINT [FK_Customer_Favorite_Store]
GO
ALTER TABLE [dbo].[Message_Board]  WITH CHECK ADD  CONSTRAINT [FK_Message_Board_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Message_Board] CHECK CONSTRAINT [FK_Message_Board_Customer]
GO
ALTER TABLE [dbo].[Message_Board]  WITH CHECK ADD  CONSTRAINT [FK_Message_Board_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([StoreID])
GO
ALTER TABLE [dbo].[Message_Board] CHECK CONSTRAINT [FK_Message_Board_Store]
GO
ALTER TABLE [dbo].[Store_Business]  WITH CHECK ADD  CONSTRAINT [FK_Store_Business_Calendar] FOREIGN KEY([CalendarID])
REFERENCES [dbo].[Calendar] ([CalendarID])
GO
ALTER TABLE [dbo].[Store_Business] CHECK CONSTRAINT [FK_Store_Business_Calendar]
GO
ALTER TABLE [dbo].[Store_Business]  WITH CHECK ADD  CONSTRAINT [FK_Store_Business_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([StoreID])
GO
ALTER TABLE [dbo].[Store_Business] CHECK CONSTRAINT [FK_Store_Business_Store]
GO
ALTER TABLE [dbo].[Store_Products]  WITH CHECK ADD  CONSTRAINT [FK_Store_Products_Store] FOREIGN KEY([StoreID])
REFERENCES [dbo].[Store] ([StoreID])
GO
ALTER TABLE [dbo].[Store_Products] CHECK CONSTRAINT [FK_Store_Products_Store]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Customer_Favorite"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 203
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Store"
            Begin Extent = 
               Top = 6
               Left = 241
               Bottom = 136
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Store_Products"
            Begin Extent = 
               Top = 6
               Left = 657
               Bottom = 136
               Right = 830
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Store_Business"
            Begin Extent = 
               Top = 6
               Left = 450
               Bottom = 136
               Right = 619
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3675
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Customer_Favorite'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Customer_Favorite'
GO
USE [master]
GO
ALTER DATABASE [trytry] SET  READ_WRITE 
GO
