

#let init(Title, Name, Class, Content, Abstract: "") = {

  let last_name = Name.split(" ").at(-1)
  let short_class = Class.split(" ").at(-1).slice(1,-1)
  show heading: it => [
    #set align(center)
    #set text(size: 12pt, weight: "light")
    #block(smallcaps(it.body),spacing: 2em)
  ]

  set par(leading: 2em, spacing: 2em, first-line-indent: (all: true, amount: 1.5em))
  set page(
    paper: "us-letter",
    numbering: "i",
    header: align(right)[
      #last_name\_#short_class
    ]
  )

  set text(
    font: "Times New Roman",
    size: 12pt
  )

  // place(center + horizon)[
    align(center)[
      #linebreak()
      #linebreak()
      #Title
      #linebreak()
      By
      #linebreak()
      #Name
      #linebreak()
      #linebreak()
      #Class
      #linebreak()
      #linebreak()
      #let today = datetime.today()
      #today.display("[day] [month repr:long] [year]")
    ]
  // ]

  place(center + bottom)[
    #align(center)[
      Air University Global College of Professional Military Education
      #linebreak()
      Maxwell AFB, Alabama
      #linebreak()
      #linebreak()
      #linebreak()
    ]
  ]
  pagebreak()
  if Abstract != "" {
    align(center,"ABSTRACT")
    Abstract
    pagebreak()
  }

  set page(numbering: "1")
  counter(page).update(1)
  Content
  set bibliography(title: "Bibliography", style: "chicago-author-date")
}

#let cite = {}
