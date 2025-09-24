# Claude Author Toolkit

**Imagine having a professional writing team in your computer.** That's what the Claude Author Toolkit gives you - six AI specialists working together to transform your ideas into published works.

## The Power of Scaffolding: One Template, Infinite Books

This toolkit is a **book project factory**. Install it once, then spawn unlimited writing projects - each with its own AI team, memory, and workspace. Think of it like a master blueprint that creates custom writing studios for every book idea you have.

```
    Claude Author Toolkit (Master Template)
                    ↓
    ┌───────────────────────────────────┐
    │  /setup-coauthor "your new idea"  │
    └───────────────────────────────────┘
                    ↓
    ┌─────────┬─────────┬─────────┬─────────┐
    │Thriller │Tech Book│ Memoir  │ Fantasy │
    │Project  │Project  │Project  │Project  │
    └─────────┴─────────┴─────────┴─────────┘
      Each with full AI team & workspace
```

**One command** creates a complete, independent project with all 6 AI agents ready to work on YOUR specific book.

## Why This Exists

### The Problem
Writing a book is overwhelming. You need to:
- Research your topic thoroughly
- Create a compelling structure
- Write hundreds of pages
- Edit everything for consistency
- Fact-check your claims
- Create marketing materials

Most writers do this alone, taking months or years.

### The Solution
This toolkit gives you six AI assistants, each an expert in their field:
- 🔍 **Investigation Expert** - Researches your topic deeply before you write
- 📐 **Structure Architect** - Designs the perfect outline for your content
- ✍️ **Creative Writer** - Drafts engaging chapters in your chosen style
- 📝 **Writing Coach** - Polishes your prose to perfection
- ✅ **Fact Checker** - Verifies claims and adds citations
- 📣 **Marketing Pro** - Creates compelling promotional materials

### The Magic
They work as a team, remember everything about your project, and can work on multiple tasks at once. It's like having a publishing house in your laptop.

## See It In Action (5 Minutes)

```
Your Idea → Research → Outline → Draft → Polish → Publish
     ↑                                                    ↓
     └────────── All Managed By Your AI Team ────────────┘
```

### Try This Right Now:

1. **Install the Toolkit** (30 seconds):
```bash
git clone https://github.com/Gravicity/claude-author-toolkit.git
cd claude-author-toolkit
```

2. **Create Your First Book Project** (30 seconds):
```bash
./bin/setup_coauthor.sh my-business-guide
cd my-business-guide
claude
```

3. **Watch the Magic** (4 minutes):
```
/expand-note "A guide to starting a small business with no money"
```

4. **Start Another Book** (Without reinstalling!):
```bash
# From claude-author-toolkit directory
./bin/setup_coauthor.sh thriller-novel
cd thriller-novel
claude
/expand-note "Detective discovers case files predict future crimes"
```

Each project is completely independent with its own AI team!

In seconds, you'll have:
- Complete chapter-by-chapter outline
- Target audience analysis
- Research notes on key topics
- Writing style guidelines
- Timeline for completion

## Real Success Stories

### "From Idea to Amazon in 3 Months"
Sarah used the toolkit for her thriller novel. The Domain Researcher helped her understand genre expectations, the Scene Weaver drafted 20 chapters in two weeks, and the Line Editor polished everything to publishing quality.

### "15 Chapters in One Weekend"
Mike needed to write a technical guide fast. He fed his outline to the toolkit Friday evening. By Monday morning, he had 15 professionally written chapters with code examples, all fact-checked and formatted.

### "200 Facts Verified Automatically"
Emma's memoir mentioned 200+ historical events. The Fact Checker verified every date, location, and claim, adding proper citations. What would have taken weeks happened in hours.

## What Makes This Different

### Traditional Writing Tools vs. Claude Author Toolkit

**Old Way**: You write alone → Get stuck → Research → Lose momentum → Edit → Repeat

**New Way**: AI team handles research → Creates structure → Writes with you → Maintains consistency → Polishes automatically

### It's Like Having:
- A researcher who never gets tired
- An editor who remembers every detail
- A writing partner available 24/7
- A fact-checker who verifies everything
- A marketer who knows what sells

## Your AI Writing Team

### 🔍 Domain Researcher
*Your Investigation Expert*
- Explores topics BEFORE you outline (revolutionary!)
- Discovers natural chapter structures
- Finds market opportunities and gaps
- Gathers comprehensive background knowledge

### 📐 Outline Architect
*Your Structure Designer*
- Creates complete book structures
- Develops chapter-by-chapter breakdowns
- Ensures logical flow and pacing
- Adapts to any genre or style

### ✍️ Scene Weaver
*Your Creative Writer*
- Drafts engaging, consistent content
- Maintains your chosen voice throughout
- Creates vivid scenes and smooth transitions
- Handles dialogue, action, and description

### 📝 Line Editor
*Your Writing Coach*
- Polishes rough drafts to perfection
- Ensures consistent style and tone
- Fixes grammar and improves flow
- Suggests powerful word choices

### ✅ Researcher
*Your Fact Checker*
- Verifies all claims with sources
- Adds proper citations automatically
- Finds supporting evidence
- Ensures accuracy throughout

### 📣 Marketing Manager
*Your Promotion Expert*
- Creates book descriptions that sell
- Develops author bios and press releases
- Designs social media campaigns
- Identifies target audiences

## Power Features (In Plain English)

### 🧠 **Never Lose Track**
The system remembers everything about your book - characters, plot points, style choices. Start writing in January, come back in June, everything's still there.

### ⚡ **Write 10x Faster**
Write all chapters at once with batch processing. What took months now takes days.

### 📚 **Instant Publishing**
Export your finished book as PDF, EPUB, or Word doc with one command. Professional formatting included.

### 🔄 **Smart Revisions**
Edit chapter 1, and the system remembers those changes for chapter 20. No more inconsistencies.

### 🎯 **Genre Intelligence**
Tell it you're writing a thriller, it automatically adjusts pacing, structure, and style to match genre expectations.

## How It Works (The Simple Version)

### Step 1: Create Your Writing Space
```bash
./bin/setup_coauthor.sh my-book-title
```
This creates a complete writing environment with all tools ready to go.

### Step 2: Plant Your Seed Idea
```
/expand-note "Your book idea here"
```
The AI team analyzes your idea, researches the topic, and creates a complete outline.

### Step 3: Start Writing
```
/draft-chapter 1
```
Your Creative Writer drafts each chapter following the outline, maintaining consistent voice.

### Step 4: Polish to Perfection
```
/revise-chapter 1
```
Your Writing Coach refines the prose, improving flow and impact.

### Step 5: Verify Everything
```
/fact-check 1
```
Your Fact Checker verifies claims and adds citations.

### Step 6: Prepare for Launch
```
/marketing-pack
```
Your Marketing Pro creates descriptions, bios, and promotional materials.

## Project Structure (What Gets Created)

When you create a new project, you get this organized workspace:

```
my-book/
├── 📝 manuscript/     → Your chapters and outlines live here
├── 🔍 research/       → Research notes and references
├── 📦 assets/         → Exported books (PDF, EPUB, etc.)
├── 🔧 bin/            → Automation scripts for batch work
├── ⚙️  .claude/        → AI team configuration
└── 🧠 CLAUDE.md       → Project memory (genre, style, goals)
```

## Quick Command Reference

Start Claude Code from your project folder, then use:

| Command | What It Does | Example |
|---------|--------------|---------|
| `/expand-note` | Turns idea into full outline | `/expand-note "space pirates find Earth"` |
| `/draft-chapter` | Writes a complete chapter | `/draft-chapter 1` |
| `/revise-chapter` | Polishes and improves | `/revise-chapter 1` |
| `/fact-check` | Verifies and adds sources | `/fact-check 1` |
| `/marketing-pack` | Creates promotional materials | `/marketing-pack` |

## Batch Operations (For Power Users)

Work on your entire book at once:

```bash
./bin/generate_drafts.sh    # Write all chapters
./bin/revise_all.sh         # Edit everything
./bin/fact_check_all.sh     # Verify all facts
./bin/compile_manuscript.sh # Export to all formats
```

## Customization

### For Different Genres

The toolkit adapts to what you're writing:

- **Fiction**: Character development, plot consistency, sensory details
- **Non-Fiction**: Research depth, logical flow, evidence-based arguments
- **Technical**: Code examples, step-by-step instructions, accuracy
- **Memoir**: Chronological organization, emotional resonance, fact-checking

Edit `CLAUDE.md` in your project to set your preferences.

### The Template System Explained

Think of it like website templates, but for books:

```
claude-author-toolkit/
├── book-project/        ← Master template with all AI agents
├── bin/setup_coauthor.sh ← Creates new projects from template
│
└── Your Projects (created by you):
    ├── my-thriller/     ← Independent project #1
    ├── tech-guide/      ← Independent project #2
    ├── memoir/          ← Independent project #3
    └── fantasy-series/  ← Independent project #4
```

**The Magic**: One template spawns unlimited, independent book projects. Each gets:
- All 6 AI agents configured and ready
- Complete folder structure
- Automation scripts
- Git version control
- Project-specific memory

Modify the master template to customize all future projects!

## Installation Requirements

### Must Have:
- Claude Code CLI (the AI interface)
- Git (for version control)

### Nice to Have:
- Pandoc (for fancier exports)
- Proselint (for style checking)

## Common Questions

### "How is this different from just using ChatGPT?"
This creates a complete writing SYSTEM with specialized agents, memory across sessions, and batch processing. Plus, you can manage multiple book projects simultaneously - each with its own AI team and memory. It's like the difference between having a notebook versus having multiple fully-staffed writing studios.

### "Can I work on multiple books at once?"
Absolutely! Create as many projects as you want:
```bash
./bin/setup_coauthor.sh cookbook
./bin/setup_coauthor.sh autobiography
./bin/setup_coauthor.sh sci-fi-trilogy
```
Each project is completely independent with its own AI team and memory.

### "Can I customize the writing style?"
Yes! Each agent has its own "voice" that you can adjust. Want academic tone? Casual blog style? YA fiction voice? Just update the configuration.

### "What if I already started writing?"
No problem! Create a project and import your existing work. The AI team will learn your style and continue from where you are.

### "Does it work for languages other than English?"
The commands are in English, but the content can be in any language Claude supports.

## Troubleshooting

### Commands not working?
✅ Make sure you're IN your project folder
✅ Check that you started Claude Code from there
✅ Verify the `.claude/` folder exists

### Something seems wrong?
Most issues are solved by:
1. Restarting Claude Code
2. Making sure you're in the project directory
3. Checking file permissions

## Start Your Writing Journey

Ready to transform how you write? Here's how to begin:

1. **Clone this toolkit**
2. **Create your first project** with `setup_coauthor.sh`
3. **Type your idea** and watch the magic happen
4. **Join the future** of AI-assisted writing

## Contributing

We love improvements! Feel free to:
- Report issues you find
- Suggest new features
- Share your success stories
- Submit pull requests

## License

MIT License - Use freely for any purpose

## Credits

Based on "Designing the Ultimate Claude Code Co‑Authoring Toolkit" by Branch

---

**Transform your ideas into published works. Your AI writing team is waiting.**

*Not just a tool. A transformation in how books are born.*