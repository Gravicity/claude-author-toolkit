---
description: Initialize a complete co-authoring toolkit for book projects
argument-hint: [project-name]
---

# Setup Co-Author Command

This command scaffolds a complete co-authoring toolkit by copying the template from `book-project/` to a new directory with your chosen name.

## What This Command Creates

### Directory Structure
```
[project_name]/
├── manuscript/        # Drafts, outlines, revisions
│   └── outlines/      # Multiple outline versions
├── research/          # Notes, citations, fact-checks
├── assets/            # Exported files (PDF, EPUB)
├── bin/               # Automation scripts
├── .claude/
│   ├── commands/      # Custom slash commands
│   ├── agents/        # Specialized sub-agents
│   ├── output-styles/ # Communication styles
│   └── settings.json  # Permissions and hooks
└── CLAUDE.md          # Project memory and guidelines
```

### Sub-Agents Created
1. **Domain Researcher** - Pre-outline domain exploration and knowledge gathering
2. **Outline Architect** - Story structure and planning
3. **Researcher** - Fact-checking with web search
4. **Scene Weaver** - Creative chapter drafting
5. **Line Editor** - Prose refinement and consistency
6. **Marketing Manager** - Commercial positioning

### Custom Commands
- `/expand-note <idea>` - Transform ideas into outlines
- `/draft-chapter <n>` - Generate chapter drafts
- `/revise-chapter <n>` - Line-edit chapters
- `/fact-check <n>` - Verify facts with sources
- `/marketing-pack` - Create promotional materials

### Automation Scripts
- `generate_drafts.sh` - Batch draft all chapters
- `revise_all.sh` - Batch line-editing
- `fact_check_all.sh` - Comprehensive verification
- `compile_manuscript.sh` - Export to PDF/EPUB/DOCX

## Usage

```bash
# Basic setup (creates "my-book" directory)
/setup-coauthor

# Custom project name
/setup-coauthor my-novel

# Multiple projects
/setup-coauthor thriller-project
/setup-coauthor romance-novel
/setup-coauthor tech-manual
```

## IMPORTANT: Activating Your Project

After creating your project, you must **start Claude Code from within the project directory** for all the custom settings, agents, and commands to work:

```bash
# Navigate to your new project
cd [project_name]

# Start Claude Code from within the project
claude

# Now all custom commands will work:
/expand-note "A detective discovers their case is their own future"
/draft-chapter 1
/revise-chapter 1
```

⚠️ **Note**: The custom agents, commands, and settings only work when Claude Code is launched from inside your project directory. The `.claude/` folder must be in the current working directory.

## Implementation

When executed, this command will:

1. **Check if template exists** at `book-project/`
2. **Create new directory** with specified name (or "my-book" default)
3. **Copy entire template structure** including:
   - All directories (manuscript/, research/, assets/, bin/)
   - Configuration files (.claude/ with all subdirectories)
   - CLAUDE.md template
   - All agents, commands, and output styles
   - Automation scripts
4. **Customize the new project** by updating paths and project name
5. **Initialize git repository** in the new directory
6. **Display setup confirmation** with next steps

### Quick Copy Method

You can also use the shell script directly:
```bash
./bin/setup_coauthor.sh [project-name]
```

This creates a complete copy of the template with your specified name, allowing you to quickly spin up multiple book projects:
- Each project is independent
- All have the same powerful toolkit
- Customize each for different genres/styles

## Post-Setup Configuration

### 1. Customize CLAUDE.md
- Set your genre and target audience
- Define narrative voice preferences
- Specify POV and tense
- Add project-specific guidelines

### 2. Register MCP Servers (Optional)
```bash
# For web research
claude mcp add brave-search

# For Notion integration
claude mcp add notion

# For multi-model consensus
claude mcp add zen-mcp
```

### 3. Adjust Permissions
Edit `.claude/settings.json` to:
- Change default editing mode
- Modify tool permissions
- Configure automation hooks
- Set output styles

### 4. Genre Customization
The toolkit adapts to different genres:
- **Literary Fiction**: Emphasis on prose style
- **Commercial Fiction**: Focus on pacing
- **Non-Fiction**: Research and citation priority
- **Young Adult**: Age-appropriate voice

## Workflow Overview

### Phase 1: Planning
1. Use `/expand-note` to develop your concept
2. Review and refine the outline
3. Create character bibles and world-building docs

### Phase 2: Drafting
1. Run `/draft-chapter` for each chapter
2. Or use `./bin/generate_drafts.sh` for batch processing
3. Maintain consistent voice with output styles

### Phase 3: Revision
1. Apply `/revise-chapter` for line editing
2. Run `/fact-check` for accuracy
3. Address editorial queries and notes

### Phase 4: Publishing
1. Generate marketing materials with `/marketing-pack`
2. Export manuscript with `./bin/compile_manuscript.sh`
3. Create promotional content for launch

## Features

### Context Management
- Project memory persists across sessions
- Sub-agents prevent context bloat
- Clear separation of concerns

### Quality Assurance
- Automated style checking with proselint
- Fact verification with web search
- Consistency tracking across chapters
- Git integration for version control

### Flexibility
- Modular design for customization
- Genre-specific adaptations
- Platform-agnostic export options
- Headless mode for automation

## Troubleshooting

### If Commands Don't Work
1. Ensure you're in the project directory
2. Check that `.claude/` exists
3. Verify command files have correct format

### For Permission Issues
1. Review `.claude/settings.json`
2. Adjust `allow` and `deny` lists
3. Change `defaultMode` if needed

### MCP Server Setup
1. Install servers before registering
2. Check server documentation for API keys
3. Test with simple queries first

## Best Practices

1. **Commit Often**: The toolkit auto-commits manuscript changes
2. **Review Reports**: Check editorial and fact-check reports
3. **Iterate**: Use multiple outline versions before drafting
4. **Batch Process**: Use shell scripts for efficiency
5. **Maintain Style**: Keep CLAUDE.md updated with preferences

## Next Steps After Setup

1. Define your project in CLAUDE.md
2. Create your first outline with `/expand-note`
3. Set up any needed MCP servers
4. Begin drafting or explore the toolkit
5. Customize agents and commands as needed

---

*Based on "Designing the Ultimate Claude Code Co‑Authoring Toolkit" by Branch*