// Regression test for https://github.com/ptsouchlos/modern-cv/issues/204
// ("[Bug] Date localization"): dates must be formatted per the `language`
// argument instead of always using the US "Month Day, Year" format.
#import "@local/modern-cv:0.11.0": helpers.format-date

#let d = datetime(year: 2026, month: 8, day: 28)

// A `datetime` is formatted per-language.
#assert.eq(format-date(d, "en"), "August 28, 2026")
#assert.eq(format-date(d, "de"), "28.08.2026")
#assert.eq(format-date(d, "fr"), "28/08/2026")
#assert.eq(format-date(d, "sv"), "2026-08-28")
#assert.eq(format-date(d, "zh"), "2026年08月28日")

// Remaining `lang.toml` locales not covered above.
#assert.eq(format-date(d, "gr"), "28/08/2026")
#assert.eq(format-date(d, "pt"), "28/08/2026")
#assert.eq(format-date(d, "sp"), "28/08/2026")
#assert.eq(format-date(d, "ru"), "28.08.2026")
#assert.eq(format-date(d, "it"), "28/08/2026")
#assert.eq(format-date(d, "nl"), "28-08-2026")

// An unrecognized language code falls back to the "en" format rather than
// erroring.
#assert.eq(format-date(d, "xx"), "August 28, 2026")

// A `str` (e.g. an explicit caller override, or a non-standard entry like
// "2023 - Present") is passed through unchanged regardless of language.
#assert.eq(format-date("2023 - Present", "de"), "2023 - Present")
