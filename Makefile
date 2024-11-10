#!/usr/bin/env make -f

# Python pypak Repo
# ..................................
# Copyright (c) 2017-2024, reactive-firewall
# ..................................
# Licensed under MIT (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# ..........................................
# http://www.github.com/reactive-firewall/pypak/LICENSE.md
# ..........................................
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifeq "$(LC_CTYPE)" ""
	LC_CTYPE="en_US.UTF-8"
endif

ifndef SHELL
	SHELL:=command -pv bash
endif

ifeq "$(ERROR_LOG_PATH)" ""
	ERROR_LOG_PATH="/dev/null"
endif

ifeq "$(COMMAND)" ""
	COMMAND_CMD!=`command -v xcrun || command which which || command -v which || command -v command`
	ifeq "$(COMMAND_CMD)" "*xcrun"
		COMMAND_ARGS=--find
	endif
	ifeq "$(COMMAND_CMD)" "*command"
		COMMAND_ARGS=-pv
	endif
	COMMAND=$(COMMAND_CMD) $(COMMAND_ARGS)
endif

ifeq "$(MAKE)" ""
	#  just no cmake please
	MAKEFLAGS=$(MAKEFLAGS) -s
	MAKE!=`$(COMMAND) make 2>$(ERROR_LOG_PATH) || $(COMMAND) gnumake 2>$(ERROR_LOG_PATH)`
endif

ifeq "$(ECHO)" ""
	ECHO=printf "%s\n"
endif

ifdef "$(ACTION)"
	SET_FILE_ATTR=$(COMMAND) xattr
endif

ifdef "$(SET_FILE_ATTR)"
	CREATEDBYBUILDSYSTEM=-w com.apple.xcode.CreatedByBuildSystem true
	BSMARK=$(SET_FILE_ATTR) $(CREATEDBYBUILDSYSTEM)
else
	BSMARK=$(COMMAND) touch -a
endif

ifeq "$(LINK)" ""
	LINK=ln -sf
endif

ifeq "$(PYTHON)" ""
	PY_CMD=$(COMMAND) python3
	ifneq "$(PY_CMD)" ""
		PY_ARGS=-B
	else
		PY_CMD=$(COMMAND) python
	endif
	PYTHON=$(PY_CMD) $(PY_ARGS)
	ifeq "$(COVERAGE)" ""
		COVERAGE=$(PYTHON) -m coverage
		#COV_CORE_SOURCE = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/
		COV_CORE_CONFIG = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/.coveragerc
		COV_CORE_DATAFILE = .coverage
	endif
	ifeq "$(COVERAGE)" ""
		COVERAGE!=$(COMMAND) coverage
	endif
else
	ifeq "$(COVERAGE)" ""
		COVERAGE!=$(COMMAND) coverage
		#COV_CORE_SOURCE = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/
		COV_CORE_CONFIG = $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/.coveragerc
		COV_CORE_DATAFILE = .coverage
	endif
endif

ifndef PIP_COMMON_FLAGS
	# Define common pip install flags
	PIP_COMMON_FLAGS := --use-pep517 --exists-action s --upgrade --upgrade-strategy eager
endif

# Define environment-specific pip install flags
ifeq ($(shell uname),Darwin)
	PIP_ENV_FLAGS := --break-system-packages
else
	PIP_ENV_FLAGS :=
endif

ifeq "$(WAIT)" ""
	WAIT=wait
endif

ifeq "$(INSTALL)" ""
	INSTALL=install
	ifeq "$(INST_OWN)" ""
		INST_OWN=-o root -g staff
	endif
	ifeq "$(INST_OPTS)" ""
		INST_OPTS=-m 755
	endif
endif

ifeq "$(LOG)" ""
	LOG=no
endif

ifeq "$(LOG)" "no"
	QUIET=@
	ifeq "$(DO_FAIL)" ""
		DO_FAIL=$(ECHO) "ok"
	endif
endif

ifeq "$(DO_FAIL)" ""
	DO_FAIL=$(COMMAND) :
endif

ifeq "$(RM)" ""
	RM=$(COMMAND) rm -f
endif

ifeq "$(RMDIR)" ""
	RMDIR=$(RM)Rd
endif

.PHONY: cleanup init clean-docs must_be_root must_have_flake must_have_pytest uninstall

help:
	$(QUIET)$(ECHO) "HELP"
	$(QUIET)$(ECHO) " * house-keeping" ;
	$(QUIET)$(ECHO) "   make help - this help text" ;
	$(QUIET)$(ECHO) "   make build - packages the module" ;
	$(QUIET)$(ECHO) "   make clean - cleans up a bit" ;
	$(QUIET)$(ECHO) "   make init - sets up requirements for first time" ;
	$(QUIET)$(ECHO) " * install/remove" ;
	$(QUIET)$(ECHO) "   make install - installs the module properly" ;
	$(QUIET)$(ECHO) "   make user-install - trys an unprivliged install (may not work for some users)" ;
	$(QUIET)$(ECHO) "   make uninstall - uninstalls the module" ;
	$(QUIET)$(ECHO) "   make purge - uninstalls the module, and resets most related things" ;
	$(QUIET)$(ECHO) "     (the big exception is init)" ;
	$(QUIET)$(ECHO) " * misc" ;
	$(QUIET)$(ECHO) "   make build-docs - generate documentation (using sphinx)" ;
	$(QUIET)$(ECHO) "   make test - run minimal acceptance testing" ;
	$(QUIET)$(ECHO) "   make test-style - run some code-style testing" ;
	$(QUIET)$(ECHO) "   make test-pytest - run extensive testing (with pytest)" ;
	$(QUIET)$(ECHO) "" ;

MANIFEST.in: init
	$(QUIET)$(ECHO) "include requirements.txt" >"$@" ;
	$(QUIET)$(BSMARK) "$@" 2>$(ERROR_LOG_PATH) >$(ERROR_LOG_PATH) || true ;
	$(QUIET)$(ECHO) "include README.md" >>"$@" ;
	$(QUIET)$(ECHO) "include LICENSE.md" >>"$@" ;
	$(QUIET)$(ECHO) "include CHANGES.md" >>"$@" ;
	$(QUIET)$(ECHO) "include HISTORY.md" >>"$@" ;
	$(QUIET)$(ECHO) "recursive-include . *.txt" >>"$@" ;
	$(QUIET)$(ECHO) "exclude .gitignore" >>"$@" ;
	$(QUIET)$(ECHO) "exclude .deepsource.toml" >>"$@" ;
	$(QUIET)$(ECHO) "exclude .*.ini" >>"$@" ;
	$(QUIET)$(ECHO) "exclude .*.yml" >>"$@" ;
	$(QUIET)$(ECHO) "global-exclude .git" >>"$@" ;
	$(QUIET)$(ECHO) "global-exclude codecov_env" >>"$@" ;
	$(QUIET)$(ECHO) "global-exclude .DS_Store" >>"$@" ;
	$(QUIET)$(ECHO) "prune .gitattributes" >>"$@" ;
	$(QUIET)$(ECHO) "prune test-reports" >>"$@" ;
	$(QUIET)$(ECHO) "prune .github" >>"$@" ;
	$(QUIET)$(ECHO) "prune .circleci" >>"$@" ;

build: init ./setup.py MANIFEST.in
	$(QUIET)$(PYTHON) -W ignore -m build --sdist --wheel --no-isolation ./ || $(QUIET)$(PYTHON) -W ignore -m build ./ ;
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "build DONE."

init:
	$(QUIET)$(PYTHON) -m pip install $(PIP_COMMON_FLAGS) $(PIP_ENV_FLAGS) "pip>=22.0" "setuptools>=75.0" "wheel>=0.44" "build>=1.1.1" 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(PYTHON) -m pip install $(PIP_COMMON_FLAGS) $(PIP_ENV_FLAGS) -r requirements.txt 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(ECHO) "$@: Done."

install: init build must_be_root
	$(QUIET)$(PYTHON) -m pip install $(PIP_COMMON_FLAGS) $(PIP_ENV_FLAGS) -e "git+https://github.com/reactive-firewall/pypak.git#egg=pypak"
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

uninstall:
	$(QUIET)$(PYTHON) -m pip uninstall --use-pep517 $(PIP_ENV_FLAGS) --no-input -y pypak 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

purge: clean uninstall
	$(QUIET)$(PYTHON) -W ignore ./setup.py uninstall 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(PYTHON) -W ignore ./setup.py clean 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(RMDIR) ./build/ 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(RMDIR) ./dist/ 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(RMDIR) ./.eggs/ 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(RM) ./test-reports/junit.xml 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(RMDIR) ./test-reports/ 2>$(ERROR_LOG_PATH) || :
	$(QUIET)$(ECHO) "$@: Done."

test: cleanup MANIFEST.in
	$(QUIET)$(COVERAGE) run -p --source=pypak -m unittest discover --verbose --buffer -s ./tests -t $(dir $(abspath $(lastword $(MAKEFILE_LIST)))) || $(PYTHON) -m unittest discover --verbose --buffer -s ./tests -t ./ || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(DO_FAIL) ;
	$(QUIET)$(COVERAGE) combine 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(COVERAGE) report -m --include=* 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(ECHO) "$@: Done."

test-tox: build
	$(QUIET)tox -v -- || tail -n 500 .tox/py*/log/py*.log 2>$(ERROR_LOG_PATH)
	$(QUIET)$(COVERAGE) combine 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(COVERAGE) report -m --include=* 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(ECHO) "$@: Done."

test-reports:
	$(QUIET)mkdir $(INST_OPTS) ./test-reports 2>$(ERROR_LOG_PATH) >$(ERROR_LOG_PATH) || true ;
	$(QUIET)$(BSMARK) ./test-reports 2>$(ERROR_LOG_PATH) >$(ERROR_LOG_PATH) || true ;
	$(QUIET)$(ECHO) "$@: Done."

test-reqs: test-reports init
	$(QUIET)$(PYTHON) -m pip install $(PIP_COMMON_FLAGS) $(PIP_ENV_FLAGS) -r tests/requirements.txt 2>$(ERROR_LOG_PATH) || true

docs-reqs: ./docs/ ./docs/requirements.txt init
	$(QUIET)$(PYTHON) -m pip install $(PIP_COMMON_FLAGS) $(PIP_ENV_FLAGS) -r docs/requirements.txt  2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(WAIT) ;

test-pytest: cleanup MANIFEST.in must_have_pytest test-reports
	$(QUIET)$(PYTHON) -m pytest --cache-clear --doctest-glob=pypak/*.py --doctest-modules --cov=. --cov-append --cov-report=xml --junitxml=test-reports/junit.xml -v --rootdir=. || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(DO_FAIL) ;
	$(QUIET)$(ECHO) "$@: Done."

test-style: cleanup must_have_flake
	$(QUIET)$(PYTHON) -m flake8 --ignore=W191,W391 --max-line-length=100 --verbose --count --config=.flake8.ini --show-source || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(DO_FAIL) ;
	$(QUIET)tests/check_spelling || true
	$(QUIET)tests/check_cc_lines || true
	$(QUIET)$(ECHO) "$@: Done."

must_have_flake:
	$(QUIET)runner=`$(PYTHON) -m pip freeze --all | grep --count -oF flake` ; \
	if test $$runner -le 0 ; then $(ECHO) "No Linter found for test." ; exit 126 ; fi

must_have_pytest: init
	$(QUIET)runner=`$(PYTHON) -m pip freeze --all | grep --count -oF pytest` ; \
	if test $$runner -le 0 ; then $(ECHO) "No python framework (pytest) found for test." ; exit 126 ; fi

cleanup:
	$(QUIET)$(RM) tests/*.pyc 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) tests/*~ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) tests/__pycache__/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) __pycache__/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak/*.pyc 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak/*~ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak/__pycache__/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak/*/*.pyc 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak/*/*~ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak/*.DS_Store 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak/*/*.DS_Store 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak/.DS_Store 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak/*/.DS_Store 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) tests/.DS_Store 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) tests/*/.DS_Store 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) pypak.egg-info/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) /tmp/test_data.pkl 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./*.pyc 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./.coverage 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./coverage*.xml 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./sitecustomize.py 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./.DS_Store 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./*/.DS_Store 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./*/*~ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./.*/*~ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./*~ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./.*~ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./src/**/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./src/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./test_env/**/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./test_env/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./.hypothesis/**/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./.hypothesis/* 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) ./src/ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) tests/__pycache__ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) pypak/__pycache__ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) pypak/*/__pycache__ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) ./__pycache__ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) pypak.egg-info 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) .pytest_cache/ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) .eggs 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) ./test_env/ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) ./test-reports/ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) ./.tox/ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RMDIR) ./.hypothesis/ 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(WAIT) ;

build-docs: ./docs/ ./docs/Makefile docs-reqs
	$(QUIET)$(MAKE) -s -C ./docs/ -f Makefile html 2>$(ERROR_LOG_PATH) || DO_FAIL="exit 2" ;
	$(QUIET)$(WAIT) ;
	$(QUIET)mkdir $(INST_OPTS) ./docs/www 2>$(ERROR_LOG_PATH) >$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(BSMARK) ./docs/www 2>$(ERROR_LOG_PATH) >$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(WAIT) ;
	$(QUIET)cp -fRp ./docs/_build/ ./docs/www/ 2>$(ERROR_LOG_PATH) || DO_FAIL="exit 35" ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(MAKE) -s -C ./docs/ -f Makefile clean 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(WAIT) ;
	$(QUIET)$(ECHO) "Documentation should be in docs/www/html/"
	$(QUIET)$(DO_FAIL) ;

clean-docs: ./docs/ ./docs/Makefile
	$(QUIET)$(RM) ./docs/www/* 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(RM) ./docs/_build/* 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(RMDIR) ./docs/_build/ 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(RMDIR) ./docs/www/ 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(MAKE) -s -C ./docs/ -f Makefile clean 2>$(ERROR_LOG_PATH) || : ;
	$(QUIET)$(WAIT) ;

./docs/:
	$(QUIET) : ;

./docs/Makefile: ./docs/
	$(QUIET)$(WAIT) ;

clean: clean-docs cleanup
	$(QUIET)$(ECHO) "Cleaning Up."
	$(QUIET)$(COVERAGE) erase 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./test-results/junit.xml 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(RM) ./MANIFEST.in 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(ECHO) "All clean."

must_be_root:
	$(QUIET)runner=`whoami` ; \
	if test $$runner != "root" ; then $(ECHO) "You are not root." ; exit 1 ; fi

user-install: build
	$(QUIET)$(PYTHON) -m pip install $(PIP_COMMON_FLAGS) $(PIP_ENV_FLAGS) --user "pip>=22.0" "setuptools>=75.0" "wheel>=0.44" "build>=1.1.1" 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(PYTHON) -m pip install $(PIP_COMMON_FLAGS) $(PIP_ENV_FLAGS) --user -r "https://raw.githubusercontent.com/reactive-firewall/pypak/stable/requirements.txt" 2>$(ERROR_LOG_PATH) || true
	$(QUIET)$(PYTHON) -m pip install $(PIP_COMMON_FLAGS) $(PIP_ENV_FLAGS) --user -e "git+https://github.com/reactive-firewall/pypak.git#egg=pypak"
	$(QUIET)$(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

%:
	$(QUIET)$(ECHO) "No Rule Found For $@" 1>&2 ;
	$(QUIET)$(WAIT) ;

