# Claude Author Toolkit

A comprehensive co-authoring toolkit for creative writing with Claude Code. This toolkit provides specialized agents, custom commands, and automation scripts to streamline the entire authoring process from ideation to publication.

## Quick Start

### Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/claude-author-toolkit.git
cd claude-author-toolkit
```

2. Create a new book project:
```bash
# Using the setup script
./bin/setup_coauthor.sh my-novel

# Or copy the template manually
cp -r book-project my-novel
cd my-novel
git init
```

3. Start Claude Code from within your project:
```bash
cd my-novel
claude
```

## What's Included

### 6 Specialized AI Agents

1. **Domain Researcher** - Pre-outline domain exploration and knowledge gathering
2. **Outline Architect** - Story structure and chapter planning
3. **Researcher** - Fact-checking and citation management
4. **Scene Weaver** - Creative chapter drafting with consistent voice
5. **Line Editor** - Prose refinement and consistency checking
6. **Marketing Manager** - Commercial positioning and promotional content

### Custom Commands

When you start Claude Code from within your project directory, these commands become available:

- `/setup-coauthor [name]` - Create a new writing project
- `/expand-note <idea>` - Transform ideas into structured outlines
- `/draft-chapter <n>` - Generate chapter drafts
- `/revise-chapter <n>` - Line-edit and polish chapters
- `/fact-check <n>` - Verify facts with web sources
- `/marketing-pack` - Generate promotional materials

### Automation Scripts

Batch processing scripts for efficient workflow:

- `generate_drafts.sh` - Draft all chapters in sequence
- `revise_all.sh` - Batch line-editing across manuscript
- `fact_check_all.sh` - Comprehensive fact verification
- `compile_manuscript.sh` - Export to PDF/EPUB/DOCX formats

### Project Structure

```
[project_name]/
├── manuscript/        # Drafts, outlines, revisions
│   └── outlines/      # Multiple outline versions
├── research/          # Notes, citations, fact-checks
├── assets/            # Exported files (PDF, EPUB, HTML)
├── bin/               # Automation scripts
├── .claude/
│   ├── agents/        # AI agent configurations
│   ├── commands/      # Custom slash commands
│   ├── output-styles/ # Voice and tone settings
│   └── settings.json  # Permissions and hooks
└── CLAUDE.md          # Project memory and guidelines
```

## Workflow

### Phase 1: Planning
1. Use `/expand-note` to develop your concept
2. Review and refine the generated outline
3. Create character bibles and world-building documents

### Phase 2: Drafting
1. Run `/draft-chapter` for each chapter
2. Or use `./bin/generate_drafts.sh` for batch processing
3. Maintain consistent voice with output styles

### Phase 3: Revision
1. Apply `/revise-chapter` for line editing
2. Run `/fact-check` for accuracy verification
3. Address editorial queries and notes

### Phase 4: Publishing
1. Generate marketing materials with `/marketing-pack`
2. Export manuscript with `./bin/compile_manuscript.sh`
3. Create promotional content for launch

## Features

### Context Management
- Project memory persists across Claude Code sessions
- Sub-agents prevent context bloat
- Clear separation of concerns between agents
- Git integration for version control

### Quality Assurance
- Automated style checking
- Fact verification with web search
- Consistency tracking across chapters
- Editorial report generation

### Export Options
- PDF generation with professional formatting
- EPUB for e-readers
- DOCX for traditional publishing
- HTML for web serialization

## Customization

### Genre Adaptation
The toolkit adapts to different genres. Edit `CLAUDE.md` in your project to specify:
- **Literary Fiction**: Emphasis on prose style and thematic depth
- **Commercial Fiction**: Focus on pacing and plot hooks
- **Non-Fiction**: Research depth and citation management
- **Young Adult**: Age-appropriate voice and themes

### Voice Configuration
Output styles in `.claude/output-styles/` control:
- Narrative voice and POV
- Sentence structure preferences
- Vocabulary complexity
- Genre conventions

### Permission Settings
Edit `.claude/settings.json` to:
- Control which tools agents can use
- Set default editing modes
- Configure automation hooks
- Manage file access permissions

## Optional: MCP Servers

Enhance capabilities with Model Context Protocol servers:

```bash
# Web research
claude mcp add brave-search

# Note management
claude mcp add notion

# Multi-model consensus
claude mcp add zen-mcp
```

## Requirements

- Claude Code CLI installed
- Git for version control
- (Optional) Pandoc for document conversion
- (Optional) proselint for style checking

## Best Practices

1. **Commit Often**: The toolkit can auto-commit manuscript changes
2. **Review Reports**: Check editorial and fact-check reports regularly
3. **Iterate on Outlines**: Use multiple outline versions before drafting
4. **Batch Process**: Use shell scripts for efficiency
5. **Maintain CLAUDE.md**: Keep project guidelines updated

## Example Usage

```bash
# Create a new thriller novel project
./bin/setup_coauthor.sh thriller-project
cd thriller-project
claude

# In Claude Code:
/expand-note "A detective discovers their case files predict future crimes"
/draft-chapter 1
/revise-chapter 1
/fact-check 1

# Batch operations
./bin/generate_drafts.sh
./bin/compile_manuscript.sh
```

## Troubleshooting

### Commands Not Working?
1. Ensure you're in the project directory
2. Check that `.claude/` directory exists
3. Verify Claude Code was started from project root

### Permission Issues?
1. Review `.claude/settings.json`
2. Check file permissions in project directory
3. Ensure git is properly initialized

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

MIT License - See LICENSE file for details

## Acknowledgments

Based on "Designing the Ultimate Claude Code Co‑Authoring Toolkit" by Branch

---

*Happy writing! Transform your ideas into published works with the power of AI collaboration.*