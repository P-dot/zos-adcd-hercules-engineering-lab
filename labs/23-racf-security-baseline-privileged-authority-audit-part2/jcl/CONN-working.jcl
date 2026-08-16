//* LAB 23 PART 2 - WORKING RACFICE CONN INVOCATION
//*
//* NOTE:
//* The successful execution reused the known-good UGLBRPT job card.
//* The report selector was changed to REPORT=CONN.
//*
//UGLBRPT JOB (LAB23),'RACF UGLB REPORT',
//             CLASS=A,MSGCLASS=X,
//             MSGLEVEL=(1,1),NOTIFY=&SYSUID
//*
//* LAB 23 - RACFICE GLOBAL PRIVILEGED USERS
//* IBM REPORT: UGLB
//* INPUT: IBMUSER.RACF.UNLOAD
//*
//         JCLLIB ORDER=IBMUSER.RACFICE
//*
//CONN     EXEC RACFICE,REPORT=CONN
