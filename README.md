# blackarchup

> A flexible, highly customizable, all-in-one BlackArch Linux setup framework.

## Table of Contents

- [Features](#features)
- [Framework structure](#framework-structure)
- [Usage](#usage)
  - [Easy configuration](#easy-configuration)
  - [Easy modularization](#easy-modularization)
  - [Easy customization](#easy-customization)
- [What? You're a Kali Linux user?](#what-youre-a-kali-linux-user)

## Features

- Support package managers:

  - pacman
  - npm
  - yarn
  - pip3
  - go
  - git

- Install app from GitHub release page (githubapp.sh)

## Framework structure

```
├── globalvar.yaml
├── blackarchup.sh
├── list
│   ├── pacman.list
│   ├── githubapp.list
│   ├── git.list
│   ├── go.list
│   ├── npm.list
│   ├── pip.list
│   └── yarn.list
└── script
    ├── pacman.sh
    ├── githubapp.sh
    ├── git.sh
    ├── go.sh
    ├── npm.sh
    ├── pip.sh
    └── yarn.sh
```

- blackarchup.sh: main script
- globalvar.yaml: global variables used in any scripts
- list/: app/package/module list, one item per line
- script/: bash scripts

## Usage

```bash
Usage:
  ./blackarch.sh [<script_name> <script_name2>...] [--help]

Custom scripts:
  githubapp         run ./script/githubapp.sh
  git               run ./script/git.sh
  go                run ./script/go.sh
  npm               run ./script/npm.sh
  pacman            run ./script/pacman.sh
  pip               run ./script/pip.sh
  yarn              run ./script/yarn.sh
  <script_name>     run ./script/<script_name>.sh
```

Example:

- Install apps from `pacman`, `pip` and `go` lists:

```bash
$ ./blackarchup.sh pacman pip go
```

### Easy configuration

- Add any apps/packages into `list/<script_name>.list` file accordingly, then run `./blackarchup.sh <srcipt_name>` to install them

### Easy modularization

- Need a new package manager? Simply add script to `script/` and then create app/package list in `list/`

### Easy customization

- Need a new global variable for your script? Add it in `globalvar.yaml`

- Already have your own setup script? Feel free to hook up by copying it to `script/` folder, run it `./blackarchup.sh <your_script_name>`

## What? You're a Kali Linux user?

You may like to check out another similar project for Kali Linux: [kaliup](https://github.com/KevCui/kaliup).

---

<a href="https://www.buymeacoffee.com/kevcui" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-orange.png" alt="Buy Me A Coffee" height="60px" width="217px"></a>