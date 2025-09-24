---
name: revise-chapter
description: Polish an existing chapter with line editing
arguments:
  chapter:
    description: Chapter number to revise (e.g., 1, 2, 3)
    type: number
    required: true
---

# Revise Chapter Command

This command performs comprehensive line editing on a drafted chapter using the Line Editor agent.

## Process

1. **Load chapter** from manuscript/ch##_*.md (find latest version)
2. **Launch Line Editor agent** for systematic revision
3. **Apply three-pass editing**:
   - Structural: Flow and transitions
   - Line-level: Prose refinement
   - Technical: Grammar and consistency
4. **Track all changes** with editorial notes
5. **Save revised version** as manuscript/ch##_chapter_title_v2.md (increment version)

## Usage

```
/revise-chapter 1
/revise-chapter 7
```

## Editing Focus Areas

### First Pass - Structural
- Paragraph transitions and flow
- Scene break effectiveness
- Opening and closing strength
- Pacing and rhythm
- Information revelation

### Second Pass - Line-Level
- Sentence variety and construction
- Word choice precision
- Redundancy elimination
- Voice consistency
- Clarity enhancement

### Third Pass - Technical
- Grammar and punctuation
- Spelling and typos
- Dialogue formatting
- Style guide adherence
- Consistency checks

## Editorial Notation

The Line Editor will annotate:
```markdown
[ED: Query for author]
[CONSISTENCY: Issue with earlier text]
[STYLE: Alternative suggestion]
[FACTCHECK: Needs verification]
[CRITICAL: Must fix]
```

## Output Files

- Revised chapter: `manuscript/ch01_chapter_title_v2.md`
- Change tracking: `manuscript/edits/ch01_changes.md`
- Author queries: `manuscript/edits/ch01_queries.md`
- Editorial report: `manuscript/edits/ch01_report.md`

## Editorial Report Contents

```markdown
# Editorial Report - Chapter [#]

## Statistics
- Original word count: [#]
- Revised word count: [#]
- Sentences edited: [#]
- Queries for author: [#]

## Major Changes
1. [Description and rationale]
2. [Description and rationale]

## Consistency Issues
- [Issue and resolution]

## Author Queries
1. [Location]: [Query]

## Recommendations
- [Next steps]
```

## Quality Improvements

The revision will address:
- Wordiness and redundancy
- Weak or passive constructions
- Filter words and telling
- Clichés and overused phrases
- Inconsistent character voice
- Pacing and flow issues
- Technical errors

## Revision Tracking

- Keep original: `manuscript/ch01_chapter_title.md`
- Save revision: `manuscript/ch01_chapter_title_v2.md`
- Track changes: `manuscript/edits/ch01_changes.md`
- Version control: Git commits after each revision

## Batch Processing

To revise all drafted chapters:
```bash
for file in manuscript/ch*_*.md; do
  num=$(echo $file | grep -o '[0-9]\+')
  claude "/revise-chapter $num"
done
```

## Integration with Workflow

1. Draft with `/draft-chapter`
2. Revise with `/revise-chapter`
3. Fact-check with `/fact-check`
4. Final review before publication

## Settings

The command respects:
- Style guide in CLAUDE.md
- Genre conventions
- Author voice preferences
- Project-specific terminology