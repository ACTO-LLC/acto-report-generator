#!/bin/bash
# Report Generator Entrypoint
# Converts markdown to PDF with A CTO branding

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

usage() {
    echo "Usage: docker run -v \$(pwd):/data report-generator <input.md> [output.pdf]"
    echo ""
    echo "Arguments:"
    echo "  input.md    - Input markdown file (required)"
    echo "  output.pdf  - Output PDF file (optional, defaults to input filename with .pdf)"
    echo ""
    echo "Examples:"
    echo "  docker run -v \$(pwd):/data report-generator status-report.md"
    echo "  docker run -v \$(pwd):/data report-generator status-report.md report.pdf"
    exit 1
}

# Check for input file argument
if [ -z "$1" ]; then
    echo -e "${RED}Error: No input file specified${NC}"
    usage
fi

INPUT_FILE="$1"
OUTPUT_FILE="${2:-${INPUT_FILE%.md}.pdf}"

# Verify input file exists
if [ ! -f "/data/$INPUT_FILE" ]; then
    echo -e "${RED}Error: Input file not found: $INPUT_FILE${NC}"
    echo "Make sure the file exists in the mounted /data directory"
    exit 1
fi

echo -e "${YELLOW}==================================${NC}"
echo -e "${YELLOW}  A CTO Report Generator${NC}"
echo -e "${YELLOW}==================================${NC}"
echo ""
echo -e "Input:  ${GREEN}$INPUT_FILE${NC}"
echo -e "Output: ${GREEN}$OUTPUT_FILE${NC}"
echo ""

# Run md-to-pdf with configuration
echo "Generating PDF..."
cd /data

md-to-pdf "$INPUT_FILE" --config-file /app/pdf-config.js

# Rename output if custom filename specified
DEFAULT_OUTPUT="${INPUT_FILE%.md}.pdf"
if [ "$OUTPUT_FILE" != "$DEFAULT_OUTPUT" ] && [ -f "/data/$DEFAULT_OUTPUT" ]; then
    mv "/data/$DEFAULT_OUTPUT" "/data/$OUTPUT_FILE"
fi

# Check if PDF was created
if [ -f "/data/$OUTPUT_FILE" ]; then
    echo ""
    echo -e "${GREEN}Success! Report generated: $OUTPUT_FILE${NC}"

    # Show file size
    SIZE=$(du -h "/data/$OUTPUT_FILE" | cut -f1)
    echo -e "File size: ${SIZE}"
else
    echo -e "${RED}Error: PDF generation failed${NC}"
    exit 1
fi
