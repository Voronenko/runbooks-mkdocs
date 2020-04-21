init:
	pipenv install --python 3

reset-from-requirements:
	pipenv install -r ./requirements.txt

build:
	mkdocs build

serve:
	mkdocs serve
