USE [MovieService]
GO

CREATE OR ALTER PROCEDURE CREATE_MOVIE_WITH_IDS
	@Title NVARCHAR(100),
	@YearProduction INT,
	@CountryId INT,
	@ProductionId INT,
	@EpisodesCount INT = 0,
	@Description NVARCHAR(MAX) = NULL,
	@UniverseId INT = NULL
AS
BEGIN
	BEGIN TRANSACTION CREATE_MOVIE_IDS;

	BEGIN TRY
		DECLARE @MovieId INT = NEXT VALUE FOR MovieScheme.MovieInfoIdSequence

		INSERT INTO MovieScheme.MovieInfo
			([Id], [Title], [Description], [YearProduction], [Episodes])
		VALUES (@MovieId, @Title, @Description, @YearProduction, @EpisodesCount);

		INSERT INTO MovieScheme.Movie
			([Id], [Info], [Country], [Universe], [Production])
		VALUES (@MovieId, @MovieId, @CountryId, @UniverseId, @ProductionId);

		IF @@TRANCOUNT > 0  
			COMMIT TRANSACTION CREATE_MOVIE_IDS;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0  
			ROLLBACK TRANSACTION CREATE_MOVIE_IDS;

        THROW;
	END CATCH
END
GO

CREATE OR ALTER PROCEDURE CREATE_MOVIE
	@Title NVARCHAR(100),
	@YearProduction INT,
	@CountryName NVARCHAR(100),
	@ProductionName NVARCHAR(100),
	@EpisodesCount INT = 0,
	@Description NVARCHAR(MAX) = NULL,
	@UniverseName NVARCHAR(100) = NULL
AS
BEGIN
	DECLARE @CountryId INT = (	SELECT TOP(1) Id
								FROM MovieScheme.MovieCountry
								WHERE [Name] = @CountryName)

	DECLARE @ProductionId INT = (SELECT TOP(1) Id
								 FROM MovieScheme.MovieProduction
								 WHERE [Name] = @ProductionName)

	DECLARE @UniverseId INT = NULL

	IF @UniverseName IS NOT NULL
	BEGIN
		SET @UniverseId = ( SELECT TOP(1) Id
							FROM MovieScheme.MovieUniverse
							WHERE [Name] = @UniverseName)
	END

	EXECUTE CREATE_MOVIE_WITH_IDS @Title, @YearProduction, @CountryId, @ProductionId, @EpisodesCount, @Description, @UniverseId
END
GO

CREATE OR ALTER PROCEDURE CREATE_MOVIE_GENRE
	@Name NVARCHAR(100),
	@Description NVARCHAR(MAX) = NULL
AS
	INSERT INTO MovieScheme.MovieGenre
		([Name], [Description])
	VALUES (LOWER(@Name), @Description)
GO

CREATE OR ALTER PROCEDURE ADD_GENRE_TO_MOVIE_WITH_IDS
	@MovieId INT,
	@GenreId INT
AS
	INSERT INTO MovieScheme.MovieGenresMovies
		(MovieId, GenreId)
	VALUES (@MovieId, @GenreId)
GO

CREATE OR ALTER PROCEDURE ADD_GENRE_TO_MOVIE
	@MovieId INT,
	@GenreName NVARCHAR(100)
AS
BEGIN
	DECLARE @GenreId INT = (SELECT TOP(1) Id
							FROM MovieScheme.MovieGenre
							WHERE [Name] = @GenreName)

	EXEC ADD_GENRE_TO_MOVIE_WITH_IDS @MovieId, @GenreId
END
GO

CREATE OR ALTER PROCEDURE CREATE_MOVIE_COUNTRY
	@Country NVARCHAR(100)
AS
	INSERT INTO MovieScheme.MovieCountry
		([Name])
	VALUES (@Country)
GO

CREATE OR ALTER PROCEDURE CREATE_MOVIE_PRODUCTION
	@Name NVARCHAR(100),
	@Description NVARCHAR(MAX) = NULL
AS
	INSERT INTO MovieScheme.MovieProduction
		([Name], [Description])
	VALUES (LOWER(@Name), @Description)
GO

CREATE OR ALTER PROCEDURE CREATE_MOVIE_UNIVERSE
	@Name NVARCHAR(100),
	@Description NVARCHAR(MAX) = NULL
AS
	INSERT INTO MovieScheme.MovieUniverse
		([Name], [Description])
	VALUES (@Name, @Description)
GO

CREATE OR ALTER PROCEDURE SET_UNIVERSE_TO_MOVIE
	@MovieId INT,
	@UniverseId INT
AS
	UPDATE MovieScheme.Movie
	SET Universe = @UniverseId
	WHERE Id = @MovieId
GO

CREATE OR ALTER PROCEDURE CREATE_MOVIE_MAKER
	@FirstName NVARCHAR(100),
	@SecondName NVARCHAR(100),
	@BirthDate Date,
	@About NVARCHAR(MAX) = NULL,
	@DeathDate DATE = NULL
AS
	INSERT INTO MovieMakerScheme.MovieMaker
		(FirstName, SecondName, About, BornDate, DeathDate)
	VALUES (@FirstName, @SecondName, @About, @BirthDate, @DeathDate)
GO

CREATE OR ALTER PROCEDURE ADD_ACTOR_TO_MOVIE
	@ActorId INT,
	@MovieId INT
AS
	INSERT INTO MovieMakerScheme.ActorRole
		(ActorId, MovieId)
	VALUES (@ActorId, @MovieId)
GO

CREATE OR ALTER PROCEDURE ADD_PRODUCER_TO_MOVIE
	@ProducerId INT,
	@MovieId INT
AS
	INSERT INTO MovieMakerScheme.ProducerRole
		(ProducerId, MovieId)
	VALUES (@ProducerId, @MovieId)
GO

CREATE OR ALTER PROCEDURE ADD_VOICER_TO_MOVIE
	@VoicerId INT,
	@MovieId INT
AS
	INSERT INTO MovieMakerScheme.VoicerRole
		(VoicerId, MovieId)
	VALUES (@VoicerId, @MovieId)
GO

CREATE OR ALTER PROCEDURE CREATE_ACCOUNT
	@Login NVARCHAR(100)
AS
	INSERT INTO AccountScheme.Account
		([Login])
	VALUES (@Login)
GO

CREATE OR ALTER PROCEDURE CREATE_ACCOUNT_LIST
	@AccountId INT,
	@MovieListName NVARCHAR(100)
AS
	INSERT INTO AccountScheme.MovieLists
		([AccountId], [Name])
	VALUES (@AccountId, @MovieListName)
GO

CREATE OR ALTER PROCEDURE ADD_MOVIE_TO_ACCOUNT_LIST
	@MovieListId INT,
	@MovieId INT
AS
	INSERT INTO AccountScheme.MovieListsFilms
		([MovieListId], [MovieId])
	VALUES (@MovieListId, @MovieId)
GO

CREATE OR ALTER PROCEDURE RATE_MOVIE
	@AccountId INT,
	@MovieId INT,
	@Rate INT
AS
	MERGE AccountScheme.MovieRates AS MRates
	USING (SELECT @AccountId AS AccountId, @MovieId AS MovieId) AS NewRate
		ON MRates.AccountId = NewRate.AccountId AND MRates.MovieId = NewRate.MovieId
	WHEN MATCHED
		THEN UPDATE SET Rate = @Rate
	WHEN NOT MATCHED
		THEN INSERT (AccountId, MovieId, Rate)
				VALUES (@AccountId, @MovieId, @Rate);
GO