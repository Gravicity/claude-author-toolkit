# Settings Configuration Guide

## Quick Fix for Invalid Settings

If you see "Invalid Settings" when running `/doctor`, use the simple settings:

```bash
cp .claude/settings-simple.json .claude/settings.json
```

## Settings Files Explained

### settings.json (Main Configuration)
Controls permissions, output styles, and hooks. Must follow strict format requirements.

### settings-simple.json (Simplified Version)
A minimal configuration without hooks. Use this if you encounter validation errors.

### project.json (Metadata)
Stores project-specific information that Claude Code doesn't directly use but helps track project configuration.

## Common Issues and Solutions

### Issue: "Invalid Settings" Error

**Causes:**
1. Hooks format incorrect (needs new matcher format)
2. Invalid fields in permissions
3. Unrecognized top-level fields

**Solution:**
Use `settings-simple.json` which contains only validated fields.

### Issue: Hooks Not Working

**New Hook Format (Claude Code 1.0+):**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": {
          "tools": ["Edit", "Write"]
        },
        "hooks": [
          {
            "type": "command",
            "command": "echo 'File edited'",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### Issue: Permissions Patterns

**Correct:**
- `Bash(git commit:*)`
- `Bash(npm:*)`
- `Read(manuscript/**)`

**Incorrect:**
- `Bash(curl:**/api/keys/**)` - The :* must be at the end
- `defaultMode` - Not a valid field

## Recommended Configuration

For most users, the simple settings provide everything needed:

```json
{
  "permissions": {
    "allow": [
      "Read(manuscript/**)",
      "Write(manuscript/**)",
      "Edit(manuscript/**)",
      "MultiEdit(manuscript/**)",
      "Read(research/**)",
      "Write(research/**)",
      "Edit(research/**)"
    ],
    "ask": [
      "Bash(git:*)",
      "WebSearch",
      "WebFetch"
    ],
    "deny": [
      "Read(.env)",
      "Bash(rm -rf:*)",
      "Bash(sudo:*)"
    ]
  },
  "outputStyle": "outline-architect"
}
```

## Advanced Users: Enabling Hooks

If you want to use hooks for automation:

1. Create hook scripts in `.claude/hooks/`
2. Make them executable: `chmod +x .claude/hooks/*.sh`
3. Use full paths in hook commands
4. Follow the new matcher format
5. Test with `/doctor` to validate

## Troubleshooting

Run `/doctor` in Claude Code to check your configuration.

If settings are invalid:
1. Check JSON syntax: `python3 -m json.tool .claude/settings.json`
2. Remove unrecognized fields
3. Fix permission patterns (`:*` at end only)
4. Use settings-simple.json as fallback

## References

- [Claude Code Settings Documentation](https://docs.claude.com/en/docs/claude-code/settings)
- [Hooks Documentation](https://docs.claude.com/en/docs/claude-code/hooks)
- [Permissions Documentation](https://docs.claude.com/en/docs/claude-code/permissions)