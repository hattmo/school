#set page(
	paper: "us-letter",
	numbering: "1"
)

#set text(
	font: "Times New Roman"
)

#align(center)[
	#text(20pt)[
		CSE 566 - Homework \#1 Lean Software Development
	]
	#linebreak()
	#text(16pt)[
		Matthew Howard
	]
]

= Part A

The hypothetical situation for this homework is a software development company with a scrum master and a handful of developers as seen in @vsm.
The company has outsourced its QA testing to an external company to gain efficiency.
There is a significant amount of overhead involving the transfer of the code to and from the QA company, thus there is opportunity for improvement.

#figure(
	image("vsm.png"),
	caption: [Value Stream Map],
)<vsm>


= Part B

There are three areas that would be considered "Lean Waste" based on Lean Software Development best practice.
The three areas are:
- Waiting for QA to start work (Waiting)
- Receiving the QA report (Transportation)
- Redundant and slow regression testing (Over processing)
Each of these wastes have been identified in @vsmu. In order to reduce waiting for QA to start, 
there could be a pull approach that QA starts its work immediately on completion of a feature in an automated way.
To reduce the time to receive the QA report, the report can be delivered digitally and in a format that can trigger notifications etc.
Additionally the third waste can be addressed by setting up regression testing to trigger automatically via CI/CD when the QA report is completed.
By reducing the physical exchange of information and adding automation efficiency can be found.


#figure(
	image("vsmu.png"),
	caption: [Value Stream Map],
)<vsmu>


#bibliography(
	"bib.yml",
	full: true
)
