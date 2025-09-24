#!/bin/bash

# Revise All Chapters - Batch Line Editing Script
# This script performs line editing on all drafted chapters

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}==================================${NC}"
echo -e "${BLUE}     Chapter Revision Tool${NC}"
echo -e "${BLUE}==================================${NC}\n"

# Find all chapter files
CHAPTERS=(manuscript/ch*_*.md)

if [ ${#CHAPTERS[@]} -eq 0 ] || [ ! -f "${CHAPTERS[0]}" ]; then
    echo -e "${RED}Error: No chapters found${NC}"
    echo "Please run './generate_drafts.sh' first."
    exit 1
fi

# Get unique chapter numbers and their latest versions
declare -A CHAPTER_MAP
for file in "${CHAPTERS[@]}"; do
    num=$(basename "$file" | grep -o '^ch[0-9]*' | grep -o '[0-9]*')
    if [ -n "$num" ]; then
        # Store the latest version for each chapter
        latest=$(ls -t manuscript/ch${num}_*.md 2>/dev/null | head -1)
        CHAPTER_MAP["$num"]="$latest"
    fi
done

echo -e "${GREEN}Found ${#CHAPTER_MAP[@]} chapters available for revision${NC}\n"

# List chapters
echo "Available chapters:"
for num in $(echo "${!CHAPTER_MAP[@]}" | tr ' ' '\n' | sort -n); do
    echo "  Chapter $num: $(basename "${CHAPTER_MAP[$num]}")"
done

echo -e "\nRevision Options:"
echo "1. Revise all chapters"
echo "2. Revise specific chapters"
echo "3. Revise only unrevised chapters"
read -p "Select option (1-3): " OPTION

case $OPTION in
    1)
        CHAPTERS_TO_REVISE=()
        for num in "${!CHAPTER_MAP[@]}"; do
            CHAPTERS_TO_REVISE+=("${CHAPTER_MAP[$num]}")
        done
        ;;
    2)
        read -p "Enter chapter numbers (space-separated, e.g., '1 3 5'): " -a NUMS
        CHAPTERS_TO_REVISE=()
        for num in "${NUMS[@]}"; do
            file="manuscript/ch${num}_draft.md"
            if [ -f "$file" ]; then
                CHAPTERS_TO_REVISE+=("$file")
            else
                echo -e "${YELLOW}Warning: Chapter $num draft not found${NC}"
            fi
        done
        ;;
    3)
        CHAPTERS_TO_REVISE=()
        for draft in "${DRAFTS[@]}"; do
            revised="${draft/_draft/_revised}"
            if [ ! -f "$revised" ]; then
                CHAPTERS_TO_REVISE+=("$draft")
            fi
        done
        ;;
    *)
        echo -e "${RED}Invalid option${NC}"
        exit 1
        ;;
esac

if [ ${#CHAPTERS_TO_REVISE[@]} -eq 0 ]; then
    echo -e "${GREEN}No chapters need revision${NC}"
    exit 0
fi

# Confirmation
echo -e "\n${YELLOW}Will revise ${#CHAPTERS_TO_REVISE[@]} chapter(s)${NC}"
read -p "Continue? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ]; then
    echo "Aborted."
    exit 0
fi

# Create edits directory if needed
mkdir -p manuscript/edits

# Progress tracking
SUCCESS=0
FAILED=0
TOTAL_EDITS=0

# Main revision loop
for draft in "${CHAPTERS_TO_REVISE[@]}"; do
    # Extract chapter number
    CHAPTER_NUM=$(basename "$draft" | grep -o '[0-9]\+')
    
    echo -e "\n${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Revising Chapter $CHAPTER_NUM${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    # Run the revision command
    if claude -p "Please execute the /revise-chapter command for chapter $CHAPTER_NUM. Apply thorough line editing following the style guide." \
             --allowedTools Read,Edit,MultiEdit,Grep \
             --output-format json \
             --output-style line-editor \
             2>/dev/null; then
        
        echo -e "${GREEN}✓ Chapter $CHAPTER_NUM revised successfully${NC}"
        ((SUCCESS++))
        
        # Check for editorial report
        if [ -f "manuscript/edits/ch${CHAPTER_NUM}_report.md" ]; then
            EDITS=$(grep -o "Sentences edited: [0-9]*" "manuscript/edits/ch${CHAPTER_NUM}_report.md" | grep -o '[0-9]*' || echo "0")
            ((TOTAL_EDITS+=EDITS))
            echo "  Edits made: $EDITS"
        fi
    else
        echo -e "${RED}✗ Failed to revise chapter $CHAPTER_NUM${NC}"
        ((FAILED++))
    fi
    
    sleep 2
done

# Summary report
echo -e "\n${BLUE}==================================${NC}"
echo -e "${BLUE}      Revision Summary${NC}"
echo -e "${BLUE}==================================${NC}\n"

echo "Chapters revised: $SUCCESS"
echo "Chapters failed: $FAILED"
echo "Total edits made: $TOTAL_EDITS"

# Check for queries
QUERIES=$(find manuscript/edits -name "*_queries.md" 2>/dev/null | wc -l)
if [ "$QUERIES" -gt 0 ]; then
    echo -e "\n${YELLOW}Editorial queries found in $QUERIES file(s)${NC}"
    echo "Review queries in manuscript/edits/"
fi

# Compile option
if [ "$SUCCESS" -gt 0 ]; then
    echo -e "\n${YELLOW}Compile revised chapters?${NC}"
    read -p "(y/n): " COMPILE
    
    if [ "$COMPILE" == "y" ]; then
        echo "Compiling revised manuscript..."
        # Clear previous compilation
        > manuscript/full_revised.md
        # Compile chapters in order, picking latest version
        for num in $(echo "${!CHAPTER_MAP[@]}" | tr ' ' '\n' | sort -n); do
            latest=$(ls -t manuscript/ch${num}_*.md 2>/dev/null | head -1)
            if [ -f "$latest" ]; then
                cat "$latest" >> manuscript/full_revised.md
                echo "" >> manuscript/full_revised.md  # Add spacing
            fi
        done
        echo -e "${GREEN}✓ Compiled to manuscript/full_revised.md${NC}"

        # Word count comparison
        REVISED_WC=$(wc -w < manuscript/full_revised.md)
        if [ -f "manuscript/full_draft.md" ]; then
            DRAFT_WC=$(wc -w < manuscript/full_draft.md)
            DIFF=$((REVISED_WC - DRAFT_WC))
            echo "Word count: $REVISED_WC (change: $DIFF)"
        else
            echo "Word count: $REVISED_WC"
        fi
    fi
fi

echo -e "\n${GREEN}Revision complete!${NC}"
echo "Next steps:"
echo "  1. Review editorial reports in manuscript/edits/"
echo "  2. Address any queries flagged by the editor"
echo "  3. Run './fact_check_all.sh' for verification"
echo "  4. Generate marketing materials with /marketing-pack"