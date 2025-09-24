---
name: fact-check
description: Verify facts and add research citations to a chapter
arguments:
  chapter:
    description: Chapter number to fact-check (e.g., 1, 2, 3)
    type: number
    required: true
---

# Fact Check Command

This command performs comprehensive fact-checking on a chapter using the Researcher agent with web search capabilities.

## Process

1. **Load chapter** from manuscript/
2. **Launch Researcher agent** with web access
3. **Identify claims** requiring verification
4. **Search and verify** using multiple sources
5. **Insert markers** and citations
6. **Generate research report**
7. **Save annotated version**

## Usage

```
/fact-check 1
/fact-check 12
```

## Verification Scope

### Historical Accuracy
- Dates and timelines
- Historical events and figures
- Period-appropriate details
- Cultural and social contexts
- Technology and artifacts

### Technical Details
- Scientific facts and theories
- Medical and legal accuracy
- Geographic locations
- Procedural correctness
- Industry-specific terms

### Cultural Elements
- Languages and dialects
- Customs and traditions
- Food and clothing
- Architecture and design
- Social structures

## Annotation System

The Researcher will add:
```markdown
[VERIFIED: Mozart was born in 1756 | Source: Grove Music Online]
[FACTCHECK: Claim about quantum entanglement needs verification]
[DISPUTED: Historical accounts vary | Sources: Smith 2019, Jones 2020]
[ANACHRONISM: Zippers not invented until 1913]
[TECHNICAL: Medical procedure needs expert review]
```

## Research Standards

- **Minimum 2 sources** for standard facts
- **3+ sources** for controversial claims
- **Primary sources** preferred for historical events
- **Academic sources** for technical content
- **Expert validation** for specialized fields

## Output Files

- Annotated chapter: `manuscript/ch01_factchecked.md`
- Research notes: `research/factcheck_ch01.md`
- Bibliography: `research/bibliography_ch01.md`
- Issues log: `research/issues_ch01.md`

## Research Report Format

```markdown
# Fact-Check Report - Chapter [#]

## Summary
- Total claims checked: [#]
- Verified: [#]
- Disputed: [#]
- Needs further research: [#]

## Verified Facts
1. **Claim**: [Original text]
   **Sources**: [Citations]
   **Status**: ✓ Verified

## Disputed Information
1. **Claim**: [Original text]
   **Sources**: [Conflicting sources]
   **Recommendation**: [Suggested resolution]

## Research Needed
1. **Topic**: [Area requiring research]
   **Reason**: [Why verification is difficult]
   **Suggested approach**: [Next steps]

## Anachronisms Found
1. **Issue**: [Anachronistic element]
   **Correct period**: [When it actually existed]
   **Suggestion**: [Period-appropriate alternative]
```

## Source Quality Tiers

### Tier 1 (Preferred)
- Academic journals and books
- Primary historical documents
- Government databases
- Expert interviews

### Tier 2 (Acceptable)
- Reputable news organizations
- Established encyclopedias
- Professional associations
- Museum collections

### Tier 3 (Verify with additional sources)
- Wikipedia (as starting point)
- Popular books
- Blog posts by experts
- Documentary films

## Web Search Strategy

The Researcher agent will:
1. Formulate targeted search queries
2. Prioritize authoritative domains
3. Cross-reference multiple sources
4. Check publication dates
5. Verify author credentials
6. Note conflicting information

## Citation Format

```markdown
[Source: Author Last, First. "Title." Publication, Date, URL/Page]
[Source: Organization. "Document Title." Date. URL. Accessed Date]
```

## Batch Processing

Fact-check all chapters:
```bash
for i in {1..20}; do
  claude "/fact-check $i"
done
```

## Integration Notes

- Run after `/revise-chapter` for clean text
- Review report before finalizing
- Update manuscript with verified facts
- Maintain master bibliography
- Flag items for expert consultation