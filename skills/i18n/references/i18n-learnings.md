# i18n Specialist - Learnings Log

This file records patterns that were missed during i18n discovery and the lessons learned.
**The agent MUST check this file before starting any discovery phase.**

---

## 2024-02-04 - Initial Learnings from Brilliant Portal Project

### Pattern 1: ConfirmDialog Component Props

**What was missed**: Dialog title and message props
**Location**: Multiple components using `<ConfirmDialog title="..." message="..." />`
**Type**: Component string props

#### Why it was missed
Standard JSX text search (`>[A-Za-z]`) doesn't catch strings passed as props.

#### New search pattern
```bash
# ConfirmDialog and similar modal/dialog props
grep -rn '\(title\|message\|description\|confirmText\|cancelText\)="[A-Za-z]' --include="*.tsx"

# Any component with text props
grep -rn '="[A-Z][a-z].*"' --include="*.tsx" | grep -v "className\|data-\|style\|type\|name\|id\|key\|ref\|src\|href"
```

#### Lessons learned
- Search for ALL component props that might contain text
- Modal/Dialog components often have title, message, confirmText, cancelText props

---

### Pattern 2: Select/Dropdown Placeholder Props

**What was missed**: Placeholder text in Select components
**Location**: Form select inputs with `placeholder="Select..."`
**Type**: Component prop

#### Why it was missed
Focused on `<input placeholder>` but not on custom Select components

#### New search pattern
```bash
# Custom select/dropdown placeholders
grep -rn 'placeholder="[A-Za-z]' --include="*.tsx"

# Also check for selectPlaceholder, defaultText, emptyText
grep -rn '\(selectPlaceholder\|defaultText\|emptyText\|emptyLabel\)="[A-Za-z]' --include="*.tsx"
```

---

### Pattern 3: Legends and Caption Components

**What was missed**: Legend items with hardcoded labels
**Location**: `Legends.tsx` - `<LegendItem label="Absence" />`
**Type**: Component string props

#### Why it was missed
Low-level display components not thoroughly checked

#### New search pattern
```bash
# Legend-related components
grep -rn 'label="[A-Za-z]' --include="*.tsx"

# Caption and label props
grep -rn '\(caption\|label\|text\)="[A-Za-z]' --include="*.tsx"
```

#### Lessons learned
- Display/presentation components like legends, captions, badges often have hardcoded text
- Always check components in `components/ui/` or similar directories

---

### Pattern 4: Table Column Headers in Config

**What was missed**: Column headers defined in configuration objects
**Location**: Table configurations with `{ header: 'Name', ... }`
**Type**: Object property

#### Why it was missed
Strings in object literals not caught by JSX searches

#### New search pattern
```bash
# Table/grid column headers
grep -rn "header:\s*['\"][A-Za-z]" --include="*.tsx" --include="*.ts"

# Column definitions
grep -rn "columns.*=.*\[" --include="*.tsx" -A 10 | grep "header\|title\|label"
```

---

### Pattern 5: Empty State Messages

**What was missed**: "No data available", "No items found" messages
**Location**: Empty state placeholders in lists and tables
**Type**: JSX text and props

#### Why it was missed
Often conditional rendering, easy to miss when data exists during testing

#### New search pattern
```bash
# Empty state keywords
grep -rn "No \(data\|items\|results\|records\|entries\)" --include="*.tsx"
grep -rn "Nothing\|Empty\|not found" --include="*.tsx"

# EmptyState component props
grep -rn '<EmptyState' --include="*.tsx" -A 3
```

---

### Pattern 6: Date Picker Labels

**What was missed**: "From", "To", labels in date range pickers
**Location**: DatePicker components with range mode
**Type**: Component internal text and props

#### Why it was missed
Date picker components often have their own internal labels

#### New search pattern
```bash
# Date-related labels
grep -rn '\(from\|to\|start\|end\)\(Date\|Label\|Text\)' --include="*.tsx" -i

# Date picker specific
grep -rn '<DatePicker\|<DateRange' --include="*.tsx" -A 5
```

---

### Pattern 7: Form Section Headers

**What was missed**: Form section titles like "Basic Information", "Details"
**Location**: Form layouts with section groupings
**Type**: JSX heading elements in forms

#### Why it was missed
Form sections often use plain `<h3>` or `<h4>` without specific component

#### New search pattern
```bash
# Headings in forms
grep -rn '<h[1-6][^>]*>[A-Za-z]' --include="*.tsx"

# Section/fieldset legends
grep -rn '<fieldset\|<legend' --include="*.tsx" -A 2
```

---

### Pattern 8: Status and Badge Text

**What was missed**: Status badges with text like "Active", "Pending", "Completed"
**Location**: Status indicators and badges
**Type**: Component children or props

#### Why it was missed
Often enum values displayed directly without translation wrapper

#### New search pattern
```bash
# Status-related terms
grep -rn "Active\|Inactive\|Pending\|Completed\|Draft\|Published\|Archived" --include="*.tsx"

# Badge/chip components
grep -rn '<Badge\|<Chip\|<Status' --include="*.tsx" -A 2
```

---

### Pattern 9: Sidebar and Navigation Labels

**What was missed**: Navigation item labels, sidebar menu text
**Location**: Navigation components, sidebar menus
**Type**: Component props and children

#### Why it was missed
Navigation often defined in config arrays, not inline JSX

#### New search pattern
```bash
# Navigation configs
grep -rn "nav\|menu\|sidebar" --include="*.ts" --include="*.tsx" -i | grep -i "label\|title\|text"

# Nav item patterns
grep -rn '\(to\|href\)="[^"]*"[^>]*>[A-Za-z]' --include="*.tsx"
```

---

### Pattern 10: Tooltip Content

**What was missed**: Tooltip text on icons and buttons
**Location**: Icon buttons with tooltip explanations
**Type**: Component prop (content, title, label)

#### Why it was missed
Tooltips often use `content` or `title` prop, not caught by standard searches

#### New search pattern
```bash
# Tooltip patterns
grep -rn '<Tooltip' --include="*.tsx" -A 3
grep -rn 'tooltip="[A-Za-z]\|content="[A-Za-z]' --include="*.tsx"

# Title on any element
grep -rn '\stitle="[A-Za-z]' --include="*.tsx"
```

---

## Categories Checklist

Before considering discovery complete, verify all these are checked:

### Must Search
- [ ] JSX text content (`>text<`)
- [ ] Title attributes
- [ ] Placeholder attributes
- [ ] aria-label attributes
- [ ] alt text for images
- [ ] Toast/notification messages
- [ ] Form validation messages (Zod, Yup)
- [ ] Confirmation dialog text
- [ ] Error messages and fallbacks
- [ ] Loading states
- [ ] Empty states
- [ ] Button text
- [ ] Link text
- [ ] Table headers (JSX and config)
- [ ] Form labels
- [ ] Select/dropdown placeholders
- [ ] Legend/caption text
- [ ] Status/badge text
- [ ] Navigation labels
- [ ] Tooltip content
- [ ] Modal/dialog titles and messages
- [ ] Date picker labels
- [ ] Form section headers

### Locations to Check
- [ ] `components/ui/` - Low-level UI components
- [ ] `components/layout/` - Navigation, sidebars
- [ ] `components/forms/` - Form-related components
- [ ] Any component with "Dialog", "Modal", "Popup" in name
- [ ] Any component with "Empty", "Loading", "Error" in name
- [ ] Configuration files with UI text

---

## How to Use This File

1. **Before Discovery**: Read this entire file
2. **Run All Patterns**: Execute each search pattern listed
3. **Cross-Reference Categories**: Check every category in the checklist
4. **After Discovery**: If user reports missed text, add new entry here
5. **Continuous Improvement**: This file should grow with each project

---

*Last updated: 2024-02-04*
