PYTHON :=
ifeq ($(OS),Windows_NT)
	PYTHON=.venv\Scripts\python
else
	PYTHON=.venv/bin/python
endif

venv:
	test -d .venv || python3 -m venv .venv/

install: check-venv
	$(PYTHON) -m pip install --upgrade pip
	$(PYTHON) -m pip install -r requirements.txt

run: check-venv
	@$(PYTHON) app/main.py

check-venv:
	@if [ -z "$$(which python | grep -o .venv)" ]; then \
		exit 1; \
	fi

pylint: check-venv
	@find app/ -name '*.py' -print0 | xargs -0 pylint -d C0103 -rn

test: check-venv
	$(PYTHON) -m unittest discover -p 'test_*.py' -v -b