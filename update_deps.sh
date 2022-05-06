#!/bin/bash

pip freeze | grep -E "mkdocs|diagrams|plantuml-markdown|mknotebooks|pymdown|pygments|fontawesome_markdown|boto3|fontawesome_markdown|markupsafe|ipython_genutils|adr-" > requirements.txt
