IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'DataBase')
  BEGIN
	CREATE DATABASE [MovieService]
END
GO

USE [MovieService]
GO

IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'AccountScheme' )
    EXEC('CREATE SCHEMA [AccountScheme]');
GO

IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'MovieScheme' )
    EXEC('CREATE SCHEMA [MovieScheme]');
GO

IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'MovieMakerScheme' )
    EXEC('CREATE SCHEMA [MovieMakerScheme]');
GO


IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.SEQUENCES
				WHERE   SEQUENCE_NAME      = 'MovieInfoIdSequence'
				    AND SEQUENCE_SCHEMA    = 'MovieScheme')
BEGIN
    CREATE SEQUENCE MovieScheme.MovieInfoIdSequence
		AS INT
		START WITH 1
		INCREMENT BY 1
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieInfo'
				    AND TABLE_SCHEMA    = 'MovieScheme')
BEGIN
    CREATE TABLE MovieScheme.MovieInfo (
        Id INT PRIMARY KEY,
        Title NVARCHAR(100) NOT NULL,
		YearProduction INT NOT NULL,
		[Description] NVARCHAR(MAX),
		Episodes INT DEFAULT 0,

		UNIQUE (Title, YearProduction)
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieCountry'
				    AND TABLE_SCHEMA    = 'MovieScheme')
BEGIN
	CREATE TABLE MovieScheme.MovieCountry (
        Id INT PRIMARY KEY IDENTITY,
        [Name] NVARCHAR(100) UNIQUE NOT NULL
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieUniverse'
				    AND TABLE_SCHEMA    = 'MovieScheme')
BEGIN
	CREATE TABLE MovieScheme.MovieUniverse (
        Id INT PRIMARY KEY IDENTITY,
        [Name] NVARCHAR(100) UNIQUE NOT NULL,
		[Description] NVARCHAR(MAX) DEFAULT NULL
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieProduction'
				    AND TABLE_SCHEMA    = 'MovieScheme')
BEGIN
	CREATE TABLE MovieScheme.MovieProduction (
        Id INT PRIMARY KEY IDENTITY,
        [Name] NVARCHAR(100) UNIQUE NOT NULL,
		[Description] NVARCHAR(MAX) DEFAULT NULL
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'Movie'
				    AND TABLE_SCHEMA    = 'MovieScheme')
BEGIN
	CREATE TABLE MovieScheme.Movie (
        Id INT PRIMARY KEY,
        Info INT NOT NULL UNIQUE,
		Country INT,
		Production INT NOT NULL,
		Universe INT DEFAULT NULL,

		CONSTRAINT FK_Movie_MovieInfo FOREIGN KEY (Info) REFERENCES MovieScheme.MovieInfo(Id),
		CONSTRAINT FK_Movie_MovieCountry FOREIGN KEY (Country) REFERENCES MovieScheme.MovieCountry(Id),
		CONSTRAINT FK_Movie_MovieUniverse FOREIGN KEY (Universe) REFERENCES MovieScheme.MovieUniverse(Id),
		CONSTRAINT FK_Movie_MovieProduction FOREIGN KEY (Production) REFERENCES MovieScheme.MovieProduction(Id)
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieGenre'
				    AND TABLE_SCHEMA    = 'MovieScheme')
BEGIN
	CREATE TABLE MovieScheme.MovieGenre (
        Id INT PRIMARY KEY IDENTITY,
        [Name] NVARCHAR(100) UNIQUE NOT NULL,
		[Description] NVARCHAR(MAX) DEFAULT NULL
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieGenresMovies'
				    AND TABLE_SCHEMA    = 'MovieScheme')
BEGIN
	CREATE TABLE MovieScheme.MovieGenresMovies (
		MovieId INT NOT NULL,
		GenreId INT NOT NULL,

		PRIMARY KEY(MovieId, GenreId),

		CONSTRAINT FK_MovieGenresMovies_MovieGenre FOREIGN KEY (GenreId) REFERENCES MovieScheme.MovieGenre(Id),
		CONSTRAINT FK_MovieGenresMovies_Movie FOREIGN KEY (MovieId) REFERENCES MovieScheme.Movie(Id)
    )
END
GO


IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieMaker'
				    AND TABLE_SCHEMA    = 'MovieMakerScheme')
BEGIN
	CREATE TABLE MovieMakerScheme.MovieMaker (
        Id INT PRIMARY KEY IDENTITY,
        FirstName NVARCHAR(100) NOT NULL,
		SecondName NVARCHAR(100) NOT NULL,
		About NVARCHAR(MAX) NULL,
		BornDate DATE NOT NULL,
		DeathDate DATE NULL
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'ActorRole'
				    AND TABLE_SCHEMA    = 'MovieMakerScheme')
BEGIN
	CREATE TABLE MovieMakerScheme.ActorRole (
        MovieId INT NOT NULL,
		ActorId INT NOT NULL,

		PRIMARY KEY (MovieId, ActorId),

		CONSTRAINT FK_ActorRole_Actor FOREIGN KEY (ActorId) REFERENCES MovieMakerScheme.MovieMaker(Id),
		CONSTRAINT FK_ActorRole_Movie FOREIGN KEY (MovieId) REFERENCES MovieScheme.Movie(Id)
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'ProducerRole'
				    AND TABLE_SCHEMA    = 'MovieMakerScheme')
BEGIN
	CREATE TABLE MovieMakerScheme.ProducerRole (
        ProducerId INT NOT NULL,
		MovieId INT NOT NULL,

		PRIMARY KEY (ProducerId, MovieId),

		CONSTRAINT FK_ProducerRole_Producer FOREIGN KEY (ProducerId) REFERENCES MovieMakerScheme.MovieMaker(Id),
		CONSTRAINT FK_ProducerRole_Movie FOREIGN KEY (MovieId) REFERENCES MovieScheme.Movie(Id)
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'VoicerRole'
				    AND TABLE_SCHEMA    = 'MovieMakerScheme')
BEGIN
	CREATE TABLE MovieMakerScheme.VoicerRole (
        MovieId INT NOT NULL,
		VoicerId INT NOT NULL,

		PRIMARY KEY (MovieId, VoicerId),

		CONSTRAINT FK_VoicerRole_Voicer FOREIGN KEY (VoicerId) REFERENCES MovieMakerScheme.MovieMaker(Id),
		CONSTRAINT FK_VoicerRole_Movie FOREIGN KEY (MovieId) REFERENCES MovieScheme.Movie(Id)
    )
END
GO


IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'Account'
				    AND TABLE_SCHEMA    = 'AccountScheme')
BEGIN
	CREATE TABLE AccountScheme.Account (
        Id INT PRIMARY KEY IDENTITY,
		[Login] NVARCHAR(100) UNIQUE NOT NULL
    )
END
GO


IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieLists'
				    AND TABLE_SCHEMA    = 'AccountScheme')
BEGIN
	CREATE TABLE AccountScheme.MovieLists (
        Id INT PRIMARY KEY IDENTITY,
		AccountId INT NOT NULL,
		[Name] NVARCHAR(100) NOT NULL,

		CONSTRAINT FK_MovieLists_OwnerAccount FOREIGN KEY (AccountId) REFERENCES AccountScheme.Account(Id)
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieListsFilms'
				    AND TABLE_SCHEMA    = 'AccountScheme')
BEGIN
	CREATE TABLE AccountScheme.MovieListsFilms (
		MovieListId INT NOT NULL,
		MovieId INT NOT NULL,
		
		PRIMARY KEY (MovieListId, MovieId),

		CONSTRAINT FK_MovieListsFilms_MovieList FOREIGN KEY (MovieListId) REFERENCES AccountScheme.MovieLists(Id),
		CONSTRAINT FK_MovieListsFilms_Movie FOREIGN KEY (MovieId) REFERENCES MovieScheme.Movie(Id)
    )
END
GO

IF NOT EXISTS (	SELECT  *
				FROM    INFORMATION_SCHEMA.TABLES
				WHERE   TABLE_NAME      = 'MovieRates'
				    AND TABLE_SCHEMA    = 'AccountScheme')
BEGIN
	CREATE TABLE AccountScheme.MovieRates (
		AccountId INT NOT NULL,
		MovieId INT NOT NULL,
		Rate INT NOT NULL,
		
		PRIMARY KEY (AccountId, MovieId),

		CONSTRAINT CHK_MovieRates_RateCheck CHECK (Rate >= 0 AND Rate <= 10),
		CONSTRAINT FK_MovieRates_Account FOREIGN KEY (AccountId) REFERENCES AccountScheme.Account(Id),
		CONSTRAINT FK_MovieRates_Movie FOREIGN KEY (MovieId) REFERENCES MovieScheme.Movie(Id)
    )
END
GO