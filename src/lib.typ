#import "colors.typ"
#import "helpers.typ"
#import "icons.typ"
#import "coverletter.typ": coverletter, hiring-entity-info, letter-heading
#import "resume.typ": (
  justified-header, resume, resume-certification, resume-entry, resume-gpa,
  resume-item, resume-skill-category, resume-skill-grid, resume-skill-item,
  resume-skill-values, secondary-justified-header, secondary-right-header,
  tertiary-right-header,
)

/// Show a link with an icon, specifically for Github projects
/// *Example*
/// #example(`resume.github-link("ptsouchlos/awesome-resume")`)
/// - github-path (string): The path to the Github project (e.g. "ptsouchlos/awesome-resume")
/// -> none
#let github-link(github-path) = {
  set box(height: 11pt)

  align(right + horizon)[
    #icons.fa-icon("github", fill: colors.darkgray) #h(2pt) #link(
      "https://github.com/" + github-path,
      github-path,
    )
  ]
}
