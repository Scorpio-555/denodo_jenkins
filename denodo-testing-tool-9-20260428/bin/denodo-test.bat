@echo off
REM ---------------------------------------------------------------------------
REM  Environment variable JAVA_HOME must be set and exported
REM ---------------------------------------------------------------------------

IF "%OS%" == "Windows_NT" setlocal ENABLEDELAYEDEXPANSION

SET BIN_DIR=%~dp0
SET DIST_DIR=%BIN_DIR%\..
SET LIB_DIR=%DIST_DIR%\lib


REM ---------------------------------
REM COMPUTE TESTING EXTRA CLASSPATH
REM ---------------------------------

SET TESTING_TOOL_CLASSPATH=.;!DENODO_TEST_CLASSPATH!

REM ---------------------------------
REM COMPUTE CLASSPATH
REM ---------------------------------

SET TESTING_TOOL_CLASSPATH=!TESTING_TOOL_CLASSPATH!;%DIST_DIR%\conf

FOR %%c in ("%LIB_DIR%"\*.jar) DO (
  set TESTING_TOOL_CLASSPATH=!TESTING_TOOL_CLASSPATH!;%%c
)


REM ---------------------------------
REM COMPUTE JAVA EXECUTABLE COMMAND
REM ---------------------------------

SET JAVA_BIN="%JAVA_HOME%\bin\java.exe"
IF EXIST "%JAVA_HOME%" GOTO opts
SET JAVA_BIN="java"

:opts
IF NOT EXIST "%JAVA_OPTS%" (
    SET JAVA_OPTS="-Xmx1024m"
)


REM ---------------------------------
REM OUTPUT EXECUTION ENVIRONMENT
REM ---------------------------------

echo =======================================================
echo DENODO TESTING TOOL
echo =======================================================
echo * Using Denodo Test Classpath (%%DENODO_TEST_CLASSPATH%%): %DENODO_TEST_CLASSPATH%
echo * Using Java executable: %JAVA_BIN%
echo * Using Java Classpath: %TESTING_TOOL_CLASSPATH%
echo -------------------------------------------------------

IF EXIST "%JAVA_BIN%" (
	%JAVA_BIN% %JAVA_OPTS% -classpath "%TESTING_TOOL_CLASSPATH%" com.denodo.connect.testing.TestRunner %*
	goto end
)
echo "Unable to execute '%0': No java executable found and/or no JAVA_HOME variable set"
:end