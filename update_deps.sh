#!/bin/bash

pip freeze | grep -E "mkdocs|diagrams|plantuml-markdown|mknotebooks|pymdown|pygments|fontawesome_markdown" > requirements.txt

