# book-project - Project Memory & Co-Authoring Guidelines

## Mission Statement
This project creates compelling long-form content through iterative collaboration between human creativity and AI assistance. We aim to produce market-ready manuscripts with strong narrative voice, factual accuracy, and commercial appeal.

## Key Features & Innovations

### Intelligent Genre Detection
- `/expand-note` automatically detects project type from seed idea
- Configures voice, style, and workflow accordingly
- No manual setup required for most projects

### Research-First Architecture (Non-Fiction)
- Domain research BEFORE outline creation
- Research discovers natural chapter structure
- Parallel WebSearch for comprehensive coverage
- Market gap analysis ensures unique value

### Adaptive Writing System
- Scene Weaver adapts to project configuration
- Fiction: Sensory-rich narrative approach
- Non-fiction: Clear, instructional approach
- Technical: Step-by-step tutorial format

### Configuration Cascade
- Initial setup propagates through all commands
- Agents check and respect CLAUDE.md settings
- Consistent voice across entire project

## Voice & Style Guidelines

### Narrative Voice
- **Primary Voice**: [To be specified - will be auto-configured based on genre]
- **Prose Style**: [To be specified - will be set by expand-note command]

### Writing Standards
- **Point of View**: [To be specified per project]
- **Tense**: [To be specified per project]
- **Dialogue**: [To be specified based on genre]
- **Description**: [To be specified based on genre]
- **Pacing**: [To be specified based on genre]

## Structural Conventions

### Character Bible Development

#### For Fiction Projects
The Outline Architect generates `manuscript/characters.md` containing:
- **Protagonist Profile**: Goals, flaws, backstory, arc
- **Antagonist Profile**: Motivations, methods, relationship to protagonist
- **Supporting Cast**: Role in story, relationship dynamics
- **Character Voice Notes**: Speech patterns, vocabulary, mannerisms
- **Arc Tracking**: How each character changes through the story

#### For Non-Fiction Projects (When Applicable)
Character profiles enhance reader connection:
- **Memoir/Biography**: Real person profiles with:
  - Key life events and timeline
  - Personality traits from research
  - Relationships and influences
- **Case Study Books**: Profile key figures:
  - Background and credentials
  - Role in the case study
  - Lessons from their experience
- **How-To Guides**: Reader personas:
  - Skill level and background
  - Common challenges they face
  - Success stories to feature

Generate with: `/expand-note` (auto-generates based on genre) or manual creation

### Chapter Structure Templates

#### For Technical/How-To Chapters
```
Chapter [N]: [Title]
===================
- Problem/Challenge Introduction
- Why This Matters (reader motivation)
- Core Concepts (theory/background)
- Step-by-Step Implementation
- Common Pitfalls & Solutions
- Practical Exercise
- Key Takeaways
- Next Steps
```

#### For Fiction/Narrative Chapters
```
Chapter [N]: [Title]
===================
- Opening Hook (1-2 paragraphs)
- Scene 1: [Purpose/conflict]
  - Beat 1: [Action/dialogue]
  - Beat 2: [Reaction/consequence]
  - Beat 3: [Escalation/reversal]
- Scene 2: [Development]
- Scene 3: [Resolution/cliffhanger]
- Chapter Notes: [Themes, foreshadowing, callbacks]
```

### Story Architecture
- **Three-Act Structure**:
  - Act I (25%): Setup, inciting incident, first plot point
  - Act II (50%): Rising action, midpoint reversal, complications
  - Act III (25%): Crisis, climax, resolution
- **Scene Requirements**: Each scene must advance plot OR develop character (preferably both)
- **Cliffhangers**: End chapters on questions, revelations, or danger

## Research & Fact-Checking

### Research-First Approach (Non-Fiction)
**Pre-Outline Research** (Domain Researcher):
- Market landscape analysis
- Audience pain points discovery
- Core concept mapping
- Natural structure identification
- Competitive gap analysis

**Research Organization**:
```
research/
├── pre-outline/           # Domain exploration
│   ├── domain_analysis.md
│   ├── market_research.md
│   └── concept_map.md
├── chapter_research/      # Chapter-specific deep dives
└── sources/              # Bibliography & citations
```

### Verification Protocol
- Mark uncertain facts with `[FACTCHECK: topic]`
- Include source citations in format: `[Source: Author, Title, Year, Page]`
- Flag anachronisms with `[ANACHRONISM CHECK]`
- Technical details require `[TECHNICAL REVIEW: field]`

### Research Guidelines
- Use parallel WebSearch for efficiency
- Prioritize primary sources when available
- Cross-reference controversial claims
- Maintain research notes in `/research/` directory
- Research BEFORE outlining (non-fiction)
- Update bibliography after each research session

## Working Agreements

### Research-First Workflow (Non-Fiction/Technical)
1. **Ideation**: Seed idea → Genre detection
2. **Research**: Domain exploration → Market analysis → Audience needs
3. **Character Development** (if applicable):
   - For memoirs/biographies: Real person profiles from research
   - For case-study books: Key figures from examples
   - For how-to guides: Reader personas and expert profiles
   - Save to `manuscript/characters.md`
4. **Informed Planning**: Research findings → Natural structure → Outline
5. **Drafting**: Research-backed composition → Assembly
6. **Revision**: Developmental edit → Line edit → Proofread
7. **Polish**: Fact-check → Continuity → Final read

### Creative Workflow (Fiction)
1. **Ideation**: Brainstorm → Logline → Premise
2. **Character Development**:
   - Create protagonist/antagonist profiles
   - Develop supporting cast
   - Define character arcs aligned with plot
   - Document backstories, motivations, flaws
   - Save to `manuscript/characters.md`
3. **Planning**: Outline → Chapter summaries → Scene beats
4. **Drafting**: Scene-by-scene composition → Assembly
5. **Revision**: Developmental edit → Line edit → Proofread
6. **Polish**: Continuity → Final read

### Collaboration Protocol
- Save work incrementally with descriptive commit messages
- Maintain version history for major drafts
- Use comments for editorial queries: `[ED: question?]`
- Track changes in `manuscript/changelog.md`

### Quality Standards
- **First Draft**: Focus on story completion, not perfection
- **Second Draft**: Address structure, pacing, character arcs
- **Third Draft**: Polish prose, dialogue, descriptions
- **Final Draft**: Grammar, consistency, formatting

## File Naming Conventions
- First draft: `manuscript/ch01_chapter_title.md`
- Subsequent drafts: `manuscript/ch01_chapter_title_v2.md`
- Scenes: `manuscript/scenes/act1_scene03.md`
- Research: `research/topic_YYYYMMDD.md`
- Outlines: `manuscript/outline_v[N].md`

## Project Configuration

**Note**: Project metadata is stored in `.claude/project.json` for reference. The actual Claude Code settings are in `.claude/settings.json`.

## Command Quick Reference

### Core Commands (Enhanced)
- `/expand-note <idea>` - Auto-detects genre → Research (if non-fiction) → Informed outline
- `/draft-chapter <n>` - Uses research + outline to generate chapter
- `/revise-chapter <n>` - Polish chapter n with line editor
- `/fact-check <n>` - Verify facts and add citations
- `/marketing-pack` - Generate blurb, tagline, pitch

### Research Commands (New)
- `/research-topic <topic>` - Deep dive on specific topic
- `/research-all` - Pre-research entire book before drafting

### Sub-Agents (Updated)
- `@domain-researcher` - Pre-outline domain exploration (NEW)
- `@outline-architect` - Structure and planning (research-aware)
- `@researcher` - Fact-checking and verification
- `@scene-weaver` - Draft composition (adaptive to genre)
- `@line-editor` - Style and polish
- `@marketing-manager` - Commercial materials

### Output Styles
- `/output-style outline-architect` - Strategic planning mode
- `/output-style scene-weaver` - Creative drafting mode
- `/output-style line-editor` - Editorial refinement mode
- `/output-style marketing-manager` - Promotional content mode

## Project Status
- **Current Phase**: [To be specified]
- **Target Word Count**: [To be specified]
- **Deadline**: [To be specified]
- **Genre**: [To be specified]
- **Target Audience**: [To be specified]
- **Distribution**: [To be specified]
- **Purpose**: [To be specified]

---
*Last Updated: [Auto-update via hook]*