#!/bin/bash

# Fact Check All Chapters - Batch Verification Script
# This script performs fact-checking on all manuscript chapters

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
NC='\033[0m'

echo -e "${MAGENTA}==================================${NC}"
echo -e "${MAGENTA}    Fact Checking System${NC}"
echo -e "${MAGENTA}==================================${NC}\n"

# Find chapters to check (prefer revised, fallback to draft)
CHAPTERS=()
for revised in manuscript/ch*_revised.md; do
    if [ -f "$revised" ]; then
        CHAPTERS+=("$revised")
    else
        # Check for draft version
        draft="${revised/_revised/_draft}"
        if [ -f "$draft" ]; then
            CHAPTERS+=("$draft")
        fi
    fi
done

if [ ${#CHAPTERS[@]} -eq 0 ]; then
    # Try to find any draft chapters
    CHAPTERS=(manuscript/ch*_draft.md)
    if [ ! -f "${CHAPTERS[0]}" ]; then
        echo -e "${RED}Error: No chapters found to fact-check${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}Found ${#CHAPTERS[@]} chapters to verify${NC}\n"

# Options
echo "Fact-Checking Options:"
echo "1. Full fact-check (all claims)"
echo "2. Quick check (high-priority only)"
echo "3. Technical review focus"
echo "4. Historical accuracy focus"
read -p "Select option (1-4): " MODE

# Set verification depth
case $MODE in
    1) DEPTH="full" ;;
    2) DEPTH="quick" ;;
    3) DEPTH="technical" ;;
    4) DEPTH="historical" ;;
    *) echo -e "${RED}Invalid option${NC}"; exit 1 ;;
esac

echo -e "\n${YELLOW}Starting $DEPTH fact-checking process${NC}"
read -p "Continue? (y/n): " CONFIRM

if [ "$CONFIRM" != "y" ]; then
    echo "Aborted."
    exit 0
fi

# Create research directory structure
mkdir -p research/{sources,factchecks,issues}

# Statistics
TOTAL_FACTS=0
VERIFIED=0
DISPUTED=0
NEEDS_REVIEW=0

# Main fact-checking loop
for chapter in "${CHAPTERS[@]}"; do
    CHAPTER_NUM=$(basename "$chapter" | grep -o '[0-9]\+')
    
    echo -e "\n${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${MAGENTA}Fact-Checking Chapter $CHAPTER_NUM${NC}"
    echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    # Prepare fact-check parameters based on mode
    case $DEPTH in
        "full")
            PROMPT="Perform comprehensive fact-checking on chapter $CHAPTER_NUM. Verify all claims, dates, technical details, and cultural references."
            ;;
        "quick")
            PROMPT="Quick fact-check chapter $CHAPTER_NUM. Focus on critical plot points and major factual claims only."
            ;;
        "technical")
            PROMPT="Technical review of chapter $CHAPTER_NUM. Verify all scientific, medical, legal, and technical details."
            ;;
        "historical")
            PROMPT="Historical accuracy check for chapter $CHAPTER_NUM. Verify dates, events, period details, and anachronisms."
            ;;
    esac
    
    # Run fact-check command
    if claude -p "$PROMPT Use the /fact-check command with web search to verify accuracy." \
             --allowedTools Read,Write,Edit,WebSearch,WebFetch,Grep \
             --output-format json \
             2>/dev/null; then
        
        echo -e "${GREEN}✓ Chapter $CHAPTER_NUM fact-checked${NC}"
        
        # Parse report if available
        REPORT="research/factcheck_ch${CHAPTER_NUM}.md"
        if [ -f "$REPORT" ]; then
            # Extract statistics (simple grep patterns)
            FACTS=$(grep -c "\*\*Claim\*\*:" "$REPORT" 2>/dev/null || echo "0")
            VER=$(grep -c "Status: ✓ Verified" "$REPORT" 2>/dev/null || echo "0")
            DIS=$(grep -c "DISPUTED" "$REPORT" 2>/dev/null || echo "0")
            REV=$(grep -c "Needs further research" "$REPORT" 2>/dev/null || echo "0")
            
            ((TOTAL_FACTS+=FACTS))
            ((VERIFIED+=VER))
            ((DISPUTED+=DIS))
            ((NEEDS_REVIEW+=REV))
            
            echo "  Claims checked: $FACTS"
            echo "  Verified: $VER"
            [ "$DIS" -gt 0 ] && echo -e "  ${YELLOW}Disputed: $DIS${NC}"
            [ "$REV" -gt 0 ] && echo -e "  ${YELLOW}Needs review: $REV${NC}"
        fi
    else
        echo -e "${RED}✗ Failed to fact-check chapter $CHAPTER_NUM${NC}"
    fi
    
    sleep 2
done

# Compile master bibliography
echo -e "\n${YELLOW}Compiling bibliography...${NC}"
if ls research/bibliography_ch*.md 1> /dev/null 2>&1; then
    cat research/bibliography_ch*.md | sort -u > research/master_bibliography.md
    echo -e "${GREEN}✓ Master bibliography created${NC}"
fi

# Summary report
echo -e "\n${MAGENTA}==================================${NC}"
echo -e "${MAGENTA}    Fact-Check Summary${NC}"
echo -e "${MAGENTA}==================================${NC}\n"

echo "Total claims checked: $TOTAL_FACTS"
echo -e "${GREEN}Verified: $VERIFIED${NC}"
[ "$DISPUTED" -gt 0 ] && echo -e "${YELLOW}Disputed: $DISPUTED${NC}"
[ "$NEEDS_REVIEW" -gt 0 ] && echo -e "${YELLOW}Needs further research: $NEEDS_REVIEW${NC}"

if [ "$DISPUTED" -gt 0 ] || [ "$NEEDS_REVIEW" -gt 0 ]; then
    echo -e "\n${YELLOW}Action Required:${NC}"
    echo "Review flagged items in research/factcheck_ch*.md"
    echo "Disputed claims need resolution before publication"
fi

# Generate issues report
if [ "$DISPUTED" -gt 0 ] || [ "$NEEDS_REVIEW" -gt 0 ]; then
    echo -e "\n${YELLOW}Generate consolidated issues report?${NC}"
    read -p "(y/n): " ISSUES
    
    if [ "$ISSUES" == "y" ]; then
        echo "# Fact-Check Issues Report" > research/issues/consolidated_issues.md
        echo "Generated: $(date)" >> research/issues/consolidated_issues.md
        echo "" >> research/issues/consolidated_issues.md
        
        for report in research/factcheck_ch*.md; do
            if [ -f "$report" ]; then
                CHAPTER=$(basename "$report" | grep -o '[0-9]\+')
                if grep -q "DISPUTED\|Needs further research" "$report"; then
                    echo "## Chapter $CHAPTER" >> research/issues/consolidated_issues.md
                    grep -A 3 "DISPUTED\|Needs further research" "$report" >> research/issues/consolidated_issues.md
                    echo "" >> research/issues/consolidated_issues.md
                fi
            fi
        done
        
        echo -e "${GREEN}✓ Issues report: research/issues/consolidated_issues.md${NC}"
    fi
fi

echo -e "\n${GREEN}Fact-checking complete!${NC}"
echo "Next steps:"
echo "  1. Review fact-check reports in research/"
echo "  2. Resolve any disputed claims"
echo "  3. Consult experts for technical review items"
echo "  4. Update manuscript with verified information"