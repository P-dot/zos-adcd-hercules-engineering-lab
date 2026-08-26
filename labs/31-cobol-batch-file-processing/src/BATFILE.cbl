       IDENTIFICATION DIVISION.
       PROGRAM-ID. BATFILE.

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

       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE
           RECORDING MODE IS F.
       01  INPUT-RECORD        PIC X(80).
       FD  OUTPUT-FILE
           RECORDING MODE IS F.
       01  OUTPUT-RECORD       PIC X(80).

       WORKING-STORAGE SECTION.
       01  WS-IN-STATUS        PIC XX VALUE SPACES.
       01  WS-OUT-STATUS       PIC XX VALUE SPACES.
       01  WS-EOF              PIC X VALUE 'N'.
           88 EOF-YES          VALUE 'Y'.

       PROCEDURE DIVISION.
           OPEN INPUT INPUT-FILE
                OUTPUT OUTPUT-FILE
           IF WS-IN-STATUS NOT = '00'
               DISPLAY 'INPUT OPEN ERROR: ' WS-IN-STATUS
               STOP RUN
           END-IF
           IF WS-OUT-STATUS NOT = '00'
               DISPLAY 'OUTPUT OPEN ERROR: ' WS-OUT-STATUS
               STOP RUN
           END-IF
           PERFORM UNTIL EOF-YES
               READ INPUT-FILE
                   AT END MOVE 'Y' TO WS-EOF
                   NOT AT END
                       MOVE INPUT-RECORD TO OUTPUT-RECORD
                       WRITE OUTPUT-RECORD
               END-READ
           END-PERFORM
           CLOSE INPUT-FILE OUTPUT-FILE
           STOP RUN.
