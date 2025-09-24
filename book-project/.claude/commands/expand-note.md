---
name: expand-note
description: Transform a seed idea into a complete story outline
arguments:
  idea:
    description: The seed idea or concept to expand
    type: string
    required: true
---

# Expand Note Command

This command transforms a seed idea into a comprehensive story outline using the Outline Architect agent, with intelligent project configuration based on the detected genre and type.

## Process

1. **Analyze seed idea** for genre, format, and project type
2. **Check CLAUDE.md configuration**
   - If unconfigured, auto-detect and update based on seed analysis
   - If configured, verify alignment with seed idea
3. **Update Voice & Style Guidelines** to match detected genre
4. **Update Project Status** with detected parameters

### Research-First Flow (for Non-Fiction/Technical):
5. **IF non-fiction/technical/business genre detected:**
   - Launch Domain Researcher agent
   - Perform comprehensive topic exploration:
     - Market landscape analysis
     - Audience needs research
     - Core concept mapping
     - Structure discovery
   - Save findings to `research/pre-outline/`
   - Use research to inform outline structure

6. **IF fiction genre detected:**
   - Skip domain research (or make optional)
   - Proceed directly to creative development

### Outline Generation (Research-Informed):
7. **Launch Outline Architect** with:
   - Original seed idea
   - Research findings (if non-fiction)
   - Genre configuration
8. **Develop compelling logline** based on research insights
9. **Create structure** informed by:
   - Natural topic divisions (non-fiction)
   - Three-act structure (fiction)
10. **Generate chapter breakdown** using:
    - Research-discovered topics (non-fiction)
    - Story beats (fiction)
11. **Save outline** and all research artifacts

## Usage

```
/expand-note "A detective discovers that their missing person case is actually their own future disappearance"
```

## Implementation

When executed, this command orchestrates a multi-agent workflow:

### Step 1: Configuration Assessment
1. Read current CLAUDE.md to check Project Status fields
2. If fields contain "[To be specified]" placeholders:
   - Analyze the seed idea to infer genre and parameters
   - Update CLAUDE.md with appropriate configuration

### Step 2: Research Phase (Conditional)
**For Non-Fiction/Technical/Business Projects:**
1. Launch Domain Researcher agent with seed idea
2. Parallel research tasks:
   - WebSearch: Current trends and discussions
   - WebSearch: Common problems and solutions
   - WebFetch: Authoritative resources
   - Grep: Existing documentation
3. Analyze findings to discover:
   - Natural chapter divisions
   - Core concepts and dependencies
   - Market gaps and opportunities
4. Generate `research/pre-outline/domain_analysis.md`

**For Fiction Projects:**
- Skip to Step 3 (or optionally research genre conventions)

### Step 3: Informed Outline Generation
1. Launch Outline Architect agent with:
   - Seed idea
   - Domain research (if completed)
   - Project configuration
2. Create outline based on:
   - Research-discovered structure (non-fiction)
   - Narrative structure (fiction)
3. Save to `manuscript/outline_v1.md`

## Configuration Intelligence

Rather than using rigid keyword detection, the command leverages AI to:

1. **Understand Intent**: Analyze the seed idea's underlying purpose and goals
2. **Infer Context**: Determine whether it's fiction/non-fiction, educational/entertainment, etc.
3. **Match Voice to Purpose**: Select appropriate narrative voice and style
4. **Research If Needed**: For specialized topics, can research genre conventions or market expectations
5. **Apply Best Practices**: Use knowledge of what works for similar projects

### Example Inference Process:
- Seed: "A guide to using AI for writing books"
  → Infers: Technical guide, instructional voice, writer audience, practical examples needed

- Seed: "A detective discovers their case is their own future"
  → Infers: Mystery/thriller fiction, suspenseful voice, general audience, cinematic style

- Seed: "My journey from startup failure to success"
  → Infers: Business memoir, personal/inspirational voice, entrepreneur audience, narrative style

## Output Files

### For Non-Fiction/Technical Projects:
- `research/pre-outline/domain_analysis.md` - Comprehensive research findings
- `research/pre-outline/market_research.md` - Competitive landscape
- `research/pre-outline/concept_map.md` - Knowledge structure
- `manuscript/outline_v1.md` - Research-informed outline
- `manuscript/logline.md` - Positioning statement
- Updated `CLAUDE.md` - Project configuration

### For Fiction Projects:
- `manuscript/outline_v1.md` - Complete story outline
- `manuscript/logline.md` - Logline and premise
- `manuscript/beats_act1.md` - Act 1 beat sheet
- `manuscript/beats_act2.md` - Act 2 beat sheet
- `manuscript/beats_act3.md` - Act 3 beat sheet
- `manuscript/characters.md` - Character bible
- Updated `CLAUDE.md` - Project configuration

## Example Output Structure

The generated outline will include:
- Logline and expanded premise
- Genre and market positioning
- Three-act structure with percentages
- Chapter summaries with scene goals
- Character arc tracking
- Thematic elements and motifs
- Comparable titles analysis

## Enhanced Workflow

The command now intelligently:
1. **Auto-configures** project settings based on your seed idea
2. **Updates CLAUDE.md** with appropriate voice, style, and project details
3. **Ensures consistency** between project type and writing approach
4. **Saves configuration** for all subsequent commands to use

## Notes

- Best used at project inception
- Auto-configuration only happens if Project Status fields are unspecified
- Can be re-run with different ideas to explore alternatives
- Subsequent versions saved as outline_v2.md, outline_v3.md, etc.
- Review and refine the outline before proceeding to drafting
- Configuration changes are preserved for the entire project lifecycle