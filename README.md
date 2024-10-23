# Python Accessory Kit (PAK)

## Table of Contents

- [About](#about)
- [Status](#status)
  - [Master Branch](#master-branch)
  - [Stable Branch](#stable-branch)
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
  - [Modules](#modules)
  - [Scripts](#scripts)
  - [Documentation](#documentation)
  - [Tests](#tests)
- [Development](#development)
  - [Testing](#testing)
  - [Style Guidelines](#style-guidelines)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## About

The Python Accessory Kit (PAK) is a collection of Python utilities and scripts designed to assist
with various development tasks.

## Status

### Master Branch

[![status](https://travis-ci.org/reactive-firewall/pak.svg?branch=master)](https://travis-ci.org/reactive-firewall/pak)
[![CircleCI](https://circleci.com/gh/reactive-firewall/pak/tree/master.svg?style=svg)](https://circleci.com/gh/reactive-firewall/pak/tree/master)
[![Appveyor](https://ci.appveyor.com/api/projects/status/pak/branch/master?svg=true)](https://ci.appveyor.com/project/reactive-firewall/pak/branch/master)
[![Python 3](https://pyup.io/repos/github/reactive-firewall/pak/python-3-shield.svg)](https://pyup.io/repos/github/reactive-firewall/pak/)
[![Updates](https://pyup.io/repos/github/reactive-firewall/pak/shield.svg)](https://pyup.io/repos/github/reactive-firewall/pak/)
[![Test Coverage](https://api.codeclimate.com/v1/badges/pak/test_coverage)](https://codeclimate.com/github/reactive-firewall/pak/test_coverage)
[![Code Coverage](https://codecov.io/gh/reactive-firewall/pak/branch/master/graph/badge.svg)](https://codecov.io/gh/reactive-firewall/pak/branch/master/)
[![Coverage Status](https://coveralls.io/repos/github/reactive-firewall/pak/badge.svg?branch=master)](https://coveralls.io/github/reactive-firewall/pak?branch=master)
[![Code Climate](https://codeclimate.com/github/reactive-firewall/pak/badges/gpa.svg)](https://codeclimate.com/github/reactive-firewall/pak)
[![CodeFactor](https://www.codefactor.io/repository/github/reactive-firewall/pak/badge)](https://www.codefactor.io/repository/github/reactive-firewall/pak)
[![codebeat badge](https://codebeat.co/badges/da1d8064-5736-49fd-9d61-d046aca38afb)](https://codebeat.co/projects/github-com-reactive-firewall-pak-master)
![Size](https://img.shields.io/github/languages/code-size/reactive-firewall/pak.svg)
![commits-since](https://img.shields.io/github/commits-since/reactive-firewall/pak/stable.svg?maxAge=9000)

### Stable Branch

[CI](gha link goes here)
[![CircleCI](https://circleci.com/gh/reactive-firewall/pak/tree/stable.svg?style=svg)](https://circleci.com/gh/reactive-firewall/pak/tree/stable)
[![Appveyor](https://ci.appveyor.com/api/projects/status/6gggp1wpbnnjokm4/branch/stable?svg=true)](https://ci.appveyor.com/project/reactive-firewall/pak/branch/stable)
[![Code Coverage](https://codecov.io/gh/reactive-firewall/pak/branch/stable/graph/badge.svg)](https://codecov.io/gh/reactive-firewall/pak/branch/stable/)
[![Coverage Status](https://coveralls.io/repos/github/reactive-firewall/pak/badge.svg?branch=stable)](https://coveralls.io/github/reactive-firewall/pak?branch=stable)
[![codebeat badge](https://codebeat.co/badges/87520e4a-6d24-4e98-a61e-6e9efc58f783)](https://codebeat.co/projects/github-com-reactive-firewall-pak-stable)

## Installation

Clone the repository and navigate to the project directory:

```bash
git clone https://github.com/reactive-firewall/pak.git
cd pak
```

Install the required dependencies:

```bash
pip install -r requirements.txt
```

## Usage

PAK provides a set of modules and scripts that can be utilized in your Python projects. You can
import the modules in your Python code as follows:

```python
import pak
```

## Features

### Modules

- `pak/__init__.py`: The initialization module for PAK.
- `pak/anything.py`: Contains the `anything` and `nothing` classes, providing generic object
implementations with extensive method overloading and testing examples.

### Scripts

- `setup.py`: Script to install the PAK package.
- `Makefile`: Contains development, testing, and cleaning commands for ease of use.

### Documentation ( **WIP** )

Located in the `docs/` directory:

- `conf.py`: Configuration for Sphinx documentation generation.
- `index.md`: The main page for project documentation.
- `Makefile` and `make.bat`: Scripts to build documentation in various formats.

### Tests

Located in the `tests/` directory.

## Development

### Testing

For testing, use the provided `Makefile` commands:

- Run unit tests:

```bash
make clean
make test
```

- Check code style according to CEP-8 conventions:

```bash
make clean
make test-style
```

- Run tests across multiple environments using Tox:

```bash
make clean
make test-tox
```

### Style Guidelines

This project follows custom coding standards:

- **CEP-8**: A style guide for Python code, similar to PEP 8 but with project-specific conventions.
- **CEP-5**: A style guide for Bash scripts, detailing conventions for script structure and
  formatting.

Please ensure all Python and Bash code adheres to these standards.

## Dependencies

The project dependencies are listed in `requirements.txt`.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Ensure your code follows the CEP-8 (Python) or CEP-5 (Bash) coding standards.
4. Submit a pull request with a detailed description of your changes.

## License

[![MIT License](https://img.shields.io/github/license/reactive-firewall/pak.svg?maxAge=2592000)](https://github.com/reactive-firewall/pak/blob/stable/LICENSE.md)

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- **Third-party Acknowledgement**:

  Some code, particularly in `tests/profiling.py`, was modified or derived from
  [Zapier's profiling-python-like-a-boss project](https://github.com/zapier/profiling-python-like-a-boss/tree/1ab93a1154).
  This code is under the BSD-3-Clause license. See the
  [LICENSE](https://github.com/zapier/profiling-python-like-a-boss/blob/1ab93a1154/LICENSE.md) for
  details.

- **Special Thanks**:

  Thanks to all contributors and the open-source community for their invaluable support and
  resources.

