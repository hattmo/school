#set page(
    paper: "us-letter",
    numbering: "1",
    margin: 0.5in
)

#set text(
    font: "Times New Roman"
)

#align(center)[
    #text(20pt)[CSE 566 - Homework #5: Metrics]
    #linebreak()
    #text(16pt)[Matthew Howard]
]

= Part 1: Resource Standard Metrics

#let code = {```java
package com.hattmo.liquid.networking;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.LinkedList;
import java.util.Locale;
import java.util.Optional;
import com.hattmo.liquid.messages.http.HTTPMessage;
import com.hattmo.liquid.messages.http.HTTPRequestMessage;
import com.hattmo.liquid.messages.http.HTTPResponseMessage;

public class ParserHTTP implements Parser {

    private BufferedReader br;
    private BufferedOutputStream bos;

    public void setInputStream(InputStream is) {
        this.br = new BufferedReader(new InputStreamReader(is));
    }

    public void setOutputStream(OutputStream os) {
        this.bos = new BufferedOutputStream(os);
    }

    public void sendMessage(Message m) throws IllegalArgumentException, IOException {

        if (m instanceof HTTPMessage) {
            HTTPMessage outMessage = (HTTPMessage) m;
            bos.write(outMessage.getBytes());
            bos.flush();
        } else {
            throw new IllegalArgumentException();
        }
    }

    public void recieveMessage(MessageDispatcher messageDispach) throws IOException {
        String startLine;
        startLine = br.readLine();
        if (startLine == null) {
            throw new IOException();
        }
        String[] startLineItems = startLine.split(" ", 3);
        if (startLineItems.length == 3) {
            HTTPMessage mess;
            if (startLineItems[0].equals("HTTP/1.1") || startLineItems[0].equals("HTTP/1.0")) {
                mess = new HTTPResponseMessage(startLineItems[1], startLineItems[2]);
            } else {
                mess = new HTTPRequestMessage(startLineItems[0], startLineItems[1]);
            }
            while (true) {
                String param;
                param = br.readLine();
                if (param == null || param.equals("")) {
                    break;
                }
                String[] split = param.split(":");
                if (split.length == 2) {
                    mess.setParameter(split[0].trim().toLowerCase(Locale.US), split[1].trim());
                }
            }

            Optional<String> contentLength = mess.getParameter("content-length");
            if (contentLength.isPresent()) {
                try {
                    int conLen = Integer.parseInt(contentLength.get());
                    byte[] bodyOut = new byte[conLen];
                    for (int i = 0; i < conLen; i++) {
                        bodyOut[i] = (byte) br.read();
                    }
                    if (bodyOut.length != 0) {
                        mess.setBody(bodyOut);
                    }
                } catch (NumberFormatException | IOException e) {
                    System.out.println(e);
                    return;
                }
            }
            Optional<String> transferEncoding = mess.getParameter("transfer-encoding");
            if (transferEncoding.isPresent() && transferEncoding.get().equals("chunked")) {
                LinkedList<Byte> tempBytes = new LinkedList<>();
                int value = 0;
                while ((value = Integer.parseInt(br.readLine(), 16)) != 0) {
                    if (value != 0) {
                        for (int i = 0; i < value; i++) {
                            tempBytes.add((byte) br.read());
                        }
                        br.readLine();
                    }
                }
                byte[] bodyOut = new byte[tempBytes.size()];
                for (int i = 0; i < tempBytes.size(); i++) {
                    bodyOut[i] = tempBytes.get(i);
                }
                mess.setBody(bodyOut);
            }
            messageDispach.dispatch(mess);
        }
    }
}
```}

#let command = `rsm -O"report.txt" -fa -c -o -Es -E ParserHTTP.java`

#let report = {```
Package Begin: com.hattmo.liquid.networking
    17: author Hattmo
Function: com.hattmo.liquid.networking.ParserHTTP.setInputStream
Parameters: (InputStream is)
Complexity   Param 1       Return 1      Cyclo Vg 1       Total        3
LOC 3        eLOC 2        lLOC 1        Comment 0        Lines        3

Function: com.hattmo.liquid.networking.ParserHTTP.setOutputStream
Parameters: (OutputStream os)
Complexity   Param 1       Return 1      Cyclo Vg 1       Total        3
LOC 3        eLOC 2        lLOC 1        Comment 0        Lines        3

Function: com.hattmo.liquid.networking.ParserHTTP.sendMessage
Parameters: (Message m)
Complexity   Param 1       Return 1      Cyclo Vg 2       Total        4
LOC 9        eLOC 7        lLOC 4        Comment 0        Lines       10

    52: HTTP/1.1
    52: HTTP/1.0
    69: content-length
    85: transfer-encoding
    86: chunked
Function: com.hattmo.liquid.networking.ParserHTTP.recieveMessage
Parameters: (MessageDispatcher messageDispach)
Complexity   Param 1       Return 1      Cyclo Vg 18      Total       20
LOC 62       eLOC 46       lLOC 31       Comment 0        Lines       63

Class: com.hattmo.liquid.networking.ParserHTTP
Attributes   Publ 0        Prot 0        Private 2        Total        2
Methods      Publ 4        Prot 0        Private 0        Total        4
LOC 81       eLOC 60       lLOC 39       Comment 3        Lines       87

Package End: com.hattmo.liquid.networking
```}

== Code

#align(center)[#block(fill: rgb(220,220,220), radius:4pt, inset: 8pt )[#code]]

== RSM Command

#align(center)[#block(fill: rgb(220,220,220), radius:4pt, inset: 8pt )[#command]]

== Report

#align(center)[#block(fill: rgb(220,220,220), radius:4pt, inset: 8pt )[#report]]

== Analysis

=== Complexity

The `recieveMessage` method show a high level of complexity. With a combined score of 20.
Most of the influence of that score is derived from the cyclomatic complexity.  Becuase
it is parsing code there are multiple loops and branches to account for all the different
aspects of the HTTP request being parsed.  The logic is complex and can be a source of
bugs that are hard to isolate if all complexity is in one function.

=== Lines of Code

The number of lines of code in `recieveMessage` is also very high. It has 46 effective
lines of code which is beyond the reccomended lines of code under most style guides.
The function does multiple separate things that could be split into multiple functions

#pagebreak()

= Part 2:

A measure for code portability is the Effort Ratio Metric @portability.
#align(center)[#text(size:14pt)[#block()[$M_"port" (p)=1−frac(C_"port" (p),C_"new" (p))$]]]
- $C_"port" (p)$: Effort required to adapt code to a new platform
- $C_"new" (p)$: Effort to rewrite from scratch based on:
    - Platform-specific API usage density
    - Non-standard dependencies
    - Architecture specific operations

The RSM metrics directly relate to portability analysis in the following ways:
- Complexity: The greater the complexity the more likely there is difficult to decouple platform specific apis.
- Function Parameters: Excessive parameters could infer platform specific interfaces
- LOC: High LOC counts could suggest platform specific verbosity
- Comment Density: Every comment could require platform specific changes and updates.

#bibliography("bib.yml", full: true)
