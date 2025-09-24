#!/bin/bash

# Compile Manuscript - Generate Publication-Ready Files
# This script compiles the manuscript into various formats

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}==================================${NC}"
echo -e "${CYAN}   Manuscript Compiler${NC}"
echo -e "${CYAN}==================================${NC}\n"

# Check for required tools
check_tool() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${YELLOW}Warning: $1 not found. $2${NC}"
        return 1
    fi
    return 0
}

PANDOC_AVAILABLE=$(check_tool pandoc "Install with: brew install pandoc")

# Find the latest manuscript version
if [ -f "manuscript/full_revised.md" ]; then
    SOURCE="manuscript/full_revised.md"
    VERSION="revised"
elif [ -f "manuscript/full_draft.md" ]; then
    SOURCE="manuscript/full_draft.md"
    VERSION="draft"
else
    # Compile from chapters
    echo "Compiling from individual chapters..."
    if ls manuscript/ch*_revised.md 1> /dev/null 2>&1; then
        cat manuscript/ch*_revised.md > manuscript/full_compiled.md
        SOURCE="manuscript/full_compiled.md"
        VERSION="compiled"
    elif ls manuscript/ch*_draft.md 1> /dev/null 2>&1; then
        cat manuscript/ch*_draft.md > manuscript/full_compiled.md
        SOURCE="manuscript/full_compiled.md"
        VERSION="compiled_draft"
    else
        echo -e "${RED}Error: No manuscript files found${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}Source: $SOURCE (version: $VERSION)${NC}\n"

# Get metadata
read -p "Book Title: " TITLE
read -p "Author Name: " AUTHOR
read -p "Copyright Year: " YEAR

# Create output directory
mkdir -p assets/{pdf,epub,docx,html}
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Options menu
echo -e "\nExport Formats:"
echo "1. PDF (print-ready)"
echo "2. EPUB (e-reader)"
echo "3. DOCX (Word document)"
echo "4. HTML (web version)"
echo "5. All formats"
read -p "Select option (1-5): " FORMAT

# Create metadata file for pandoc
cat > assets/metadata.yaml << EOF
---
title: "$TITLE"
author: "$AUTHOR"
date: "$YEAR"
rights: "© $YEAR $AUTHOR. All rights reserved."
language: en-US
---
EOF

# Compile functions
compile_pdf() {
    if [ "$PANDOC_AVAILABLE" ]; then
        echo -e "${YELLOW}Generating PDF...${NC}"
        pandoc "$SOURCE" \
            --metadata-file=assets/metadata.yaml \
            --pdf-engine=xelatex \
            --toc \
            --toc-depth=2 \
            --highlight-style=tango \
            -o "assets/pdf/${TITLE// /_}_${TIMESTAMP}.pdf"
        echo -e "${GREEN}✓ PDF created${NC}"
    else
        echo -e "${YELLOW}Skipping PDF (pandoc not available)${NC}"
    fi
}

compile_epub() {
    if [ "$PANDOC_AVAILABLE" ]; then
        echo -e "${YELLOW}Generating EPUB...${NC}"
        pandoc "$SOURCE" \
            --metadata-file=assets/metadata.yaml \
            --toc \
            --toc-depth=2 \
            --epub-chapter-level=2 \
            -o "assets/epub/${TITLE// /_}_${TIMESTAMP}.epub"
        echo -e "${GREEN}✓ EPUB created${NC}"
    else
        echo -e "${YELLOW}Skipping EPUB (pandoc not available)${NC}"
    fi
}

compile_docx() {
    if [ "$PANDOC_AVAILABLE" ]; then
        echo -e "${YELLOW}Generating DOCX...${NC}"
        pandoc "$SOURCE" \
            --metadata-file=assets/metadata.yaml \
            --toc \
            --reference-doc=assets/custom-reference.docx \
            -o "assets/docx/${TITLE// /_}_${TIMESTAMP}.docx" 2>/dev/null || \
        pandoc "$SOURCE" \
            --metadata-file=assets/metadata.yaml \
            --toc \
            -o "assets/docx/${TITLE// /_}_${TIMESTAMP}.docx"
        echo -e "${GREEN}✓ DOCX created${NC}"
    else
        echo -e "${YELLOW}Skipping DOCX (pandoc not available)${NC}"
    fi
}

compile_html() {
    echo -e "${YELLOW}Generating HTML...${NC}"

    # Basic HTML template
    cat > "assets/html/${TITLE// /_}_${TIMESTAMP}.html" << EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$TITLE - $AUTHOR</title>
    <style>
        body {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            font-family: Georgia, serif;
            line-height: 1.6;
        }
        h1 {
            text-align: center;
            border-bottom: 2px solid #333;
            padding-bottom: 10px;
        }
        h2 {
            margin-top: 40px;
            color: #444;
        }
        .metadata {
            text-align: center;
            color: #666;
            margin: 20px 0;
        }
        hr {
            margin: 30px 0;
            border: none;
            border-top: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <h1>$TITLE</h1>
    <div class="metadata">
        <p>by $AUTHOR</p>
        <p>© $YEAR</p>
    </div>
    <hr>
EOF

    # Convert markdown to HTML and append
    if [ "$PANDOC_AVAILABLE" ]; then
        pandoc "$SOURCE" -t html >> "assets/html/${TITLE// /_}_${TIMESTAMP}.html"
    else
        # Simple markdown to HTML conversion
        sed 's/^# \(.*\)/<h2>\1<\/h2>/' "$SOURCE" | \
        sed 's/^## \(.*\)/<h3>\1<\/h3>/' | \
        sed 's/^\*\*\*/<hr>/' | \
        sed 's/^$/<\/p><p>/' | \
        sed '1s/^/<p>/' | \
        sed '$s/$/<\/p>/' >> "assets/html/${TITLE// /_}_${TIMESTAMP}.html"
    fi

    echo "</body></html>" >> "assets/html/${TITLE// /_}_${TIMESTAMP}.html"
    echo -e "${GREEN}✓ HTML created${NC}"
}

# Execute based on selection
case $FORMAT in
    1) compile_pdf ;;
    2) compile_epub ;;
    3) compile_docx ;;
    4) compile_html ;;
    5)
        compile_pdf
        compile_epub
        compile_docx
        compile_html
        ;;
    *) echo "Invalid option"; exit 1 ;;
esac

# Statistics
echo -e "\n${CYAN}==================================${NC}"
echo -e "${CYAN}     Compilation Stats${NC}"
echo -e "${CYAN}==================================${NC}\n"

WC=$(wc -w < "$SOURCE")
CHAPTERS=$(grep -c "^# Chapter" "$SOURCE" || echo "0")
echo "Word count: $WC"
echo "Chapters: $CHAPTERS"
echo "Version: $VERSION"
echo "Timestamp: $TIMESTAMP"

# Cleanup
rm -f assets/metadata.yaml

echo -e "\n${GREEN}Compilation complete!${NC}"
echo "Files saved in assets/{pdf,epub,docx,html}/"
echo ""
echo "Next steps:"
echo "  1. Review exported files for formatting"
echo "  2. Test EPUB in e-reader applications"
echo "  3. Check PDF for print requirements"
echo "  4. Submit to publishers/platforms"