USE [MovieService]
GO

CREATE OR ALTER VIEW MovieScheme.MovieWithRates
AS
	SELECT movie.Id,
			movie.Info,
			movie.Country,
			movie.Production,
			movie.Universe,
			votes.Rate,
			votes.VotesCount
	FROM MovieScheme.Movie AS movie
		CROSS APPLY(SELECT COUNT(*) AS VotesCount,
							ROUND(COALESCE(AVG(Cast(Rate AS FLOAT)), 0), 2) AS Rate
					FROM AccountScheme.MovieRates
					WHERE MovieId = movie.Id) AS votes
GO

CREATE OR ALTER VIEW MovieScheme.MovieFullInfo
AS
	SELECT	info.Id,
			info.Title,
			info.YearProduction,
			info.[Description],
			info.Episodes,
			country.[Name] AS Country,
			production.[Name] AS Production,
			universe.[Name] AS Universe,
			movie.Rate,
			movie.VotesCount
	FROM MovieScheme.MovieWithRates AS movie
	JOIN MovieScheme.MovieCountry AS country ON country.Id = movie.Country
	JOIN MovieScheme.MovieProduction AS production ON production.Id = movie.Production
	JOIN MovieScheme.MovieInfo AS info ON info.Id = movie.Info
	LEFT JOIN MovieScheme.MovieUniverse AS universe ON universe.Id = movie.Universe
GO

CREATE OR ALTER VIEW MovieScheme.MovieShortInfo
AS
	SELECT	info.Id,
			info.Title,
			info.YearProduction,
			country.[Name] AS Country,
			production.[Name] AS Production,
			movie.Rate
	FROM MovieScheme.MovieWithRates AS movie
	JOIN MovieScheme.MovieCountry AS country ON country.Id = movie.Country
	JOIN MovieScheme.MovieProduction AS production ON production.Id = movie.Production
	JOIN MovieScheme.MovieInfo AS info ON info.Id = movie.Info
GO

CREATE OR ALTER PROCEDURE GET_BEST_IN_GENRE_SHORT_MOVIE_PAGINATION_IDS
	@GenreId INT,
	@Page INT,
	@MovieByPage INT
AS
	SELECT *
	FROM MovieScheme.MovieShortInfo AS movie
		JOIN MovieScheme.MovieGenresMovies AS genre ON genre.MovieId = movie.Id
	WHERE genre.GenreId = @GenreId
	ORDER BY movie.Rate DESC
	OFFSET (@Page - 1) * @MovieByPage ROWS
	FETCH NEXT @MovieByPage ROWS ONLY
GO

CREATE OR ALTER PROCEDURE GET_BEST_IN_GENRE_SHORT_MOVIE_PAGINATION
	@GenreName NVARCHAR(100),
	@Page INT,
	@MovieByPage INT
AS
BEGIN
	DECLARE @GenreId INT = (SELECT TOP(1) Id
							FROM MovieScheme.MovieGenre AS genre
							WHERE genre.[Name] = LOWER(@GenreName))

	EXEC GET_BEST_IN_GENRE_SHORT_MOVIE_PAGINATION_IDS @GenreId, @Page, @MovieByPage
END
GO

EXEC GET_BEST_IN_GENRE_SHORT_MOVIE_PAGINATION 'drama', 1, 10

EXEC GET_BEST_IN_GENRE_SHORT_MOVIE_PAGINATION 'drama', 1, 2
EXEC GET_BEST_IN_GENRE_SHORT_MOVIE_PAGINATION 'drama', 2, 2
EXEC GET_BEST_IN_GENRE_SHORT_MOVIE_PAGINATION 'drama', 3, 2
EXEC GET_BEST_IN_GENRE_SHORT_MOVIE_PAGINATION 'drama', 4, 2
GO

CREATE OR ALTER PROCEDURE GET_MOVIES_VITH_MOVIES_IN_SAME_COUNTRY_COUNT
AS
	SELECT  Id,
			Title,
			YearProduction,
			[Description],
			Episodes,
			Country,
			COUNT(*) OVER (PARTITION BY Country) AS ThisCountryMovies,
			Production,
			Universe,
			Rate,
			VotesCount
	FROM MovieScheme.MovieFullInfo
GO

EXEC GET_MOVIES_VITH_MOVIES_IN_SAME_COUNTRY_COUNT
GO