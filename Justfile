root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
    @just --list --unsorted

# generate manual
[doc('Generate package documentation')]
[group('package')]
doc:
    typst compile docs/manual.typ docs/manual.pdf

[doc('Run test suite. Requires tytanic.')]
[group('dev')]
test *args: install
    tt run {{ args }} --use-system-fonts --no-fail-fast

[doc('Update test cases. Requires tytanic.')]
[group('dev')]
update *args:
    tt update {{ args }} --use-system-fonts

[doc('Package the library into the specified destination folder')]
[group('package')]
package target:
  ./scripts/package "{{target}}"

[doc('Install the library with the "@local" prefix')]
[group('dev')]
install: (package "@local")

[doc('Install the library with the "@preview" prefix (for pre-release testing)')]
[group('dev')]
install-preview: (package "@preview")

[private]
remove target:
  ./scripts/uninstall "{{target}}"

[doc('Uninstall the library from the "@local" prefix')]
[group('dev')]
uninstall: (remove "@local")

[doc('Uninstall the library from the "@preview" prefix (for pre-release testing)')]
[group('dev')]
uninstall-preview: (remove "@preview")

[doc('Format the source code. Requires typstyle.')]
[group('dev')]
format:
    ./scripts/format

[doc('Run ci suite')]
[group('dev')]
ci: test doc
