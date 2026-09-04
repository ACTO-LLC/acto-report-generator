#!/bin/bash
# Fluent MedOps Report Generator — markdown to branded PDF
set -e
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

if [ -z "$1" ]; then
    echo -e "${RED}Error: No input file specified${NC}"
    echo "Usage: docker run -v \$(pwd):/data fluent-medops-report-generator <input.md> [output.pdf]"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${2:-${INPUT_FILE%.md}.pdf}"

if [ ! -f "/data/$INPUT_FILE" ]; then
    echo -e "${RED}Error: Input file not found: $INPUT_FILE${NC}"
    exit 1
fi

echo -e "${YELLOW}Fluent MedOps Report Generator${NC}"
echo -e "Input:  ${GREEN}$INPUT_FILE${NC}"
echo -e "Output: ${GREEN}$OUTPUT_FILE${NC}"

DOC_TITLE=$(grep -m1 -E '^#[[:space:]]+' "/data/$INPUT_FILE" \
    | sed -E 's/^#[[:space:]]+//; s/\*\*//g; s/[*_`]//g; s/[[:space:]]+$//')
if [ -z "$DOC_TITLE" ]; then
    DOC_TITLE=$(basename "$INPUT_FILE" .md)
fi

cd /data
md-to-pdf "$INPUT_FILE" --config-file /app/pdf-config.js --document-title "$DOC_TITLE"

DEFAULT_OUTPUT="${INPUT_FILE%.md}.pdf"
if [ "$OUTPUT_FILE" != "$DEFAULT_OUTPUT" ] && [ -f "/data/$DEFAULT_OUTPUT" ]; then
    mv "/data/$DEFAULT_OUTPUT" "/data/$OUTPUT_FILE"
fi

if [ -f "/data/$OUTPUT_FILE" ]; then
    echo -e "${GREEN}Success! Report generated: $OUTPUT_FILE${NC}"
    echo -e "File size: $(du -h "/data/$OUTPUT_FILE" | cut -f1)"
else
    echo -e "${RED}Error: PDF generation failed${NC}"
    exit 1
fi
