#!/bin/bash

# Setup Co-Author - Template Copying Script
# This script copies the book-project template to create new projects

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m'

# Default project name
PROJECT_NAME="${1:-my-book}"

# Get the script's directory (where the template is)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(dirname "$SCRIPT_DIR")/book-project"

echo -e "${BLUE}${BOLD}==================================${NC}"
echo -e "${BLUE}${BOLD}  Co-Author Toolkit Setup${NC}"
echo -e "${BLUE}${BOLD}==================================${NC}\n"

# Check if template exists
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo -e "${RED}Error: Template directory not found at $TEMPLATE_DIR${NC}"
    echo "Please ensure the book-project template exists."
    exit 1
fi

# Check if destination already exists
if [ -d "$PROJECT_NAME" ]; then
    echo -e "${YELLOW}Warning: Directory '$PROJECT_NAME' already exists${NC}"
    read -p "Overwrite? (y/n): " CONFIRM
    if [ "$CONFIRM" != "y" ]; then
        echo "Setup cancelled."
        exit 0
    fi
    rm -rf "$PROJECT_NAME"
fi

echo -e "${YELLOW}Creating new project: ${BOLD}$PROJECT_NAME${NC}\n"

# Copy template structure
echo "📁 Copying template structure..."
cp -r "$TEMPLATE_DIR" "$PROJECT_NAME"

# Use simple settings by default to avoid validation errors
if [ -f "$PROJECT_NAME/.claude/settings-simple.json" ]; then
    cp "$PROJECT_NAME/.claude/settings-simple.json" "$PROJECT_NAME/.claude/settings.json"
    echo "⚙️  Using simplified settings (no hooks) for compatibility"
fi

# Update project-specific configurations
echo "⚙️  Customizing configuration..."

# Update CLAUDE.md with project name
if [ -f "$PROJECT_NAME/CLAUDE.md" ]; then
    # Update the title
    sed -i.bak "1s/.*/# $PROJECT_NAME - Project Memory \& Co-Authoring Guidelines/" "$PROJECT_NAME/CLAUDE.md"
    rm "$PROJECT_NAME/CLAUDE.md.bak" 2>/dev/null || true
fi

# Update project.json with project name
if [ -f "$PROJECT_NAME/.claude/project.json" ]; then
    # Use a temp file for JSON modification
    cat "$PROJECT_NAME/.claude/project.json" | \
    sed "s/\"name\": \"Book Co-Authoring Toolkit\"/\"name\": \"$PROJECT_NAME\"/" > \
    "$PROJECT_NAME/.claude/project.json.tmp"
    mv "$PROJECT_NAME/.claude/project.json.tmp" "$PROJECT_NAME/.claude/project.json"
fi

# Initialize git repository
echo "📚 Initializing git repository..."
cd "$PROJECT_NAME"
git init --quiet

# Create initial .gitignore
cat > .gitignore << 'EOF'
# Temporary files
*.tmp
*.bak
*~
.DS_Store

# Build outputs
assets/pdf/*
assets/epub/*
assets/docx/*
assets/html/*

# Personal notes
personal_notes/
scratch/

# Environment files
.env
.env.local

# Editor directories
.vscode/
.idea/

# But keep the directory structure
!assets/pdf/.gitkeep
!assets/epub/.gitkeep
!assets/docx/.gitkeep
!assets/html/.gitkeep
EOF

# Create directories if they don't exist and add .gitkeep files
mkdir -p assets/{pdf,epub,docx,html}
touch assets/pdf/.gitkeep
touch assets/epub/.gitkeep
touch assets/docx/.gitkeep
touch assets/html/.gitkeep
touch manuscript/.gitkeep
touch research/.gitkeep

# Initial commit
git add -A
git commit -m "Initial project setup from co-authoring toolkit template" --quiet

cd ..

# Success message
echo -e "\n${GREEN}${BOLD}✅ Project '$PROJECT_NAME' successfully created!${NC}\n"

echo -e "${GREEN}Project Structure:${NC}"
echo "  📂 $PROJECT_NAME/"
echo "  ├── 📝 manuscript/     - Drafts and outlines"
echo "  ├── 🔍 research/       - Notes and citations"
echo "  ├── 📦 assets/         - Exported files"
echo "  ├── 🔧 bin/            - Automation scripts"
echo "  ├── ⚙️  .claude/        - Configuration"
echo "  └── 📋 CLAUDE.md       - Project memory"

echo -e "\n${GREEN}Next Steps:${NC}"
echo "  1. Navigate to project:    ${BOLD}cd $PROJECT_NAME${NC}"
echo "  2. Start Claude Code:      ${BOLD}claude${NC}"
echo "  3. Customize CLAUDE.md with your project details"
echo "  4. Start with an idea:     /expand-note \"your concept\""
echo "  5. Draft first chapter:    /draft-chapter 1"

echo -e "\n${RED}${BOLD}⚠️  IMPORTANT:${NC}"
echo "  You must start Claude Code from within the $PROJECT_NAME directory"
echo "  for all custom agents, commands, and settings to work!"

echo -e "\n${BLUE}Available Commands:${NC}"
echo "  • /expand-note <idea>   - Create outline from idea"
echo "  • /draft-chapter <n>    - Generate chapter draft"
echo "  • /revise-chapter <n>   - Polish with line editing"
echo "  • /fact-check <n>       - Verify facts with sources"
echo "  • /marketing-pack       - Generate promotional materials"

echo -e "\n${BLUE}Automation Scripts:${NC}"
echo "  • ./bin/generate_drafts.sh    - Batch draft chapters"
echo "  • ./bin/revise_all.sh         - Batch line editing"
echo "  • ./bin/fact_check_all.sh     - Comprehensive verification"
echo "  • ./bin/compile_manuscript.sh - Export to multiple formats"

echo -e "\n${YELLOW}Optional: Configure MCP Servers${NC}"
echo "  • claude mcp add brave-search  - Web research"
echo "  • claude mcp add notion        - Note integration"
echo "  • claude mcp add zen-mcp       - Multi-model consensus"

echo -e "\n${GREEN}${BOLD}Happy writing! 📚✨${NC}"