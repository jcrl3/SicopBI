

PrestoConnect - how to guide ?

1. to create jar file
  ant jar (creates dist/prestoconnect.jar)

  build depends on few SAS classes. The build file here creates sas_remote.jar from dependent classes from SAS directory.

2. to run sample test case using PrestoConnect For Java API
  ant test 

3. main interface 
     Connection.java

4. to create a local or remote connection
    ConnectionFactory.java

5. Sample 
     ConnectionTest.java
