----------------------------------------------------------------------------
DENODO TEST SAMPLES: DATA FOLDER
----------------------------------------------------------------------------

This folder contains the data required to run the Denodo Testing Tool
sample test sets.

The contents of this folder are detailed below, by type:

## SQLite databases

Two SQLite databases (files with .sqlite extension) are included. SQLite is
an extremely compact, one-file and zero-configuration database management
system.

In order to access the data in these files, you will only need the SQLite
JDBC driver (see the "References" section at the end of this file). No
server is needed. Note both these databases are user-less and
password-less.

## Denodo VDP Database

One VDP virtual database schema in two files:

   * A .vql containing the import instructions for the database.
   * A .properties file containing its environment properties.

In order to use this VDP database you need to import the .vql file onto a
Denodo VDP server. You will also need to specify the accompanying
.properties file (which you should edit and adapt to your needs before
importing).

Note that before importing this .vql file you will need to install the
SQLite JDBC driver in VDP by copying its .jar file into the
$DENODO_HOME/extensions/thirdparty/lib folder. You can find the driver
in the /drivers folder of the Denodo Testing Tool. After importing the
driver, you will need to restart the VDP Server in order to get the
jar file loaded inside the JVM.

Note also that, during import, VDP might raise two warnings signalling
SQLite as a non-officially tested database. Simply dismiss these
messages.

This import will create a "denodotestsamples" database in your VDP server,
as well as a user with the same name. These database and user will be used
by the diverse sample test sets in this package.


----------------------------------------------------------------------------
References
----------------------------------------------------------------------------

[SQLite]             http://www.sqlite.org/
[SQLite JDBC Driver] https://bitbucket.org/xerial/sqlite-jdbc

