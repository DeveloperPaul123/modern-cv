#import "colors.typ"
#import "helpers.typ"
#import "icons.typ"

#let __footer(
  author,
  language,
  date,
  lang_data,
  use-smallcaps: true,
) = {
  set text(fill: gray, size: 8pt)
  helpers.justify-align-3[
    #helpers.apply-smallcaps(date, use-smallcaps)
  ][
    #helpers.apply-smallcaps(
      {
        let name = helpers.format-author-name(author, language)
        name + " · " + helpers.linguify("cover-letter", from: lang_data)
      },
      use-smallcaps,
    )
  ][
    #context {
      counter(page).display()
    }
  ]
}

/// Default signature for the cover letter template.
/// - lang-data (dictionary): Structure that contains all the language data. Used with `linguify`
/// - language (string): The language of the cover letter.
/// - author (string): The author of the cover letter.
/// - alignment (alignment): Alignment of the signature.
/// - padding (dictionary): Padding of the signature.
#let __default-signature(lang-data, language, author, alignment, padding) = {
  align(alignment, pad(..padding)[
    #text(weight: "light")[#helpers.linguify("sincerely", from: lang-data)#if (
        language != "de"
      ) [#sym.comma]] \
    #if ("signature" in author) {
      author.signature
    } \
    #text(weight: "bold")[#author.firstname #author.lastname]
  ])
}

/// Default closing for the cover letter template.
/// - lang-data (dictionary): Structure that contains all the language data. Used with `linguify`
#let __default-closing(lang-data) = {
  align(bottom)[
    #text(weight: "light", style: "italic")[
      #helpers.linguify(
        "attached",
        from: lang-data,
      )#sym.colon #helpers.linguify(
        "curriculum-vitae",
        from: lang-data,
      )]
  ]
}

#let __default-par = (spacing: 0.75em, justify: true)

/// Cover letter template that is inspired by the Awesome CV Latex template by posquit0. This template can loosely be considered a port of the original Latex template.
/// This coverletter template is designed to be used with the resume template.
/// - author (dictionary): Structure that takes in all the author's information. The following fields are required: firstname, lastname, positions. The following fields are used if available: email, phone, github, linkedin, orcid, address, website, custom. The `custom` field is an array of additional entries with the following fields: text (string, required), icon (string, optional Font Awesome icon name), link (string, optional).
/// - profile-picture (image): The profile picture of the author. This will be cropped to a circle and should be square in nature.
/// - contact-items-separator (content): Separator to use between the "contact" items in the header of the coverletter. This includes items like your email, website, Github account, phone number and so on. The default is blank spacing.
/// - contact-items-inset (dictionary): Gap between contact item icon and contact item text.
/// - heading-padding (dictionary): Padding of the salutation line.
/// - signature-padding (dictionary): Padding of the signature.
/// - signature-alignment (alignment): Alignment of the signature.
/// - par-spacing (length): Spacing between paragraphs of the letter content.
/// - date (datetime | string): The date the cover letter was created. Defaults to today, formatted per `language`. Pass a `str` to bypass locale formatting entirely.
/// - accent-color (color): The accent color of the cover letter
/// - language (string): The language of the cover letter, defaults to "en". See lang.toml for available languages
/// - margins (dictionary): The margin values for the cover letter. Note: when show-footer is true, 10mm is added to the bottom margin to accommodate the footer.
/// - font (array): The font families of the cover letter
/// - header-font (array): The font families of the cover letter header
/// - show-footer (boolean): Whether to show the footer or not
/// - signaure (content): The signature of the cover letter. You can set this to `none` to show the default signature or remove it completely.
/// - closing (content): The closing of the cover letter. This defaults to "Attached Curriculum Vitae". You can set this to `none` to show the default closing or remove it completely.
/// - use-smallcaps (boolean): Whether to use small caps formatting throughout the template
/// - show-address-icon (boolean): Whether to show the address icon
/// - description (str | none): The PDF description
/// - keywords (array | str): The PDF keywords
/// - body (content): The body of the cover letter
#let coverletter(
  author: (:),
  profile-picture: image,
  contact-items-separator: box(width: 6pt, align(center, sym.bar.v)),
  contact-items-inset: (:),
  heading-padding: (above: 2em, below: 1em),
  signature-padding: (top: 1em),
  signature-alignment: left,
  par-spacing: 1.5em,
  date: datetime.today(),
  accent-color: colors.default-accent,
  language: "en",
  font: "Source Sans 3",
  header-font: "Roboto",
  show-footer: true,
  signature: none,
  closing: none,
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

  // language data
  let lang_data = toml("lang.toml")
  let date = helpers.format-date(date, language)

  if signature == none {
    signature = __default-signature(
      lang_data,
      language,
      author,
      signature-alignment,
      signature-padding,
    )
  }

  if closing == none {
    closing = __default-closing(lang_data)
  }

  let desc = if description == none {
    (
      helpers.linguify("cover-letter", lang: language, from: lang_data)
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
      title: helpers.linguify("cover-letter", lang: language, from: lang_data),
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
      date,
      lang_data,
      use-smallcaps: use-smallcaps,
    )] else [],
    footer-descent: 35%,
  )

  // set paragraph spacing
  set par(..__default-par)

  set heading(numbering: none, outlined: false)

  show heading: it => block(..heading-padding)[
    #set text(size: 16pt, weight: "regular")

    #align(left)[
      #text[#strong[#text(accent-color)[#it.body]]]
      #box(width: 1fr, line(length: 100%))
    ]
  ]

  let name = {
    align(right)[
      #pad(bottom: 5pt)[
        #block[
          #set text(size: 32pt, style: "normal", font: header-font)
          #if language == "zh" or language == "ja" [
            #text(accent-color, weight: "bold")[#author.lastname]#text(
              weight: "bold",
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
    align(right)[
      #helpers.apply-smallcaps(
        author.positions.join(text[#"  "#sym.dot.c#"  "]),
        use-smallcaps,
      )
    ]
  }

  let address = {
    set text(size: 9pt, weight: "bold", fill: colors.gray)
    align(right)[
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

  let contacts = {
    set text(size: 8pt, weight: "light", style: "normal")

    let items = helpers.format-contact-items(author)
    align(right, items.join(contact-items-separator))
  }

  let letter-heading = {
    grid(
      columns: (1fr, 2fr),
      rows: 100pt,
      align(left + horizon)[
        #block(
          clip: true,
          stroke: 0pt,
          radius: 2cm,
          width: 4cm,
          height: 4cm,
          profile-picture,
        )
      ],
      [
        #name
        #positions
        #address
        #contacts
      ],
    )
  }

  // actual content
  letter-heading
  {
    set par(spacing: par-spacing)
    set text(weight: "light")
    body
  }
  signature
  closing
}

/// Cover letter heading that takes in the information for the hiring company and formats it properly.
/// - entity-info (content): The information of the hiring entity including the company name, the target (who's attention to), street address, and city
/// - date (datetime | string): The date the letter was written. Defaults to today, formatted per `language`. Pass a `str` to bypass locale formatting entirely.
/// - language (string): The language used to format `date`, defaults to "en". This is independent from `coverletter`'s `language` argument since `hiring-entity-info` is called separately — pass the same value you gave `coverletter.with(language: ...)`.
#let hiring-entity-info(
  entity-info: (:),
  date: datetime.today(),
  language: "en",
  use-smallcaps: true,
) = {
  let date = helpers.format-date(date, language)
  set par(leading: 1em, ..__default-par)
  pad(top: 1.5em, bottom: 1.5em)[
    #helpers.justify-align[
      #text(weight: "bold", size: 12pt)[#entity-info.target]
    ][
      #text(weight: "light", style: "italic", size: 9pt)[#date]
    ]

    #pad(top: 0.65em, bottom: 0.65em)[
      #text(weight: "regular", fill: colors.gray, size: 9pt)[
        #helpers.apply-smallcaps(entity-info.name, use-smallcaps) \
        #entity-info.street-address \
        #entity-info.city \
      ]
    ]
  ]
}

/// Letter heading for a given job position and addressee.
/// - job-position (string): The job position you are applying for
/// - addressee (string): The person you are addressing the letter to
/// - dear (string): optional field for redefining the "dear" variable
/// - padding (dictionary): Padding of the heading line
#let letter-heading(
  job-position: "",
  addressee: "",
  dear: "",
  padding: (top: 1em, bottom: 1em),
) = {
  set par(..__default-par)
  let lang_data = toml("lang.toml")

  // TODO: Make this adaptable to content
  underline(evade: false, stroke: 0.5pt, offset: 0.3em)[
    #text(weight: "bold", size: 12pt)[#helpers.linguify(
        "letter-position-pretext",
        from: lang_data,
      ) #job-position]
  ]
  pad(..padding)[
    #text(weight: "light", fill: colors.gray)[
      #if dear == "" [
        #helpers.linguify("dear", from: lang_data)
      ] else [
        #dear
      ]
      #addressee,
    ]
  ]
}
