#!/bin/bash

pip freeze | grep -E "mkdocs|diagrams|plantuml-markdown" > requirements.txt
