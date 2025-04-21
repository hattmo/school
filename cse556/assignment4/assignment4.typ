#set page(
    paper: "us-letter",
    numbering: "1",
    margin: 0.5in
)

#set text(
    font: "Times New Roman"
)

#align(center)[
    #text(20pt)[CSE 566 - Homework #4: Risk Factor Analysis]
    #linebreak()
    #text(16pt)[Matthew Howard]
]


= Background

*DesertMedTech* (Arizona): A mid-sized company focused on cloud-enabled medical devices. The team employs Agile methodologies, specifically Scrum, with two-week sprints to ensure rapid development. Face-to-face interactions are being emphasized. The company has a team of 25 engineers dedicated to creating innovative healthcare solutions.

*CodeCrafters* (Ukraine): A large software development firm with over 300 developers. The company specializes in healthcare software and adheres to GDPR compliance standards. CodeCrafters has some experience in distributed software development but excels in cross-time-zone collaboration.

*Project*: The two companies are working together to develop a cardiac health monitoring device that you wear on your wrist. It also integrates with a cloud-based analytics platform. DesertMedTech is handling hardware design and cloud integration, while CodeCrafters is responsible for firmware development and the web-based patient portal.

= Part 1: Risk Analysis

#table(
    columns: (1fr, 2fr),
    align: (left, left),
    inset: 5pt,
    fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
    stroke: rgb("21222C"),
    table.header([*Risk Category*],[*Identified Risk*]),

    [*Requirement Elicitation* #linebreak() Unclear Requirements in Multiple Development Sites],
    [Miscommunication about "real-time data synchronization" due to geographic separation],

    [*Objective Statement* #linebreak() Ambiguity in Objective Meaning Due to Cultural Differences],
    ["Data security" priorities vary. DesertMedTech focuses on HIPAA, while CodeCrafters Ukraine focuses GDPR standards.],

    [*Design* #linebreak() Design Inconsistency],
    [DesertMedTech's high-computation cloud systems create challenges with CodeCrafters Ukraine's lightweight firmware for wearables.],

    [*Coding* #linebreak() Lack of Coordination],
    [Time zone differences cause delays in code reviews, complicating rapid integration during paired programming sessions.],

    [*Testing* #linebreak() Unavailability of Real Testing Data],
    [Privacy regulations restrict access to patient datasets for cross-border testing, making quality assurance more difficult.],

    [*Release and Deployment* #linebreak() Difference in Agile Practices at Sites],
    [DesertMedTech uses one system for sprint tracking, while CodeCrafters Ukraine uses another, leading to workflow misalignment.],

    [*Project Management* #linebreak() Exceeded Project Time],
    [Onboarding delays occur due to CodeCrafters Ukraine's unfamiliarity with FDA compliance requirements.],

    [*Communication* #linebreak() Misinterpretation of Message],
    [Ambiguous Slack messages result in conflicting priorities between teams.],

    [*Technology-Based Issues* #linebreak() Improper Utilization of Tools],
    [Insufficient training on shared CI/CD tools leads to frequent build failures.],

    [*External Stakeholder Dependency* #linebreak() Dependency on Third-Party],
    [A subcontractor hired by CodeCrafters Ukraine delivers firmware updates incompatible with DesertMedTech's API specifications.],

    [*Group Awareness* #linebreak() Lack of Trust Between Onshore/Offshore Teams],
    [Perceived disparities in code quality and style create mistrust between U.S.-based and Ukrainian teams.]
)

= Part 2: Mitigation Strategies

#table(
    columns: (1fr, 2fr),
    align: (left, left),
    inset: 5pt,
    fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
    stroke: rgb("21222C"),
    table.header([*Risk Category*],[*Mitigation Strategy*]),

    [*Requirement Elicitation* #linebreak() Unclear Requirements in Multiple Development Sites],
    [Hold biweekly virtual syncs using tools like Miro for clarifying requirements.],

    [*Objective Statement* #linebreak() Ambiguity in Objective Meaning Due to Cultural Differences],
    [Create a shared glossary of terms reviewed and approved by both teams to bridge cultural gaps in understanding.],

    [*Design* #linebreak() Design Inconsistency],
    [Adopt a centralized design documentation tool to keep design changes the same across both teams.],

    [*Coding* #linebreak() Lack of Coordination],
    [Schedule overlapping work hours (one works nights the other early morning) for real-time collaboration during code reviews.],

    [*Testing* #linebreak() Unavailability of Real Testing Data],
    [Use synthetic data generators that comply with both HIPAA and GDPR for testing purposes and avioding legal hurdles.],

    [*Release and Deployment* #linebreak() Difference in Agile Practices at Sites],
    [Standardize project management tools across teams such as Jira.],

    [*Project Management* #linebreak() Exceeded Project Time],
    [Assign a liaison familiar with FDA regulations to Ukraine to streamline compliance for CodeCrafters.],

    [*Communication* #linebreak() Misinterpretation of Message],
    [Replace informal threads in Slack with a structured platform like Confluence for clearer messaging and follow-ups.],

    [*Technology-Based Issues* #linebreak() Improper Utilization of Tools],
    [Provide comprehensive training on CI/CD tools for both teams before starting the project.],

    [*External Stakeholder Dependency* #linebreak() Dependency on Third-Party],
    [Enforce API contracts using Swagger docs and automated compatibility checks during development cycles.],

    [*Group Awareness* #linebreak() Lack of Trust Between Onshore/Offshore Teams],
    [Host monthly virtual team-building activities to foster trust and relationships building between teams.]
)

#bibliography(
	"bib.bib",
	full: true
)
