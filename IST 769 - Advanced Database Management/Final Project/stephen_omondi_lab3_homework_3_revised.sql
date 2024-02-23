----////////////////////BEGIN QUESTION #1////////////////----
---which database to use--
USE Demo;
GO

--drop table if it already exists, otherwise create it
DROP TABLE IF EXISTS shots;
GO

--drop table if it already exists, otherwise create it
DROP TABLE IF EXISTS players;
GO


---create tables in the demo database---
CREATE TABLE players(
	player_id INT IDENTITY PRIMARY KEY NOT NULL,
	player_name VARCHAR(255) NOT NULL,
	shots_attempted INT NOT NULL,
	shots_made INT NOT NULL
);
GO

--create table 'shots'--
CREATE TABLE shots(
	shot_id INT IDENTITY PRIMARY KEY NOT NULL,
	player_id INT FOREIGN KEY REFERENCES players(player_id) NOT NULL,
	clock_time DATETIME NOT NULL 
			   DEFAULT CURRENT_TIMESTAMP,
	shot_made BIT
);
GO

--insert players into the players table--
INSERT INTO players(player_name, shots_attempted, shots_made)
		VALUES('Mary', 0, 0),
			   ('Sue', 0, 0);
GO
----////////////////////END QUESTION #1////////////////----




----////////////////////BEGIN QUESTION #2////////////////----

---stored procudure for transactions---
DROP PROCEDURE IF EXISTS player_record
GO

CREATE PROCEDURE player_record
	@player_id INT,
	@shot_made BIT
AS
BEGIN TRY
	BEGIN TRANSACTION
		INSERT INTO shots(player_id, shot_made) 
		VALUES(@player_id, @shot_made);
		IF @@ROWCOUNT <> 1 THROW 50001, 'Insert to players table affected 0 rows, expecting 1',0

		UPDATE players
		SET shots_made = shots_made + @shot_made,
			shots_attempted = shots_attempted + 1
		WHERE player_id = @player_id;
		IF @@ROWCOUNT <>1 THROW 5001, 'Update to shots table affected 0 rows, expecting at least 1',0
	COMMIT
END TRY
BEGIN CATCH
	PRINT error_message()
	ROLLBACK
END CATCH
GO

---set transaction isolation level-
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--GO

--call the player procedure for Mary---
EXEC player_record @player_id=1, @shot_made=0;
GO

--call the player procedure for Sue
EXEC player_record @player_id=2, @shot_made=1;
GO

----verify transactions---
Select * from players;
Select * from shots;
----////////////////////END QUESTION #2////////////////----




----////////////////////BEGIN QUESTION #3////////////////----
---ALTER PLAYERS TABLE---
ALTER TABLE players
ADD StartTime DATETIME2 GENERATED ALWAYS AS ROW START
  HIDDEN DEFAULT GETUTCDATE(),
 EndTime  DATETIME2 GENERATED ALWAYS AS ROW END
  HIDDEN DEFAULT
     CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
 PERIOD FOR SYSTEM_TIME (StartTime, EndTime)


ALTER TABLE shots
ADD StartTime DATETIME2 GENERATED ALWAYS AS ROW START
  HIDDEN DEFAULT GETUTCDATE(),
 EndTime  DATETIME2 GENERATED ALWAYS AS ROW END
  HIDDEN DEFAULT
     CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999'),
 PERIOD FOR SYSTEM_TIME (StartTime, EndTime)



--ENABLE VERSIONING---
ALTER TABLE players
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE=dbo.Player_history))
GO

ALTER TABLE shots
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE=dbo.Shot_history))
GO

----////////////////////END QUESTION #3////////////////----




----////////////////////END QUESTION #5////////////////----
---QUERYING TEMPORAL TABLE--
--a--
SELECT * FROM players;
GO

--statistics in the first 2 mins and 30 seconds--
SELECT P.player_name, S.shot_made AS Made, P.shots_attempted as Attempted FROM shots S
INNER JOIN players P ON P.player_id = S.player_id
WHERE S.clock_time <= DATEADD(SECOND, 150, '2019-10-18 22:41:02.907')
ORDER BY S.shot_made;
GO


--statistics for the last minute into the game--
SELECT P.player_name, S.shot_made AS Made, P.shots_attempted as Attempted FROM shots S
INNER JOIN players P ON P.player_id = S.player_id
WHERE S.clock_time BETWEEN DATEADD(MINUTE, 4, '2019-10-18 22:41:02.907') AND DATEADD(MINUTE, 5, '2019-10-18 22:41:02.907')
ORDER BY S.shot_made;
GO


--CLEAN UP REMOVING SYSTEM VERSIONS--
ALTER TABLE players
SET (SYSTEM_VERSIONING = OFF);
GO

ALTER TABLE shots
SET (SYSTEM_VERSIONING = OFF);
GO


--SELECT CURRENT_USER as UpdatedBy, GETDATE() as UpdatedOn;
--GO