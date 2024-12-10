# PR Checkbox Checker Action

This GitHub Action checks if all checkboxes in a pull request description are checked.

## Usage

```yaml
name: Check PR Checkboxes

on:
  pull_request:
    types:
      - opened
      - reopened
      - edited
      - synchronize
      - ready_for_review

jobs:
  check-boxes:
    runs-on: ubuntu-latest
    steps:
      - uses: kromiii/checkbox-check-action@v1
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
```
