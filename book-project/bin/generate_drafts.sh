#!/bin/bash

# Generate Draft Chapters - Batch Processing Script
# This script automatically drafts all chapters defined in the outline

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}==================================${NC}"
echo -e "${GREEN}  Chapter Draft Generator${NC}"
echo -e "${GREEN}==================================${NC}\n"

# Check if outline exists
if [ ! -f "manuscript/outline_v1.md" ] && [ ! -f "manuscript/outline.md" ]; then
    echo -e "${RED}Error: No outline found in manuscript/${NC}"
    echo "Please run '/expand-note' first to create an outline."
    exit 1
fi

# Detect outline file
OUTLINE_FILE="manuscript/outline_v1.md"
if [ ! -f "$OUTLINE_FILE" ]; then
    OUTLINE_FILE="manuscript/outline.md"
fi

echo -e "${YELLOW}Using outline: $OUTLINE_FILE${NC}\n"

# Extract chapter count from outline
CHAPTER_COUNT=$(grep -c "^### Chapter " "$OUTLINE_FILE" || echo "0")

if [ "$CHAPTER_COUNT" -eq 0 ]; then
    echo -e "${RED}Error: No chapters found in outline${NC}"
    exit 1
fi

echo -e "${GREEN}Found $CHAPTER_COUNT chapters to draft${NC}\n"

# Options
echo "Draft Generation Options:"
echo "1. Draft all chapters"
echo "2. Draft specific range (e.g., 1-5)"
echo "3. Draft single chapter"
read -p "Select option (1-3): " OPTION

case $OPTION in
    1)
        START=1
        END=$CHAPTER_COUNT
        ;;
    2)
        read -p "Enter start chapter: " START
        read -p "Enter end chapter: " END
        ;;
    3)
        read -p "Enter chapter number: " START
        END=$START
        ;;
    *)
        echo -e "${RED}Invalid option${NC}"
        exit 1
        ;;
esac

# Confirmation
echo -e "\n${YELLOW}Will draft chapters $START through $END${NC}"
read -p "Continue? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ]; then
    echo "Aborted."
    exit 0
fi

# Progress tracking
SUCCESS=0
FAILED=0
FAILED_CHAPTERS=()

# Main drafting loop
for ((i=$START; i<=$END; i++)); do
    echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Drafting Chapter $i of $END${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    # Check if chapter already exists
    if ls manuscript/ch${i}_*.md 1> /dev/null 2>&1; then
        echo -e "${YELLOW}Warning: Chapter $i already exists${NC}"
        read -p "Create new version? (y/n): " OVERWRITE
        if [ "$OVERWRITE" != "y" ]; then
            echo "Skipping chapter $i"
            continue
        fi
    fi
    
    # Run the draft command
    if claude -p "Please execute the /draft-chapter command for chapter $i. Follow the outline and style guidelines in CLAUDE.md." \
             --allowedTools Read,Write,Edit,MultiEdit \
             --output-format json \
             --output-style scene-weaver \
             2>/dev/null; then
        echo -e "${GREEN}✓ Chapter $i drafted successfully${NC}"
        ((SUCCESS++))
    else
        echo -e "${RED}✗ Failed to draft chapter $i${NC}"
        ((FAILED++))
        FAILED_CHAPTERS+=("$i")
    fi
    
    # Brief pause between chapters
    sleep 2
done

# Summary report
echo -e "\n${GREEN}==================================${NC}"
echo -e "${GREEN}        Draft Summary${NC}"
echo -e "${GREEN}==================================${NC}\n"

echo "Chapters drafted successfully: $SUCCESS"
echo "Chapters failed: $FAILED"

if [ ${#FAILED_CHAPTERS[@]} -gt 0 ]; then
    echo -e "\n${RED}Failed chapters: ${FAILED_CHAPTERS[*]}${NC}"
    echo "You can retry these individually with: /draft-chapter [number]"
fi

# Compile option
if [ "$SUCCESS" -gt 0 ]; then
    echo -e "\n${YELLOW}Compile all drafts into single file?${NC}"
    read -p "(y/n): " COMPILE

    if [ "$COMPILE" == "y" ]; then
        echo "Compiling manuscript..."
        # Clear previous compilation
        > manuscript/full_draft.md
        # Compile chapters in order, picking latest version of each
        for ((j=1; j<=$END; j++)); do
            latest=$(ls -t manuscript/ch${j}_*.md 2>/dev/null | head -1)
            if [ -f "$latest" ]; then
                cat "$latest" >> manuscript/full_draft.md
                echo "" >> manuscript/full_draft.md  # Add spacing between chapters
            fi
        done
        echo -e "${GREEN}✓ Full draft compiled to manuscript/full_draft.md${NC}"

        # Word count
        WC=$(wc -w < manuscript/full_draft.md)
        echo -e "${GREEN}Total word count: $WC${NC}"
    fi
fi

echo -e "\n${GREEN}Draft generation complete!${NC}"
echo "Next steps:"
echo "  1. Review drafts in manuscript/"
echo "  2. Run './revise_all.sh' for line editing"
echo "  3. Run './fact_check_all.sh' for verification"