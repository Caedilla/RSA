name: "Bug Report"
description: Create a report to help us improve
labels: 'bug'
body:
- type: markdown
  attributes:
    value: |
      Please [search for existing issues](https://github.com/Caedilla/RSA/issues) before creating a new one.

- type: textarea
  attributes:
    label: Description
    description: What did you expect to happen and what happened instead?
  validations:
    required: true

- type: input
  attributes:
    label: RSA Version
    description: |
      You can see the current version in the title bar of the options window, if the options do not open, check the CurseForge app or the `## Version:` field in the WeakAuras.toc file.
    placeholder: "RSA 5.6.0"
  validations:
    required: true

- type: dropdown
  id: flavor
  attributes:
    label: World of Warcraft Flavor
    description: What version of World of Warcraft are are you running?
    options:
      - Retail (Default)
      - Wrath of the Lich King Classic
  validations:
    required: true

- type: textarea
  attributes:
    label: Lua Error
    description: |
      Do you have an error log of what happened? If you don't see any errors, make sure that error reporting is enabled (`/console scriptErrors 1`) or install [BugSack](https://www.curseforge.com/wow/addons/bugsack) & [BugGrabber](https://www.curseforge.com/wow/addons/bug-grabber), yes both are needed.
  validations:
    required: false

- type: textarea
  attributes:
    label: Reproduction Steps
    description: Please list out the steps to reproduce your bug. Please verify that your reproduction steps are enough to reproduce the problem.
    placeholder: |
      1. Go to '...'
      2. Click on '....'
      3. Scroll down to '....'
      4. See error
  validations:
    required: true

- type: textarea
  attributes:
    label: Screenshots
    description: If applicable, add screenshots to help explain your problem.
    placeholder: Click here to attach your screenshots via the editor button in the top right.
  validations:
    required: false