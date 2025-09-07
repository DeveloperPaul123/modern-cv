#import "../lib.typ"
#import "@preview/tidy:0.4.3"

#let docs = tidy.parse-module(read("../lib.typ"), name: "Modern CV", scope: (
  resume: lib,
))
#tidy.show-module(docs, style: tidy.styles.default)
