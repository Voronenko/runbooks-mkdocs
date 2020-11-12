init:
	pipenv install --python 3

reset-from-requirements:
	pipenv install -r ./requirements.txt

build:
	mkdocs build

serve:
	mkdocs serve

install-confluence-mark:
	curl -sLo /tmp/confluencemark.tar.gz https://github.com/kovetskiy/mark/releases/download/3.1/mark_3.1_Linux_x86_64.tar.gz
	tar -xvzf /tmp/confluencemark.tar.gz -C /tmp
	cp /tmp/mark ~/dotfiles/bin
	chmod +x ~/dotfiles/bin/mark

init-adr:
	./bin/adr init ./docs/architecture/decisions

view-adr:
	adr-viewer --adr-path ./docs/architecture/decisions/ --serve --output decisions.html

generate-adr:
	adr-viewer --adr-path ./docs/architecture/decisions/ --output docs/architecture/decisions/decisions.html
	sed -i 's/\.md"/\/index.html"/g' docs/architecture/decisions/decisions.html

update-adr-toc: generate-adr
	rm docs/architecture/decisions/index.md || true
	./bin/adr generate toc > docs/architecture/decisions/index.md

# https://www.dbml.org/
install-dbml-cli-npm:
	npm install -g @dbml/cli
	echo dbml2sql schema.dbml
	echo dbml2sql schema.dbml --mysql
	echo "dbml2sql <path-to-dbml-file> [--mysql|--postgres] [-o|--out-file <output-filepath>]"
	echo sql2dbml dump.sql --postgres
	echo sql2dbml --mysql dump.sql -o mydatabase.dbml
	echo sql2dbml <path-to-sql-file> [--mysql|--postgres] [-o|--out-file <output-filepath>]

install-dbml-cli-yarn:
	yarn global add @dbml/cli
	npm install -g @dbml/cli
	echo dbml2sql schema.dbml
	echo dbml2sql schema.dbml --mysql
	echo "dbml2sql <path-to-dbml-file> [--mysql|--postgres] [-o|--out-file <output-filepath>]"
	echo sql2dbml dump.sql --postgres
	echo sql2dbml --mysql dump.sql -o mydatabase.dbml
	echo sql2dbml <path-to-sql-file> [--mysql|--postgres] [-o|--out-file <output-filepath>]

install-dbtools-terra-er:
	curl -sLo ~/dotfiles/bin/terra.jar https://github.com/rterrabh/TerraER/releases/download/TerraER3.11/TerraER3.11.jar

install-dbtools-schemaspy:
	curl -sLo ~/dotfiles/bin/schemaspy.jar https://github.com/schemaspy/schemaspy/releases/download/v6.1.0/schemaspy-6.1.0.jar
