# tcl-prompt

[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/Freed-Wu/tcl-prompt/main.svg)](https://results.pre-commit.ci/latest/github/Freed-Wu/tcl-prompt/main)

[![github/downloads](https://shields.io/github/downloads/Freed-Wu/tcl-prompt/total)](https://github.com/Freed-Wu/tcl-prompt/releases)
[![github/downloads/latest](https://shields.io/github/downloads/Freed-Wu/tcl-prompt/latest/total)](https://github.com/Freed-Wu/tcl-prompt/releases/latest)
[![github/issues](https://shields.io/github/issues/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/issues)
[![github/issues-closed](https://shields.io/github/issues-closed/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/issues?q=is%3Aissue+is%3Aclosed)
[![github/issues-pr](https://shields.io/github/issues-pr/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/pulls)
[![github/issues-pr-closed](https://shields.io/github/issues-pr-closed/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/pulls?q=is%3Apr+is%3Aclosed)
[![github/discussions](https://shields.io/github/discussions/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/discussions)
[![github/milestones](https://shields.io/github/milestones/all/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/milestones)
[![github/forks](https://shields.io/github/forks/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/network/members)
[![github/stars](https://shields.io/github/stars/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/stargazers)
[![github/watchers](https://shields.io/github/watchers/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/watchers)
[![github/contributors](https://shields.io/github/contributors/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/graphs/contributors)
[![github/commit-activity](https://shields.io/github/commit-activity/w/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/graphs/commit-activity)
[![github/last-commit](https://shields.io/github/last-commit/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/commits)
[![github/release-date](https://shields.io/github/release-date/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/releases/latest)

[![github/license](https://shields.io/github/license/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt/blob/main/LICENSE)
[![github/languages](https://shields.io/github/languages/count/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt)
[![github/languages/top](https://shields.io/github/languages/top/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt)
[![github/directory-file-count](https://shields.io/github/directory-file-count/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt)
[![github/code-size](https://shields.io/github/languages/code-size/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt)
[![github/repo-size](https://shields.io/github/repo-size/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt)
[![github/v](https://shields.io/github/v/release/Freed-Wu/tcl-prompt)](https://github.com/Freed-Wu/tcl-prompt)

This project provides:

- A [powerlevel10k](https://github.com/romkatv/powerlevel10k)-like prompt for
  [tcl](https://www.tcl.tk)s REPL `tclsh` and [tk](https://www.tcl.tk/)'s REPL
  `wish`.
- A [wakatime](https://wakatime.com/) plugin to statistics how much time you
  write tcl in REPL.

![tclsh](https://github.com/Freed-Wu/Freed-Wu/assets/32936898/d410608b-6ddf-4c1b-a72e-9d6f6b1f48a4)

![wish](https://github.com/Freed-Wu/Freed-Wu/assets/32936898/a8a2304b-cc63-4597-befe-9e04fc453179)

Besides tcl's REPL `tclsh`, there are many programs written in tcl which
provide their REPLs. This project provides some wrapper scripts to use this
plugin for them:

- [`expect`](https://expect.sourceforge.net)
- [vivado](https://www.xilinx.com/products/design-tools/vivado.html)'s
  [`vivado -mode tcl`](https://docs.xilinx.com/r/en-US/ug835-vivado-tcl-commands)
- [vitis](https://www.xilinx.com/products/design-tools/vitis.html)'s
  [`xsct`](https://docs.xilinx.com/r/en-US/ug1400-vitis-embedded)

![expectp](https://github.com/Freed-Wu/tcl-prompt/assets/32936898/5ceddf38-6b59-45b1-8046-a64286f27189)

![vivadop](https://github.com/Freed-Wu/tcl-prompt/assets/32936898/de90a851-8d62-4e42-a4bd-e8ec402599eb)

![xsctp](https://github.com/Freed-Wu/tcl-prompt/assets/32936898/eed76559-7aee-4854-a94b-5dd9c3782d87)

## Dependencies

- [tclreadline](https://github.com/flightaware/tclreadline): Provide a function
  `::tclreadline::prompt1`. Every read-eval-print-loop the function will be
  called and it's result will be used as prompt string.
- [tcllib](https://core.tcl-lang.org/tcllib): Provide some functions and
  variables about ANSI colors.

## Install

### [AUR](https://aur.archlinux.org/packages/tcl-prompt)

```sh
paru -S tcl-prompt-git
```

### [NUR](https://nur.nix-community.org/repos/freed-wu)

```sh
nix-env -iA nixos.nur.repos.Freed-Wu.tcl-prompt
```

## Usage

`~/.tclshrc`:

```tcl
package require prompt

::tclreadline::Loop
```

## Customize

You can redefined `::tclreadline::prompt1`. This project provides a function
`::prompt::get_ps1` to generate prompt string.

- `str` is last string, such as `>`, `$`.
- `format` can be `%s` to add padding white spaces
- `sep` separate every section of prompt string.
- `text_or_function` can be a text or function. Such as:
  - `::prompt::wakatime`: statistic time. Output nothing. Ignore `fg_color` and
    `bg_color`.
  - `::prompt::get_icon`: output OS icon.
  - `::prompt::icon`: OS icon.
  - `::prompt::get_version`: output tcl version.
  - `::prompt::version`: tcl version.
  - `::prompt::get_cwd`: output current working directory. Use `~` to replace `$HOME`.
  - `::prompt::get_time`: output current time.

```tcl
# ::prompt::get_ps1 [str] [[format] {fg_color bg_color text_or_function} [sep]] ...
proc ::tclreadline::prompt1 {} {
  return [::prompt::get_ps1 ...]
}
```
