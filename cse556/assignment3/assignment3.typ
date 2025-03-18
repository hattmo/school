#set page(
	paper: "us-letter",
	numbering: "1",
	margin: 0.5in
)

#set text(
	font: "Times New Roman"
)

#set par(first-line-indent: 0.5in)

#align(center)[
	#text(20pt)[
		CSE 566 - Homework \#3 COCOMO Calculation
	]
	#linebreak()
	#text(16pt)[
		Matthew Howard
	]
]

#par[The hypothetical software project for this assignment is CereBro, a smart home automation device that integrates
various household appliances and sensors to provide a seamless, user-friendly experience. The system can control
lighting, temperature, security systems, and entertainment devices, while also monitoring energy consumption and
providing real-time feedback to users. This software project falls under the embedded mode because it involves developing
software for a specific hardware platform with strict performance and reliability constraints.  These hardware devices are
small form factor and have limited environmental controls.  The customer will rely on this product to function without
intervention consistently for extended periods of time. The project size is estimated to be approximately 10,000 lines
of code. This includes the firmware for the microcontroller, the user interface, and the communication protocols.]

#align(center)[
	#table(
	columns: (auto,auto,auto),
	align: (horizon,horizon,left),
	inset: 5pt,
	fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
	stroke: rgb("21222C"),
	table.header([*Factor*],[*Rating*],align(center + horizon,[*Justification*])),

	[Required Reliability],[High],[The need for continuous operation and reliability in home automation],
	[Database Size],[Low],[The system primarily interacts with real-time sensor data],
	[Product Complexity],[Nominal],[Integration from multiple sensors and actuators],

	[Execution Time Constraint],[Nominal],[The system needs to respond quickly to user inputs],
	[Main Storage Constraint],[Low],[The system interacts with real-time data and does not require much persistent data],
	[Platform Volatility],[Low],[The system once installed, will remain on the hardware with no changes],
	[Computer Turnaround Time],[Nominal],[Developer testing will require access to physical devices post compilation],

	[Analyst Capability],[High],[The analysis team is well functioning and capable],
	[Applications Experience],[High],[The development team is familiar with the product line and has worked on similar projects in the past],
	[Programmer Capability],[High],[The developer team has worked together efficiently and produced quality results],
	[Platform Experience],[High],[The developers have focused on building software for other products in this product line and are familiar],
	[Programming Language and Tool Experience],[High],[This project uses the same programming language that has been used on all previous products in this product line],


	[Modern Programming Practices],[High],[This is a modern team using the latest best practices],
	[Use of Software Tools],[Very High],[The company has a full CI/CD pipeline and enterprise IDEs and VCS],
	[Required Development Schedule],[High],[This product needs to ship to meet time to market against our competitors],

	[Required reusability],[Very High],[To future proof for new auxiliary devices, code reuse is a must to enable interoperability],
	[Documentation match to life-cycle needs],[Nominal],[The product is not safety critical and thus does not require extra documentation],
	[Personnel continuity],[Nominal],[Turn over in the organization is not abnormal],
	[Multisite development],[Very Low],[All developers are collocated],
)]


#par[After running the calculator with the previously defined parameters the following results were produced. This product is estimated to take 26
person-months, with 3.7 people for 7.15 months.]

#table(
	columns: (auto,1fr,1fr,1fr,1fr,1fr,1fr,1fr,auto),
	table.cell(colspan: 9, align(center)[#text(size: 14pt)[*COCOMO RESULTS for realistic case CereBro*]]),
	[*Mode*],[*A Variable*],[*B Variable*],[*C Variable*],[*D Variable*],[*KLOC*],[*Effort*],[*Duration*],[*Staffing*],
	[Embedded],[1.683],[1.2],[2.5],[0.32],[10],[26.681],[7.15],[3.731], 
)

The worst case scenario with all personnel and project attributes set to the worst possible settings is seen below.

#table(
	columns: (auto,1fr,1fr,1fr,1fr,1fr,1fr,1fr,auto),
	table.cell(colspan: 9, align(center)[#text(size: 14pt)[*COCOMO RESULTS for worst case CereBro (Worst Case)*]]),
	[*Mode*],[*A Variable*],[*B Variable*],[*C Variable*],[*D Variable*],[*KLOC*],[*Effort*],[*Duration*],[*Staffing*],
	[Embedded],[45.399],[1.2],[2.5],[0.32],[10],[719.538],[20.521],[35.064], 
)

The best case scenario with all personnel and project attributes set to the best possible settings is seen below.

#table(
	columns: (auto,1fr,1fr,1fr,1fr,1fr,1fr,1fr,auto),
	table.cell(colspan: 9, align(center)[#text(size: 14pt)[*COCOMO RESULTS CereBro (Best Case)*]]),
	[*Mode*],[*A Variable*],[*B Variable*],[*C Variable*],[*D Variable*],[*KLOC*],[*Effort*],[*Duration*],[*Staffing*],
	[Embedded],[0.987],[1.2],[2.5],[0.32],[10],[15.652],[6.028],[2.596], 
)


#bibliography(
	"bib.yml",
	full: true
)
