#import "../lib.typ"
#import "@preview/tidy:0.3.0"

#let docs = tidy.parse-module(
  read("../lib.typ"),
  name: "Modern CV",
  scope: (resume: lib),
)
#tidy.show-module(docs)
