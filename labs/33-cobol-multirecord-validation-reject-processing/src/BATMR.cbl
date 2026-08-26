       IDENTIFICATION DIVISION.
       PROGRAM-ID. BATMR.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE
               ASSIGN TO INFILE
               ORGANIZATION IS SEQUENTIAL
               FILE STATUS IS WS-IN-STATUS.

           SELECT OUTPUT-FILE
               ASSIGN TO OUTFILE
               ORGANIZATION IS SEQUENTIAL
               FILE STATUS IS WS-OUT-STATUS.

           SELECT REJECT-FILE
               ASSIGN TO REJFILE
               ORGANIZATION IS SEQUENTIAL
               FILE STATUS IS WS-REJ-STATUS.

       DATA DIVISION.
       FILE SECTION.

       FD  INPUT-FILE
           RECORDING MODE IS F.
       01  INPUT-RECORD          PIC X(80).

       FD  OUTPUT-FILE
           RECORDING MODE IS F.
       01  OUTPUT-RECORD         PIC X(80).

       FD  REJECT-FILE
           RECORDING MODE IS F.
       01  REJECT-RECORD         PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-IN-STATUS          PIC XX VALUE SPACES.
       01  WS-OUT-STATUS         PIC XX VALUE SPACES.
       01  WS-REJ-STATUS         PIC XX VALUE SPACES.

       01  WS-EOF                PIC X VALUE 'N'.
           88  EOF-YES           VALUE 'Y'.

       01  WS-READ-COUNT         PIC 9(5) VALUE 0.
       01  WS-VALID-COUNT        PIC 9(5) VALUE 0.
       01  WS-REJECT-COUNT       PIC 9(5) VALUE 0.

       PROCEDURE DIVISION.

           OPEN INPUT INPUT-FILE
                OUTPUT OUTPUT-FILE
                OUTPUT REJECT-FILE

           IF WS-IN-STATUS NOT = '00'
               DISPLAY 'INPUT OPEN ERROR: ' WS-IN-STATUS
               MOVE 8 TO RETURN-CODE
               STOP RUN
           END-IF

           IF WS-OUT-STATUS NOT = '00'
               DISPLAY 'OUTPUT OPEN ERROR: ' WS-OUT-STATUS
               MOVE 8 TO RETURN-CODE
               STOP RUN
           END-IF

           IF WS-REJ-STATUS NOT = '00'
               DISPLAY 'REJECT OPEN ERROR: ' WS-REJ-STATUS
               MOVE 8 TO RETURN-CODE
               STOP RUN
           END-IF

           PERFORM UNTIL EOF-YES
               READ INPUT-FILE
                   AT END
                       MOVE 'Y' TO WS-EOF
                   NOT AT END
                       ADD 1 TO WS-READ-COUNT

                       IF INPUT-RECORD(1:1) = 'V'
                           MOVE INPUT-RECORD TO OUTPUT-RECORD
                           WRITE OUTPUT-RECORD
                           ADD 1 TO WS-VALID-COUNT
                       ELSE
                           MOVE INPUT-RECORD TO REJECT-RECORD
                           WRITE REJECT-RECORD
                           ADD 1 TO WS-REJECT-COUNT
                       END-IF
               END-READ
           END-PERFORM

           CLOSE INPUT-FILE
                 OUTPUT-FILE
                 REJECT-FILE

           DISPLAY 'RECORDS READ     = ' WS-READ-COUNT
           DISPLAY 'VALID RECORDS    = ' WS-VALID-COUNT
           DISPLAY 'REJECTED RECORDS = ' WS-REJECT-COUNT

           IF WS-REJECT-COUNT > 0
               MOVE 4 TO RETURN-CODE
               DISPLAY 'BATCH COMPLETED WITH REJECTS - RC=0004'
           ELSE
               MOVE 0 TO RETURN-CODE
               DISPLAY 'BATCH COMPLETED OK - RC=0000'
           END-IF

           STOP RUN.
