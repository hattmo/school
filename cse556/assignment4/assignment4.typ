#set page(
	paper: "us-letter",
	numbering: "1",
	margin: 0.5in
)

#set text(
	font: "Times New Roman"
)


#align(center)[
	#text(20pt)[CSE 566 - Homework \#4 Risk Factor Analysis]
	#linebreak()
	#text(16pt)[Matthew Howard]
]


= Part 1: Hypothetical Scenario and Risk Analysis

== Background

*DesertMedTech* (Phoenix, Arizona): A mid-sized company specializing in clound enabled medical devices, employing Agile methodologies for rapid development. DesertMedTech uses Scrum with 2-week sprints and emphasizes face-to-face collaboration. The team consists of 25 engineers focused on innovative healthcare solutions.

*CodeCrafters Ukraine* (Lviv, Ukraine): A large software development firm with over 300 developers, experienced in healthcare software and compliance with GDPR and HIPAA standards. CodeCrafters Ukraine excels in distributed software development (DSD) and frequently collaborates across time zones.

*Project*: The two companies are collaborating on a wearable device for monitoring cardiac health, integrated with a cloud-based analytics platform. DesertMedTech is responsible for hardware design and cloud integration, while CodeCrafters Ukraine develops the firmware and web-based patient portal.

== Selected Risks
#table(
	columns: (1fr,2fr),
	align: (left,left),
	inset: 5pt,
	fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
	stroke: rgb("21222C"),
	[*Requirement Elicitation* #linebreak() Unclear Requirements in Multiple Development Sites],[Miscommunication regarding "real-time data synchronization" due to geographic separation and differing Agile practices.],
	[*Objective Statement* #linebreak() Ambiguity in Objective Meaning Due to Cultural Differences],["Data security" priorities differ: DesertMedTech emphasizes HIPAA compliance, while CodeCrafters Ukraine focuses on GDPR standards.],
	[*Design* #linebreak() Design Inconsistency],[DesertMedTech's cloud systems require high computational power, conflicting with CodeCrafters Ukraine's lightweight firmware design for wearables.],
	[*Coding* #linebreak() Lack of Coordination],[Time zone differences delay code reviews, leading to integration challenges during paired programming sessions.],
	[*Testing* #linebreak() Unavailability of Real Testing Data],[Privacy regulations restrict access to patient datasets for cross-border testing, complicating quality assurance.],
	[*Release and Deployment* #linebreak() Difference in Agile Practices at Sites],[DesertMedTech uses Jira for sprint tracking, while CodeCrafters Ukraine relies on Trello, causing misalignment in workflows.],
	[*Project Management* #linebreak() Exceeded Project Time],[Onboarding delays arise due to CodeCrafters Ukraine's unfamiliarity with FDA compliance requirements.],
	[*Communication* #linebreak() Misinterpretation of Message],[Ambiguous Slack messages regarding "critical bug fixes" lead to conflicting priorities between teams.],
	[*Technology-Based* #linebreak() Improper Utilization of Tools],[Inadequate training on shared CI/CD tools results in frequent build failures.],
	[*External Stakeholder* #linebreak() Dependency on Third Party],[A subcontractor hired by CodeCrafters Ukraine delivers firmware updates incompatible with DesertMedTech's API specifications.],
	[*Group Awareness* #linebreak() Lack of Trust Between Onshore/Offshore Teams],[Perceived disparities in code quality create mistrust between the U.S. and Ukrainian teams.]
)

= Part 2: Mitigation Strategies



#table(
	columns: (auto,auto),
	align: (left,left),
	inset: 5pt,
	fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
	stroke: rgb("21222C"),
	table.header([*Risk Category*],[*Mitigation Strategy*]),
	[Requirement Elicitation],[Organize biweekly virtual workshops using collaborative tools like Miro for requirement mapping.],
	[Objective Statement],[Develop a shared glossary of terms approved by both teams to ensure clarity in objectives.],
	[Design],[Use centralized design documentation tools like Confluence to synchronize design changes across teams.],
	[Coding],[Schedule overlapping work hours (e.g., 6–8 AM MST / 4–6 PM UTC+2) for real-time collaboration on code reviews.],
	[Testing],[Implement synthetic data generators compliant with HIPAA and GDPR for testing purposes.],
	[Release and Deployment],[Standardize project management tools across both teams (e.g., switch both teams to Jira).],
	[Project Management],[Assign a dedicated liaison familiar with FDA regulations to streamline onboarding processes for CodeCrafters Ukraine.],
	[Communication],[Replace instant message chains with structured collaboration platforms like Confluence or Microsoft Teams for clear messaging and follow-ups.],
	[Technology-Based],[Provide comprehensive training sessions on CI/CD tools for both teams before project initiation.],
	[External Stakeholder],[Enforce API contracts using Swagger documentation and automated compatibility checks during development cycles.],
	[Group Awareness],[Conduct monthly virtual team-building activities to foster trust and understanding between teams.],
)


#bibliography(
	"bib.bib",
	full: true
)
