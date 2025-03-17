#set page(
	paper: "us-letter",
	numbering: "1",
	margin: 0.5in
)

#set text(
	font: "Times New Roman"
)

#align(center)[
	#text(18pt)[
		CSE 566 - Homework \#2 Agile Project Planning
	]
	#linebreak()
	#text(16pt)[
		Matthew Howard
	]
]

The image show below in @timeline is a timeline for the development of the project "FitTogether". FitTogether is a fitness app with a social aspect
that allows users to find partners, track goals and develop workout plans.  The project divides the development into 4 epics which encompass the 4 main features:
User Registration and Login, Goal Tracking, Partner matching, and Basic Workout Plans.  Additionally, dependent work needs to be completed to provision all the infrastructure
that will be used to host this application. To create this timeline I used Jira's cloud platform and created a new project for FitTogether.  Then created the 5 epics
including infrastructure. I broke the work down into smaller development and research tasks and created dependencies between the development tasks and the infrastructure.
After that, I created as many sprints and I needed to allocate enough work to complete all the items in the backlog.

#figure(
	image("timeline.png"),
	caption: [Jira Timeline],
)<timeline>


#bibliography(
	"bib.yml",
	full: true
)
