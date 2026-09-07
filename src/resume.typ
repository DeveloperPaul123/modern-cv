#import "colors.typ"
#import "helpers.typ"
#import "icons.typ"

#let __footer(author, language, lang_data, date, use-smallcaps: true) = {
  set text(fill: gray, size: 8pt)
  helpers.justify-align-3[
    #helpers.apply-smallcaps(date, use-smallcaps)
  ][
    #helpers.apply-smallcaps(
      {
        let name = helpers.format-author-name(author, language)
        name + " · " + helpers.linguify("resume", from: lang_data)
      },
      use-smallcaps,
    )
  ][
    #context {
      counter(page).display()
    }
  ]
}

/// Right section for the justified headers
/// - body (content): The body of the right header
#let secondary-right-header(body) = {
  set text(size: 11pt, weight: "medium")
  body
}

/// Right section of a tertiaty headers.
/// - body (content): The body of the right header
#let tertiary-right-header(body) = {
  set text(weight: "light", size: 9pt)
  body
}

/// Justified header that takes a primary section and a secondary section. The primary section is on the left and the secondary section is on the right.
/// - primary (content): The primary section of the header
/// - secondary (content): The secondary section of the header
#let justified-header(primary, secondary) = {
  set block(above: 0.7em, below: 0.7em)
  pad[
    #helpers.justify-align[
      == #primary
    ][
      #secondary-right-header[#secondary]
    ]
  ]
}

/// Justified header that takes a primary section and a secondary section. The primary section is on the left and the secondary section is on the right. This is a smaller header compared to the `justified-header`.
/// - primary (content): The primary section of the header
/// - secondary (content): The secondary section of the header
#let secondary-justified-header(primary, secondary) = {
  helpers.justify-align[
    === #primary
  ][
    #tertiary-right-header[#secondary]
  ]
}

/// Resume template that is inspired by the Awesome CV Latex template by posquit0. This template can loosely be considered a port of the original Latex template.
///
/// The original template: https://github.com/posquit0/Awesome-CV
///
/// - author (dictionary): Structure that takes in all the author's information
/// - profile-picture (image): The profile picture of the author. This will be cropped to a circle and should be square in nature.
/// - profile-picture-diameter (length): The diameter of the profile picture.
/// - contact-items-separator (content): Separator to use between the "contact" items in the header of the resume. This includes items like your email, website, Github account, phone number and so on. The default is blank spacing.
/// - contact-items-inset (dictionary): Gap between contact item icon and contact item text.
/// - date (datetime | string): The date the resume was created. Defaults to today, formatted per `language`. Pass a `str` to bypass locale formatting entirely.
/// - accent-color (color): The accent color of the resume
/// - colored-headers (boolean): Whether the headers should be colored or not
/// - language (string): The language of the resume, defaults to "en". See lang.toml for available languages
/// - margins (dictionary): The margin values for the resume. Note: when show-footer is true, 10mm is added to the bottom margin to accommodate the footer.
/// - use-smallcaps (boolean): Whether to use small caps formatting throughout the template
/// - show-address-icon (boolean): Whether to show the address icon
/// - description (str | none): The PDF description
/// - keywords (array | str): The PDF keywords
/// - body (content): The body of the resume
/// -> none
#let resume(
  author: (:),
  profile-picture: image,
  profile-picture-diameter: 4cm,
  contact-items-separator: h(10pt),
  contact-items-inset: (left: 4pt),
  date: datetime.today(),
  accent-color: colors.default-accent,
  colored-headers: true,
  show-footer: true,
  language: "en",
  font: "Source Sans 3",
  header-font: "Roboto",
  paper-size: "a4",
  margins: (left: 15mm, right: 15mm, top: 10mm, bottom: 10mm),
  use-smallcaps: true,
  show-address-icon: false,
  description: none,
  keywords: (),
  body,
) = {
  if type(accent-color) == str {
    accent-color = rgb(accent-color)
  }

  let lang_data = toml("lang.toml")
  let date = helpers.format-date(date, language)

  let desc = if description == none {
    (
      helpers.linguify("resume", lang: language, from: lang_data)
        + " "
        + author.firstname
        + " "
        + author.lastname
    )
  } else {
    description
  }

  show: body => context {
    set document(
      author: author.firstname + " " + author.lastname,
      title: helpers.linguify("resume", lang: language, from: lang_data),
      description: desc,
      keywords: keywords,
    )
    body
  }

  set text(
    font: font,
    lang: language,
    size: 11pt,
    fill: colors.darkgray,
    fallback: true,
  )

  set page(
    paper: paper-size,
    margin: (
      left: margins.left,
      right: margins.right,
      top: margins.top,
      bottom: if show-footer { margins.bottom + 10mm } else { margins.bottom },
    ),
    footer: if show-footer [#__footer(
      author,
      language,
      lang_data,
      date,
      use-smallcaps: use-smallcaps,
    )] else [],
    footer-descent: 35%,
  )

  // set paragraph spacing
  set par(spacing: 0.75em, justify: true)

  set heading(numbering: none, outlined: false)

  show heading.where(level: 1): it => block(sticky: true)[
    #set text(size: 16pt, weight: "regular")
    #set align(left)
    #set block(above: 1em)
    #let color = if colored-headers {
      accent-color
    } else {
      colors.darkgray
    }
    #text[#strong[#text(color)[#it.body]]]
    #box(width: 1fr, line(length: 100%))
  ]

  show heading.where(level: 2): it => {
    set text(colors.darkgray, size: 12pt, style: "normal", weight: "bold")
    it.body
  }

  show heading.where(level: 3): it => {
    set text(size: 10pt, weight: "regular")
    helpers.apply-smallcaps(it.body, use-smallcaps)
  }

  let name = {
    align(center)[
      #pad(bottom: 5pt)[
        #block[
          #set text(size: 32pt, style: "normal", font: header-font)
          #if language == "zh" or language == "ja" [
            #text(accent-color, weight: "bold")[#author.lastname]#text(
              weight: "thin",
            )[#author.firstname]
          ] else [
            #text(accent-color, weight: "thin")[#author.firstname]
            #text(weight: "bold")[#author.lastname]
          ]
        ]
      ]
    ]
  }

  let positions = {
    set text(accent-color, size: 9pt, weight: "regular")
    align(center)[
      #helpers.apply-smallcaps(
        author.positions.join(text[#"  "#sym.dot.c#"  "]),
        use-smallcaps,
      )
    ]
  }

  let address = {
    set text(size: 9pt, weight: "regular")
    align(center)[
      #if ("address" in author) [
        #if show-address-icon [
          #helpers.contact-item(
            (
              icon: icons.address,
              text: text(author.address),
            ),
            inset: contact-items-inset,
          )
        ] else [
          #text(author.address)
        ]
      ]
    ]
  }

  // Contact section
  let contacts = {
    set box(height: 9pt)
    set text(size: 9pt, weight: "regular", style: "normal")

    let items = helpers.format-contact-items(
      author,
      item-inset: contact-items-inset,
    )
    align(center, items.join(contact-items-separator))
  }

  let header-content = [
    #name
    #positions
    #address
    #contacts
  ]

  if profile-picture != none {
    grid(
      columns: (1fr, auto),
      gutter: 10pt,
      align: horizon,
      header-content,
      block(
        clip: true,
        stroke: 0pt,
        radius: profile-picture-diameter / 2,
        width: profile-picture-diameter,
        height: profile-picture-diameter,
        profile-picture,
      ),
    )
  } else {
    header-content
  }

  body
}

/// The base item for resume entries.
/// This formats the item for the resume entries. Typically your body would be a bullet list of items. Could be your responsibilities at a company or your academic achievements in an educational background section.
/// - body (content): The body of the resume entry
#let resume-item(body) = {
  set text(size: 10pt, style: "normal", weight: "light", fill: colors.darknight)
  set block(above: 0.75em, below: 1.25em)
  set par(leading: 0.65em)
  block(above: 0.5em)[
    #body
  ]
}

/// The base item for resume entries. This formats the item for the resume entries. Typically your body would be a bullet list of items. Could be your responsibilities at a company or your academic achievements in an educational background section.
/// - title (string): The title of the resume entry
/// - location (string): The location of the resume entry
/// - date (string): The date of the resume entry, this can be a range (e.g. "Jan 2020 - Dec 2020")
/// - description (content): The body of the resume entry
/// - title-link (string): The link to use for the title (can be none)
/// - accent-color (color): Override the accent color of the resume-entry
/// - location-color (color): Override the default color of the "location" for a resume entry.
/// - spacing-above (length): Override the space above the resume entry block (default: 1em)
/// - spacing-below (length): Override the space below the resume entry block (default: 0.65em)
#let resume-entry(
  title: none,
  location: "",
  date: "",
  description: "",
  title-link: none,
  accent-color: colors.default-accent,
  location-color: colors.default-location,
  spacing-above: 1em,
  spacing-below: 0.65em,
) = {
  let title-content
  if type(title-link) == str {
    title-content = link(title-link)[#title]
  } else {
    title-content = title
  }
  block(above: spacing-above, below: spacing-below, sticky: true)[
    #pad[
      #justified-header(title-content, location)
      #if description != "" or date != "" [
        #secondary-justified-header(description, date)
      ]
    ]
  ]
}

/// Show cumulative GPA.
/// *Example:*
/// #example(`resume.resume-gpa("3.5", "4.0")`)
#let resume-gpa(numerator, denominator) = {
  set text(size: 12pt, style: "italic", weight: "light")
  text[Cumulative GPA: #box[#strong[#numerator] / #denominator]]
}

/// Show a certification in the resume.
/// *Example:*
/// #example(`resume.resume-certification("AWS Certified Solutions Architect - Associate", "Jan 2020")`)
/// - certification (content): The certification
/// - date (content): The date the certification was achieved
#let resume-certification(certification, date) = {
  justified-header(certification, date)
}

/// Styling for resume skill categories.
/// - category (string): The category
#let resume-skill-category(category) = {
  set text(size: 11pt, style: "normal", weight: "bold", hyphenate: false)
  category
}

/// Styling for resume skill values/items
/// - values (array): The skills to display
#let resume-skill-values(values) = {
  set text(size: 11pt, style: "normal", weight: "light")
  // This is a list so join by comma (,)
  values.join(", ")
}

/// Show a list of skills in the resume under a given category.
/// - category (string): The category of the skills
/// - items (list): The list of skills. This can be a list of strings but you can also emphasize certain skills by using the `strong` function.
#let resume-skill-item(category, items) = {
  set block(below: 0.65em)
  set pad(top: 2pt)

  pad[
    #grid(
      columns: (3fr, 8fr),
      gutter: 10pt,
      align: left + top,
      resume-skill-category(category), resume-skill-values(items),
    )
  ]
}

/// Show a grid of skill lists with each row corresponding to a category of skills, followed by the skills themselves. The dictionary given to this function should have the skill categories as the dictionary keys and the values should be an array of values for the corresponding key.
/// - categories-with-values (dictionary): key value pairs of skill categories and it's corresponding values (skills)
#let resume-skill-grid(categories-with-values: (:)) = {
  set block(below: 1.25em)
  set pad(top: 2pt)

  pad[
    #grid(
      columns: (auto, auto),
      gutter: 10pt,
      align: left + top,
      ..categories-with-values
        .pairs()
        .map(((key, value)) => (
          resume-skill-category(key),
          resume-skill-values(value),
        ))
        .flatten()
    )
  ]
}
