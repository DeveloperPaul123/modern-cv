#import "../src/lib.typ"
#import "@preview/tidy:0.4.3"

#let docs = tidy.parse-module(
  read("../src/lib.typ"),
  name: "Modern CV",
  scope: (
    resume: lib,
  ),
)
#tidy.show-module(docs, style: tidy.styles.default)
