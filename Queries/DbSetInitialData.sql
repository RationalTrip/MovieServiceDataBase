USE [MovieService]
GO

EXEC CREATE_MOVIE_COUNTRY 'USA'
EXEC CREATE_MOVIE_COUNTRY 'Japan'
GO

EXEC CREATE_MOVIE_PRODUCTION 'film', 'A film – also called a movie, motion picture, moving picture, picture or photoplay – is a work of visual art that simulates experiences and otherwise communicates ideas, stories, perceptions, feelings, beauty, or atmosphere through the use of moving images.'
EXEC CREATE_MOVIE_PRODUCTION 'serial', 'A serial film, film serial (or just serial), movie serial, or chapter play, is a motion picture form popular during the first half of the 20th century, consisting of a series of short subjects exhibited in consecutive order at one theater, generally advancing weekly, until the series is completed.'
EXEC CREATE_MOVIE_PRODUCTION 'anime', 'Anime is a Japanese term for animation. Outside of Japan and in English, anime refers specifically to animation produced in Japan.'
GO

EXEC CREATE_MOVIE_UNIVERSE 'Marvel Cinematic Universe', 'The Marvel Cinematic Universe (MCU) is an American media franchise and shared universe centered on a series of superhero films produced by Marvel Studios. The films are based on characters that appear in American comic books published by Marvel Comics. The franchise also includes television series, short films, digital series, and literature.'
EXEC CREATE_MOVIE_UNIVERSE 'Overlord', 'Overlord is a Japanese anime television series based on the eponymous light novel series written by Kugane Maruyama and illustrated by so-bin.'
GO

EXEC CREATE_MOVIE 'Overlord', 2015, 'Japan', 'anime', 13, NULL, 'Overlord'
EXEC CREATE_MOVIE 'Overlord Season 2', 2018, 'Japan', 'anime', 13, NULL, 'Overlord'
EXEC CREATE_MOVIE 'Overlord Season 3', 2018, 'Japan', 'anime', 13, NULL, 'Overlord'
EXEC CREATE_MOVIE 'Overlord Season 4', 2022, 'Japan', 'anime', 13, NULL, 'Overlord'

EXEC CREATE_MOVIE 'Iron Man', 2008, 'USA', 'film', 1, 'Iron Man is a 2008 American superhero film based on the Marvel Comics character of the same name.', 'Marvel Cinematic Universe'
EXEC CREATE_MOVIE 'Iron Man 2', 2010, 'USA', 'film', 1, 'Iron Man 2 is a 2010 American superhero film based on the Marvel Comics character Iron Man.', 'Marvel Cinematic Universe'
EXEC CREATE_MOVIE 'Iron Man 3', 2013, 'USA', 'film', 1, 'Iron Man 3 is a 2013 American superhero film based on the Marvel Comics character Iron Man.', 'Marvel Cinematic Universe'


EXEC CREATE_MOVIE 'The Punisher Season 1', 2017, 'USA', 'serial', 13, NULL, 'Marvel Cinematic Universe'
EXEC CREATE_MOVIE 'The Punisher Season 2', 2018, 'USA', 'serial', 13, NULL, 'Marvel Cinematic Universe'

EXEC CREATE_MOVIE 'The Green Mile', 1999, 'USA', 'film', 1, 'The Green Mile is a 1999 American fantasy drama film written and directed by Frank Darabont and based on Stephen Kings 1996 novel of the same name. It stars Tom Hanks as a death row prison guard during the Great Depression who witnesses supernatural events following the arrival of an enigmatic convict (Michael Clarke Duncan) at his facility. David Morse, Bonnie Hunt, Doug Hutchison and James Cromwell appear in supporting roles.'
EXEC CREATE_MOVIE 'Forrest Gump', 1994, 'USA', 'film', 1, 'Forrest Gump is a 1994 American comedy-drama film directed by Robert Zemeckis and written by Eric Roth.'

EXEC CREATE_MOVIE 'No Game No Life', 2013, 'Japan', 'anime', 11, 'No Game No Life is a Japanese light novel series by Yū Kamiya. The series follows a group of human gamers seeking to beat the god of games at a series of boardgames in order to usurp the gods throne.'

EXEC CREATE_MOVIE 'Chernobyl', 2013, 'USA', 'serial', 5, 'Chernobyl is a 2019 historical drama television miniseries that revolves around the Chernobyl disaster of 1986 and the cleanup efforts that followed. The series was created and written by Craig Mazin and directed by Johan Renck. It features an ensemble cast led by Jared Harris, Stellan Skarsgård, Emily Watson and Paul Ritter. The series was produced by HBO in the United States and Sky UK in the United Kingdom.'
GO

EXEC CREATE_MOVIE_MAKER 'Tatsuya', 'Shiraishi', '01/12/1962' --OVERLORD PRODUCER
EXEC CREATE_MOVIE_MAKER 'Hara', 'Yumi', '01/21/1985' --OVERLORD VOICER
EXEC CREATE_MOVIE_MAKER 'Hino', 'Satoshi', '08/04/1978' --OVERLORD VOICER

EXEC CREATE_MOVIE_MAKER 'Robert John', 'Downey', '04/04/1965' --IRON MAN ACTOR
EXEC CREATE_MOVIE_MAKER 'Jonathan', 'Favreau', '10/19/1966' --IRON MAN ACTOR AND PRODUCER

EXEC CREATE_MOVIE_MAKER 'Steve', 'Lightfoot', '01/01/1960' --PUNISHER PRODUCER
EXEC CREATE_MOVIE_MAKER 'Jon', 'Bernthal', '09/20/1976' --PUNISHER ACTOR

EXEC CREATE_MOVIE_MAKER 'Eric', 'Roth', '03/22/1945' --FORREST GAMP PRODUCER
EXEC CREATE_MOVIE_MAKER 'Tom', 'Hanks', '07/09/1956' --FORREST GAMP AND GREEN MILE ACTOR
EXEC CREATE_MOVIE_MAKER 'Gary', 'Sinise', '03/17/1955' --FORREST GAMP AND GREEN MILE ACTOR

EXEC CREATE_MOVIE_MAKER 'David', 'Valdes', '08/12/1950' --GREEN MILE PRODUCER
GO

EXEC CREATE_MOVIE_GENRE 'comedy', 'Comedy is the genre that makes people smile.'
EXEC CREATE_MOVIE_GENRE 'action', 'Action film is a film genre in which the protagonist is thrust into a series of events that typically involve violence and physical feats.'
EXEC CREATE_MOVIE_GENRE 'drama', 'Drama is the specific mode of fiction represented in performance.'
EXEC CREATE_MOVIE_GENRE 'fantasy', 'Fantasy is a genre of speculative fiction involving magical elements, typically set in a fictional universe and sometimes inspired by mythology and folklore.'
GO

DECLARE @Shiraishi INT, @Yumi INT, @Satoshi INT, @Downey INT, @Favreau INT, @Lightfoot INT, @Bernthal INT, @Roth INT, @Hanks INT, @Sinise INT, @Valdes INT

SET @Valdes = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Valdes')

SET @Sinise = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Sinise')

SET @Hanks = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Hanks')

SET @Roth = (		SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Roth')

SET @Bernthal = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Bernthal')

SET @Lightfoot = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Lightfoot')

SET @Favreau = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Favreau')

SET @Downey = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Downey')

SET @Satoshi = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Satoshi')

SET @Yumi = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Yumi')

SET @Shiraishi = (	SELECT TOP(1) Id
					FROM MovieMakerScheme.MovieMaker
					WHERE SecondName = 'Shiraishi')

DECLARE @Overlord1 INT, @Overlord2 INT, @Overlord3 INT, @Overlord4 INT, @IronMan1 INT, @IronMan2 INT, @IronMan3 INT
DECLARE @Forrest INT, @GreenMile INT, @Punisher1 INT, @Punisher2 INT, @NoGameNoLife INT, @Chernobyl INT

SET @Chernobyl = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'Chernobyl')

SET @NoGameNoLife = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'No Game No Life')

SET @Punisher2 = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'The Punisher Season 2')

SET @Punisher1 = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'The Punisher Season 1')

SET @GreenMile = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'The Green Mile')

SET @Forrest = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'Forrest Gump')

SET @IronMan3 = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'Iron Man 3')

SET @IronMan2 = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'Iron Man 2')

SET @IronMan1 = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'Iron Man')

SET @Overlord4 = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'Overlord Season 4')

SET @Overlord3 = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'Overlord Season 3')

SET @Overlord2 = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'Overlord Season 2')

SET @Overlord1 = (	SELECT TOP(1) Id
					FROM MovieScheme.MovieInfo
					WHERE Title = 'Overlord')

EXEC ADD_GENRE_TO_MOVIE @Overlord1, 'fantasy'
EXEC ADD_GENRE_TO_MOVIE @Overlord1, 'action'
EXEC ADD_GENRE_TO_MOVIE @Overlord2, 'fantasy'
EXEC ADD_GENRE_TO_MOVIE @Overlord2, 'action'
EXEC ADD_GENRE_TO_MOVIE @Overlord3, 'fantasy'
EXEC ADD_GENRE_TO_MOVIE @Overlord3, 'action'
EXEC ADD_GENRE_TO_MOVIE @Overlord4, 'fantasy'
EXEC ADD_GENRE_TO_MOVIE @Overlord4, 'action'

EXEC ADD_GENRE_TO_MOVIE @IronMan1, 'action'
EXEC ADD_GENRE_TO_MOVIE @IronMan2, 'action'
EXEC ADD_GENRE_TO_MOVIE @IronMan3, 'action'

EXEC ADD_GENRE_TO_MOVIE @Punisher1, 'drama'
EXEC ADD_GENRE_TO_MOVIE @Punisher1, 'action'
EXEC ADD_GENRE_TO_MOVIE @Punisher2, 'drama'
EXEC ADD_GENRE_TO_MOVIE @Punisher2, 'action'

EXEC ADD_GENRE_TO_MOVIE @GreenMile, 'drama'

EXEC ADD_GENRE_TO_MOVIE @Forrest, 'drama'

EXEC ADD_GENRE_TO_MOVIE @NoGameNoLife, 'comedy'
EXEC ADD_GENRE_TO_MOVIE @NoGameNoLife, 'fantasy'

EXEC ADD_GENRE_TO_MOVIE @Chernobyl, 'drama'

EXEC ADD_ACTOR_TO_MOVIE @Downey, @IronMan1
EXEC ADD_ACTOR_TO_MOVIE @Downey, @IronMan2
EXEC ADD_ACTOR_TO_MOVIE @Downey, @IronMan3

EXEC ADD_ACTOR_TO_MOVIE @Favreau, @IronMan1
EXEC ADD_ACTOR_TO_MOVIE @Favreau, @IronMan2
EXEC ADD_ACTOR_TO_MOVIE @Favreau, @IronMan3

EXEC ADD_ACTOR_TO_MOVIE @Bernthal, @Punisher1
EXEC ADD_ACTOR_TO_MOVIE @Bernthal, @Punisher2

EXEC ADD_ACTOR_TO_MOVIE @Hanks, @GreenMile
EXEC ADD_ACTOR_TO_MOVIE @Hanks, @Forrest

EXEC ADD_ACTOR_TO_MOVIE @Sinise, @GreenMile
EXEC ADD_ACTOR_TO_MOVIE @Sinise, @Forrest



EXEC ADD_PRODUCER_TO_MOVIE @Shiraishi, @Overlord1
EXEC ADD_PRODUCER_TO_MOVIE @Shiraishi, @Overlord2
EXEC ADD_PRODUCER_TO_MOVIE @Shiraishi, @Overlord3
EXEC ADD_PRODUCER_TO_MOVIE @Shiraishi, @Overlord4

EXEC ADD_PRODUCER_TO_MOVIE @Favreau, @IronMan1
EXEC ADD_PRODUCER_TO_MOVIE @Favreau, @IronMan2
EXEC ADD_PRODUCER_TO_MOVIE @Favreau, @IronMan3

EXEC ADD_PRODUCER_TO_MOVIE @Lightfoot, @Punisher1
EXEC ADD_PRODUCER_TO_MOVIE @Lightfoot, @Punisher2

EXEC ADD_PRODUCER_TO_MOVIE @Roth, @Forrest

EXEC ADD_PRODUCER_TO_MOVIE @Lightfoot, @GreenMile


EXEC ADD_VOICER_TO_MOVIE @Yumi, @Overlord1
EXEC ADD_VOICER_TO_MOVIE @Yumi, @Overlord2
EXEC ADD_VOICER_TO_MOVIE @Yumi, @Overlord3
EXEC ADD_VOICER_TO_MOVIE @Yumi, @Overlord4

EXEC ADD_VOICER_TO_MOVIE @Satoshi, @Overlord1
EXEC ADD_VOICER_TO_MOVIE @Satoshi, @Overlord2
EXEC ADD_VOICER_TO_MOVIE @Satoshi, @Overlord3
EXEC ADD_VOICER_TO_MOVIE @Satoshi, @Overlord4
GO


EXEC CREATE_ACCOUNT 'user'
EXEC CREATE_ACCOUNT 'user1'
EXEC CREATE_ACCOUNT 'user2'
GO

DECLARE @User INT, @User1 INT, @User2 INT

SET @User = (SELECT TOP(1) Id
			 FROM AccountScheme.Account
			 WHERE [Login] = 'user')

SET @User1 = (SELECT TOP(1) Id
			 FROM AccountScheme.Account
			 WHERE [Login] = 'user1')

SET @User2 = (SELECT TOP(1) Id
			 FROM AccountScheme.Account
			 WHERE [Login] = 'user2')

EXEC CREATE_ACCOUNT_LIST @User, 'My list'
EXEC CREATE_ACCOUNT_LIST @User, 'History'
EXEC CREATE_ACCOUNT_LIST @User, 'Favorite'

EXEC CREATE_ACCOUNT_LIST @User1, 'My list'
EXEC CREATE_ACCOUNT_LIST @User1, 'See later'

EXEC CREATE_ACCOUNT_LIST @User2, 'My list'
EXEC CREATE_ACCOUNT_LIST @User2, 'Tomorrow'
EXEC CREATE_ACCOUNT_LIST @User2, 'New list'

GO

DECLARE @movieId INT, @userId INT, @movieListId INT

DECLARE movieCursor CURSOR
    FOR (SELECT Id
		 FROM MovieScheme.Movie);
OPEN movieCursor;

FETCH NEXT FROM movieCursor INTO @movieId;
WHILE @@FETCH_STATUS = 0  
BEGIN
	DECLARE movieListCursor CURSOR
	    FOR (SELECT Id
			 FROM AccountScheme.MovieLists);
	OPEN movieListCursor;
	
	FETCH NEXT FROM movieListCursor INTO @movieListId;
	WHILE @@FETCH_STATUS = 0  
	BEGIN
		IF RAND() < 0.5
			EXEC ADD_MOVIE_TO_ACCOUNT_LIST @movieListId, @movieId

	    FETCH NEXT FROM movieListCursor INTO @movieListId;  
	END;
	
	CLOSE movieListCursor;
	DEALLOCATE movieListCursor;



	DECLARE userCursor CURSOR
	    FOR (SELECT Id
			 FROM AccountScheme.Account);
	OPEN userCursor;
	
	FETCH NEXT FROM userCursor INTO @userId;
	WHILE @@FETCH_STATUS = 0  
	BEGIN
		IF RAND() < 0.7
		BEGIN
			DECLARE @Rate INT
			
			SELECT @Rate = FLOOR(RAND() * 10)

			EXEC RATE_MOVIE @userId, @movieId, @Rate
		END

	    FETCH NEXT FROM userCursor INTO @userId;  
	END;
	
	CLOSE userCursor;
	DEALLOCATE userCursor;
	
    FETCH NEXT FROM movieCursor INTO @movieId;  
END;

CLOSE movieCursor;
DEALLOCATE movieCursor;
GO