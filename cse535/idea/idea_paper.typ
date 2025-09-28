#set document(author: "Oscar")

#set page(paper: "us-letter", margin: (rest: 0.75in))

#set text(
    font: "Times New Roman",
    size: 12pt
  )

#show heading.where(level: 1): it => align(center,text(
  font: "Arial",
  size: 18pt,
  weight: "bold",
  it
))

= Hello
#lorem(1000)
