#import "@local/modern-cv:0.9.0": *

// setup the document like we do for the resume
#let font = "Source Sans 3"
#set text(font: font, size: 11pt, fill: color-darkgray, fallback: true)

#set page(
  paper: "a4",
  margin: (left: 15mm, right: 15mm, top: 10mm, bottom: 10mm),
  footer: [],
  footer-descent: 0pt,
)

// set paragraph spacing
#set par(spacing: 0.75em, justify: true)

#set heading(numbering: none, outlined: false)

#show heading.where(level: 1): it => [

  #set block(above: 1em, below: 1em)
  #set text(size: 16pt, weight: "regular")

  #align(left)[
    #let color = if colored-headers {
      accent-color
    } else {
      color-darkgray
    }
    #text[#strong[#text(color)[#it.body.text]]]
    #box(width: 1fr, line(length: 100%))
  ]

]

#show heading.where(level: 2): it => {
  set text(color-darkgray, size: 12pt, style: "normal", weight: "bold")
  it.body
}

#show heading.where(level: 3): it => {
  set text(size: 10pt, weight: "regular")
  smallcaps[#it.body]
}

// test the resume functions

#resume-item("Education")

#resume-entry(
  title: "BSc Computer Science",
  location: "Example City",
  date: "2019 - 2022",
  description: "Achieved acaademic honors and awards.",
)

// resume-entry also support omitting the date and description
#resume-entry(title: "Title", location: "Location")

#resume-certification("Certified Scrum Master (CSM)", "Jan 2022")

#resume-skill-item("Programming", (strong["C++"], "Python", "Java"))

#resume-gpa("3.5", "4.0")
