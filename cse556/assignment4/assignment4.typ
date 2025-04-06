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

*DesertMedTech* (Phoenix, Arizona): A mid-sized company focused on cloud-enabled medical devices. The team employs Agile methodologies, specifically Scrum, with two-week sprints to ensure rapid development. Collaboration is a priority, with face-to-face interactions being emphasized. The company has a team of 25 engineers dedicated to creating innovative healthcare solutions.

*CodeCrafters Ukraine* (Lviv, Ukraine): A large software development firm with over 300 developers. The company specializes in healthcare software and adheres to GDPR and HIPAA compliance standards. CodeCrafters Ukraine has extensive experience in distributed software development and excels in cross-time-zone collaboration.

*Project*: The two companies are working together to develop a wearable cardiac health monitoring device that integrates with a cloud-based analytics platform. DesertMedTech is handling hardware design and cloud integration, while CodeCrafters Ukraine is responsible for firmware development and the web-based patient portal.

= Part 1: Risk Analysis

#table(
    columns: (1fr, 2fr),
    align: (left, left),
    inset: 5pt,
    fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
    stroke: rgb("21222C"),
    table.header([*Risk Category*],[*Identified Risk*]),

    [*Requirement Elicitation* #linebreak() Unclear Requirements in Multiple Development Sites],
    [Miscommunication about "real-time data synchronization" due to geographic separation and differing Agile practices.],

    [*Objective Statement* #linebreak() Ambiguity in Objective Meaning Due to Cultural Differences],
    ["Data security" priorities vary—DesertMedTech focuses on HIPAA compliance, while CodeCrafters Ukraine emphasizes GDPR standards.],

    [*Design* #linebreak() Design Inconsistency],
    [DesertMedTech's high-computation cloud systems conflict with CodeCrafters Ukraine's lightweight firmware requirements for wearables.],

    [*Coding* #linebreak() Lack of Coordination],
    [Time zone differences cause delays in code reviews, complicating integration during paired programming sessions.],

    [*Testing* #linebreak() Unavailability of Real Testing Data],
    [Privacy regulations restrict access to patient datasets for cross-border testing, making quality assurance more difficult.],

    [*Release and Deployment* #linebreak() Difference in Agile Practices at Sites],
    [DesertMedTech uses Jira for sprint tracking, while CodeCrafters Ukraine relies on Trello, leading to workflow misalignment.],

    [*Project Management* #linebreak() Exceeded Project Time],
    [Onboarding delays occur due to CodeCrafters Ukraine's unfamiliarity with FDA compliance requirements.],

    [*Communication* #linebreak() Misinterpretation of Message],
    [Ambiguous Slack messages about "critical bug fixes" result in conflicting priorities between teams.],

    [*Technology-Based Issues* #linebreak() Improper Utilization of Tools],
    [Insufficient training on shared CI/CD tools leads to frequent build failures.],

    [*External Stakeholder Dependency* #linebreak() Dependency on Third-Party],
    [A subcontractor hired by CodeCrafters Ukraine delivers firmware updates incompatible with DesertMedTech's API specifications.],

    [*Group Awareness* #linebreak() Lack of Trust Between Onshore/Offshore Teams],
    [Perceived disparities in code quality create mistrust between U.S.-based and Ukrainian teams.]
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
    [Hold biweekly virtual workshops using tools like Miro for collaborative requirement mapping.],

    [*Objective Statement* #linebreak() Ambiguity in Objective Meaning Due to Cultural Differences],
    [Create a shared glossary of terms reviewed and approved by both teams to ensure clarity in objectives.],

    [*Design* #linebreak() Design Inconsistency],
    [Adopt centralized design documentation tools like Confluence to keep design changes synchronized across teams.],

    [*Coding* #linebreak() Lack of Coordination],
    [Schedule overlapping work hours (e.g., 6–8 AM MST / 4–6 PM UTC+2) for real-time collaboration during code reviews.],

    [*Testing* #linebreak() Unavailability of Real Testing Data],
    [Use synthetic data generators that comply with both HIPAA and GDPR for testing purposes.],

    [*Release and Deployment* #linebreak() Difference in Agile Practices at Sites],
    [Standardize project management tools across teams (e.g., switch both teams to Jira).],

    [*Project Management* #linebreak() Exceeded Project Time],
    [Assign a liaison familiar with FDA regulations to streamline onboarding processes for CodeCrafters Ukraine.],

    [*Communication* #linebreak() Misinterpretation of Message],
    [Replace informal Slack threads with structured platforms like Confluence or Microsoft Teams for clearer messaging and follow-ups.],

    [*Technology-Based Issues* #linebreak() Improper Utilization of Tools],
    [Provide comprehensive training on CI/CD tools for both teams before starting the project.],

    [*External Stakeholder Dependency* #linebreak() Dependency on Third-Party],
    [Enforce API contracts using Swagger documentation and automated compatibility checks during development cycles.],

    [*Group Awareness* #linebreak() Lack of Trust Between Onshore/Offshore Teams],
    [Host monthly virtual team-building activities to foster trust and strengthen relationships between teams.]
)

#bibliography(
	"bib.bib",
	full: true
)
