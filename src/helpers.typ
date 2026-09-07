#import "@preview/linguify:0.5.0": linguify
#import "colors.typ"
#import "icons.typ"

// Common helper functions
#let format-author-name(author, language) = {
  if language == "zh" or language == "ja" {
    str(author.lastname) + str(author.firstname)
  } else {
    str(author.firstname) + " " + str(author.lastname)
  }
}

// Locale-appropriate date display patterns, keyed by the same language
// codes used in lang.toml. See the `datetime.display()` docs for the
// pattern syntax: https://typst.app/docs/reference/foundations/datetime/#format
#let date-formats = (
  en: "[month repr:long] [day], [year]",
  de: "[day].[month].[year]",
  gr: "[day]/[month]/[year]",
  pt: "[day]/[month]/[year]",
  sp: "[day]/[month]/[year]",
  fr: "[day]/[month]/[year]",
  ru: "[day].[month].[year]",
  zh: "[year]年[month]月[day]日",
  it: "[day]/[month]/[year]",
  nl: "[day]-[month]-[year]",
  sv: "[year]-[month]-[day]",
)

// Formats `date` per the given language if it is a `datetime`. A `date`
// that is already a `str` (e.g. an explicit caller override, or a
// non-standard date range like "2023 - Present") is passed through
// unchanged so existing callers don't break.
#let format-date(date, language) = {
  if type(date) == datetime {
    date.display(date-formats.at(language, default: date-formats.en))
  } else {
    date
  }
}

#let apply-smallcaps(content, use-smallcaps) = {
  if use-smallcaps {
    smallcaps(content)
  } else {
    content
  }
}

// layout utility
#let justify-align(left_body, right_body) = {
  block[
    #left_body
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

#let justify-align-3(left_body, mid_body, right_body) = {
  block[
    #box(width: 1fr)[
      #align(left)[
        #left_body
      ]
    ]
    #box(width: 1fr)[
      #align(center)[
        #mid_body
      ]
    ]
    #box(width: 1fr)[
      #align(right)[
        #right_body
      ]
    ]
  ]
}

// Helper for contact items in the header.
// - item (dictionary): The contact item with the following fields: text (string, required), icon (box, optional), link (string, optional)
// - link-prefix (string): The prefix to use for the link (e.g. "mailto:")
// - inset (dictionary): Inset of each individual contact item
#let contact-item(item, link-prefix: "", inset: (:)) = {
  box[
    #set align(bottom)
    #if ("icon" in item) {
      [#item.icon]
    }
    // Then modify the selection to use the constant:
    #box(inset: inset)[
      #if ("link" in item) and type(item.link) == str {
        link(link-prefix + item.link)[#item.text]
      } else {
        item.text
      }
    ]
  ]
}

/// Format contact items with the respective Font Awesome icon and return them as list
///
/// - author (dictionary): The dictionary containing the contact item values
/// - item-inset (dictionary): Inset of each individual contact item
/// -> array (of content)
#let format-contact-items(author, item-inset: (:)) = {
  let contact-entry(item, link-prefix: "") = {
    contact-item(item, link-prefix: link-prefix, inset: item-inset)
  }

  let items = ()

  if "birth" in author {
    items.push(
      contact-entry(
        (text: author.birth, icon: icons.birth),
      ),
    )
  }
  if "phone" in author {
    items.push(
      contact-entry(
        (text: author.phone, icon: icons.phone, link: author.phone),
        link-prefix: "tel:",
      ),
    )
  }
  if "email" in author {
    items.push(
      contact-entry(
        (text: author.email, icon: icons.email, link: author.email),
        link-prefix: "mailto:",
      ),
    )
  }
  if "homepage" in author {
    items.push(
      contact-entry(
        (text: author.homepage, icon: icons.homepage, link: author.homepage),
      ),
    )
  }
  if "github" in author {
    items.push(
      contact-entry(
        (text: author.github, icon: icons.github, link: author.github),
        link-prefix: "https://github.com/",
      ),
    )
  }
  if "gitlab" in author {
    items.push(
      contact-entry(
        (text: author.gitlab, icon: icons.gitlab, link: author.gitlab),
        link-prefix: "https://gitlab.com/",
      ),
    )
  }
  if "bitbucket" in author {
    items.push(
      contact-entry(
        (text: author.bitbucket, icon: icons.bitbucket, link: author.bitbucket),
        link-prefix: "https://bitbucket.org/",
      ),
    )
  }
  if "codeberg" in author {
    items.push(
      contact-entry(
        (text: author.codeberg, icon: icons.codeberg, link: author.codeberg),
        link-prefix: "https://codeberg.org/",
      ),
    )
  }
  if "linkedin" in author {
    items.push(
      contact-entry(
        (
          text: author.firstname + " " + author.lastname,
          icon: icons.linkedin,
          link: author.linkedin,
        ),
        link-prefix: "https://www.linkedin.com/in/",
      ),
    )
  }
  if "twitter" in author {
    items.push(
      contact-entry(
        (text: "@" + author.twitter, icon: icons.twitter, link: author.twitter),
        link-prefix: "https://twitter.com/",
      ),
    )
  }
  if "telegram" in author {
    items.push(
      contact-entry(
        (
          text: "@" + author.telegram,
          icon: icons.telegram,
          link: author.telegram,
        ),
        link-prefix: "https://t.me/",
      ),
    )
  }
  if "bluesky" in author {
    items.push(
      contact-entry(
        (text: "@" + author.bluesky, icon: icons.bluesky, link: author.bluesky),
        link-prefix: "https://bsky.app/profile/",
      ),
    )
  }
  if "mastodon" in author {
    items.push(
      contact-entry(
        (
          text: "@" + author.mastodon,
          icon: icons.mastodon,
          link: author.mastodon,
        ),
        link-prefix: "https://mastodon.social/@",
      ),
    )
  }
  if "scholar" in author {
    let fullname = str(author.firstname + " " + author.lastname)
    items.push(
      contact-entry(
        (text: fullname, icon: icons.google-scholar, link: author.scholar),
        link-prefix: "https://scholar.google.com/citations?user=",
      ),
    )
  }
  if "orcid" in author {
    items.push(
      contact-entry(
        (text: author.orcid, icon: icons.orcid, link: author.orcid),
        link-prefix: "https://orcid.org/",
      ),
    )
  }
  if "website" in author {
    items.push(
      contact-entry(
        (text: author.website, icon: icons.website, link: author.website),
      ),
    )
  }
  if "custom" in author and type(author.custom) == array {
    for item in author.custom {
      if "text" in item {
        items.push(
          contact-entry(
            (
              text: item.text,
              icon: if ("icon" in item) {
                box(icons.fa-icon(item.icon, fill: colors.darknight))
              } else {
                none
              },
              link: if ("link" in item) {
                item.link
              } else {
                none
              },
            ),
            link-prefix: "",
          ),
        )
      }
    }
  }

  items
}
