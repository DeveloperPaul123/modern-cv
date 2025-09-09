#import "@local/modern-cv:0.9.0": *

#fa-version("6")

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

#justified-header("Modern CV", "A modern curriculum vitae template")

#secondary-justified-header("Created by", "DeveloperPaul123")

#github-link("DeveloperPaul123/modern-cv")
#linkedin-icon
#github-icon
#twitter-icon
#google-scholar-icon
#orcid-icon
#phone-icon
#email-icon
#birth-icon
#homepage-icon
#website-icon
#gitlab-icon
#bitbucket-icon

#square(size: 1em, fill: color-darkgray)
#square(size: 1em, fill: color-darknight)
#square(size: 1em, fill: color-gray)
#square(size: 1em, fill: default-accent-color)
#square(size: 1em, fill: default-location-color)
