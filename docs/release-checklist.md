# Release Checklist

This document outlines the steps required to prepare a new release of `modern-cv`.

Steps:

1. Create a new release branch with the format `release/x.y.z`.
2. Update the version in the `typst.toml`.
3. Update examples in the [README.md](../README.md) to reflect the new version.
4. Update templates to import the correct version.
5. Do a final compilation/export check of all the templates.
6. Ensure that tests pass.
7. Ensure that the documentation manual builds.
