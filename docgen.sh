#!/bin/bash

echo "==> Generating Markdown Documentation..."
pandoc -f rst -t gfm -i docs/api.rst -o API.md
pandoc -f rst -t gfm -i docs/getting-started.rst -o GETTING_STARTED.md
pandoc -f rst -t gfm -i docs/index.rst -o INDEX.md
pandoc -f rst -t gfm -i docs/api-2providers.rst -o PROVIDERS.md
pandoc -f rst -t gfm -i docs/api-8utils.rst -o UTILS.md
touch DOCUMENTATION.md
cat INDEX.md GETTING_STARTED.md PROVIDERS.md UTILS.md API.md >> DOCUMENTATION.md 