#!/usr/bin/env bash
CMD=${@:-serve --dev-addr=0.0.0.0:8000}

echo "Running command: xvfb-run -a mkdocs $CMD"

xvfb-run -a mkdocs $CMD