init:
	pipenv install --python 3

reset-from-requirements:
	pipenv install -r ./requirements.txt

build:
	mkdocs build

serve:
	mkdocs serve

install-confluence-mark:
	wget -O /tmp/confluencemark.tar.gz https://github.com/kovetskiy/mark/releases/download/3.1/mark_3.1_Linux_x86_64.tar.gz
	tar -xvzf /tmp/confluencemark.tar.gz -C /tmp
	cp /tmp/mark ~/dotfiles/bin
	chmod +x ~/dotfiles/bin/mark

init-adr:
	./bin/adr init ./docs/architecture/decisions

view-adr:
	adr-viewer --adr-path ./docs/architecture/decisions/ --serve --output decisions.html

generate-adr:
	adr-viewer --adr-path ./docs/architecture/decisions/ --output decisions.html

