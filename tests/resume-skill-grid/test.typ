#import "@local/modern-cv:0.11.0": *

// setup the document like we do for the resume
#let font = "Source Sans 3"
#set text(font: font, size: 11pt, fill: colors.darkgray, fallback: true)

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
      colors.darkgray
    }
    #text[#strong[#text(color)[#it.body.text]]]
    #box(width: 1fr, line(length: 100%))
  ]

]

// test the skill grid functions

#resume-skill-grid(
  categories-with-values: (
    "Languages": ("C++", "Python", strong["Rust"], "Java"),
    "Frameworks": ("React", "Node.js", "Django"),
    "Tools": ("Git", "Docker", "Kubernetes", "Linux"),
  ),
)

// standalone building blocks used by resume-skill-item/resume-skill-grid
#resume-skill-category("Databases")
#linebreak()
#resume-skill-values(("PostgreSQL", "MongoDB", "Redis"))
