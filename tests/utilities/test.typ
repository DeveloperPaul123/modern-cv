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

#show heading.where(level: 2): it => {
  set text(colors.darkgray, size: 12pt, style: "normal", weight: "bold")
  it.body
}

#show heading.where(level: 3): it => {
  set text(size: 10pt, weight: "regular")
  smallcaps[#it.body]
}

#justified-header("Modern CV", "A modern curriculum vitae template")

#secondary-justified-header("Created by", "ptsouchlos")

#github-link("ptsouchlos/modern-cv")
#icons.linkedin
#icons.github
#icons.twitter
#icons.google-scholar
#icons.orcid
#icons.phone
#icons.email
#icons.birth
#icons.homepage
#icons.website
#icons.gitlab
#icons.bitbucket

#square(size: 1em, fill: colors.darkgray)
#square(size: 1em, fill: colors.darknight)
#square(size: 1em, fill: colors.gray)
#square(size: 1em, fill: colors.default-accent)
#square(size: 1em, fill: colors.default-location)
