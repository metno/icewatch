@echo off
setlocal ENABLEDELAYEDEXPANSION

set /p database=Enter name of cruise database (omit extension), or [Return] to use default database:
if %database%==[%1]==[] set database=production
set ext=%database:~-7%
if /I not "%ext%"==".sqlite3" set database=%database%.sqlite3

if EXIST "%database%" (
  echo Cruise %database% exists.
  :existingloopstart
  set /p "answer=Are you sure you want to use database %database% [y/n]?:"

  if /I "!answer!"=="n" (
    echo Exiting. Please try again with the name of the cruise you want to use.
	TIMEOUT /T 3
	exit
  )

  if /I NOT "!answer!"=="y" (
	goto existingloopstart
  )
) else (
  echo Cruise %database% does not exist.
  :createloopstart
  set /p "answer=Do you want to create cruise database %database% [y/n]?:"
  if /I "!answer!"=="n" (
    echo Exiting.
	TIMEOUT /T 3
	exit
  )

  if /I NOT "!answer!"=="y" (
	goto createloopstart
  )
  echo "Creating %database%."
  copy empty-database.sqlite3 %database%
)

set DB=%~dp0\%database%
set EXPORT=%~dp0
set JAR=%~dp0\ASSIST.war
set SECRET_KEY_BASE='31f071a9f7a37810dbfaa253b07c972be761a1fe90db090fb97382c12f84d8f0d0216ca9feddb430dc95c0e48f79b6a0136c6664e5a07d067dc7305b9b1e4fd3'
set ICEWATCH_ASSIST='true'
java -Ddb=%DB% -Dexport=%EXPORT% -Xms512M -Xmx1G -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC -jar %JAR%
pause
