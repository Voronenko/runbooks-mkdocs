#!/bin/bash

pip freeze | grep -E "mkdocs|diagrams|plantuml-markdown|mknotebooks|pymdown|pygments|fontawesome-markdown|adr-viewer|boto3|fontawesome_markdown|markupsafe|ipython_genutils|adr-|MarkupSafe|ipython-genutils|gitlab" > requirements.txt
pip freeze > requirements-full.txt
