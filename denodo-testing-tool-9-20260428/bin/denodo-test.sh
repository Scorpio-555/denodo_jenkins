#!/bin/bash
# ---------------------------------------------------------------------------
# Usage: denodo-test.sh [configfile] [testablepath]
#
# Example: denodo-test.sh file:config/configuration.properties file:tests/
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Environment variable JAVA_HOME must be set and exported
# ---------------------------------------------------------------------------

BIN_DIR=`dirname $0`
DIST_DIR=$BIN_DIR/..
LIB_DIR=$DIST_DIR/lib


# ---------------------------------
# COMPUTE TESTING EXTRA CLASSPATH
# ---------------------------------
TESTING_TOOL_CLASSPATH=".:$DENODO_TEST_CLASSPATH"

# ---------------------------------
# COMPUTE CLASSPATH
# ---------------------------------

TESTING_TOOL_CLASSPATH="$TESTING_TOOL_CLASSPATH:$DIST_DIR/conf"
FILES=$(find $LIB_DIR -name '*.jar')
for f in $FILES
do
  TESTING_TOOL_CLASSPATH="$TESTING_TOOL_CLASSPATH:$f"
done

if [ "$OSTYPE" = "cygwin" ]
then
  # Complete paths: turn into cygwin-valid classpath
  TESTING_TOOL_CLASSPATH=`cygpath -p "$TESTING_TOOL_CLASSPATH"`
  # Turn into Windows-valid classpath (it's Windows's Java!)
  TESTING_TOOL_CLASSPATH=`cygpath -pw "$TESTING_TOOL_CLASSPATH"`
fi


# ---------------------------------
# COMPUTE JAVA EXECUTABLE COMMAND
# ---------------------------------

JAVA_BIN=java
if [ -n "$JAVA_HOME" ]
then
  JAVA_BIN=$JAVA_HOME/bin/java
fi

if [ "$OSTYPE" = "cygwin" ]
then
  JAVA_BIN=`cygpath -p "$JAVA_BIN"`
fi


if [ -z "$JAVA_OPTS" ]
then   
    JAVA_OPTS="-Xmx1024m"
fi


# ---------------------------------
# COMPUTE JAVA VERSION
# ---------------------------------

JAVA_VERSION=`"$JAVA_BIN" -version 2>&1 | head -n 1 | cut -d\" -f 2`


# ---------------------------------
# OUTPUT EXECUTION ENVIRONMENT
# ---------------------------------

echo =======================================================
echo DENODO TESTING TOOL
echo =======================================================
echo '*' Using Denodo Test Classpath '($DENODO_TEST_CLASSPATH)': $DENODO_TEST_CLASSPATH
echo '*' Using Java version: $JAVA_VERSION
echo '*' Using Java executable: $JAVA_BIN
echo '*' Using Java Classpath: $TESTING_TOOL_CLASSPATH
echo -------------------------------------------------------


# ---------------------------------
# EXECUTE
# ---------------------------------

"$JAVA_BIN" $JAVA_OPTS -classpath "$TESTING_TOOL_CLASSPATH" com.denodo.connect.testing.TestRunner $*
