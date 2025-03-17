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

The hypothetical software project for this assignment is Cerebro, a smart home automation device that integrates
various household appliances and sensors to provide a seamless, user-friendly experience. The system can control
lighting, temperature, security systems, and entertainment devices, while alsomonitoring energy consumption and
providing real-time feedback to users.

#align(center)[
	#table(
	columns: (auto,auto,auto),
	inset: 10pt,
	align: horizon,
	table.header([*Factor*],[*Rating*],[*Justification*]),

	[Required Reliability],[High],[The need for continuous operation and reliability in home automation],
	[Database Size],[Low],[The system primarily interacts with real-time sensor data],
	[Product Complexity],[Medium],[Integration from multiple sensors and actuators],

	[Execution Time Constraint],[Medium],[The system needs to respond quickly to user inputs],
	[Main Storage Constraint],[],[],
	[Platform Volatility],[],[],
	[Computer Turnaround Time],[],[],

	[Analyst Capability],[],[],
	[Applications Experience],[],[],
	[Programmer Capability],[],[],
	[Platform Experience],[],[],
	[Programming Language and Tool Experience],[],[],


	[Modern Programming Practices],[],[],
	[Use of Software Tools],[],[],
	[Required Development Schedule],[],[],

	[Required reusability],[],[],
	[Documentation match to life-cycle needs],[],[],
	[Personnel continuity],[],[],
	[Multisite development],[],[],
)]


#pagebreak()

#bibliography(
	"bib.yml",
	full: true
)
