---
name: draft-chapter
description: Generate a complete chapter draft from the outline
arguments:
  chapter:
    description: Chapter number to draft (e.g., 1, 2, 3)
    type: number
    required: true
---

# Draft Chapter Command

This command generates a full chapter draft based on the outline using the Scene Weaver agent.

## Process

1. **Read project configuration** from CLAUDE.md
2. **Read the current outline** from manuscript/outline_v*.md
3. **Check for existing research** (for non-fiction projects):
   - Look for `research/pre-outline/domain_analysis.md`
   - Look for `research/chapter_research/ch##_research.md`
4. **Extract chapter details** for the specified chapter number
5. **Launch Scene Weaver agent** with:
   - Chapter requirements from outline
   - Domain research (if available)
   - Project voice/style configuration
6. **Draft content** appropriate to genre:
   - Fiction: Scene-based narrative
   - Non-fiction: Concept-based exposition
   - Technical: Tutorial-based instruction
7. **Save draft** to manuscript/ch##_chapter_title.md

## Usage

```
/draft-chapter 1
/draft-chapter 5
```

## Implementation Steps

1. Verify outline exists in manuscript/
2. Parse chapter requirements:
   - Scene goals and conflicts
   - POV character
   - Key plot points
   - Emotional beats
3. Apply project style guidelines:
   - Narrative voice settings
   - Genre conventions
   - Prose style preferences
4. Generate complete chapter with:
   - Opening hook
   - Scene progression
   - Sensory details
   - Character interactions
   - Chapter-ending hook
5. Save with appropriate formatting

## Output Format

```markdown
# Chapter [#]: [Title]

[Opening paragraph with strong hook]

[Scene 1 content with sensory details and character development]

***

[Scene 2 content advancing plot/character]

***

[Scene 3 content building to chapter climax]

[Closing paragraph with cliffhanger or emotional resonance]

---
*Draft completed: [timestamp]*
*Words: [count]*
*Scenes: [count]*
```

## Quality Checks

The Scene Weaver agent will ensure:
- Consistent POV throughout chapter
- Genre-appropriate pacing
- Sensory details in each scene
- Dialogue that sounds natural
- Plot advancement or character development
- Compelling opening and closing

## File Management

- First draft: `manuscript/ch01_chapter_title.md`
- Subsequent drafts: `manuscript/ch01_chapter_title_v2.md`
- Alternative versions: `manuscript/drafts/ch01_chapter_title_alt.md`
- Scene excerpts: `manuscript/scenes/ch01_scene1.md`

## Batch Processing

For multiple chapters:
```bash
for i in {1..20}; do
  claude "/draft-chapter $i"
done
```

## Integration Notes

- Requires completed outline in manuscript/
- Follows style guide in CLAUDE.md
- Can request specific tone with: `/output-style scene-weaver`
- Mark sections needing research with [FACTCHECK]
- Flag continuity concerns with [CONTINUITY]