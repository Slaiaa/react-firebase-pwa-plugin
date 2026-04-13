# Atomic Design Classification

Guide for categorizing components into atoms, molecules, and organisms.

## Atoms

**Definition**: Basic building blocks that can't be broken down further without losing meaning.

**Examples**:
- Button
- Input
- Label
- Icon
- Badge
- Avatar
- Spinner
- Divider

**Characteristics**:
- Single HTML element or very simple composition
- No business logic
- Highly reusable across the app
- Typically <50 lines of code

## Molecules

**Definition**: Groups of atoms bonded together to form functional units.

**Examples**:
- FormField (Label + Input + Error message)
- SearchBar (Input + Button + Icon)
- Card (Container + Header + Content)
- ListItem (Avatar + Text + Action)
- Pagination (Buttons + Text)
- Tabs (Tab buttons + Panel)

**Characteristics**:
- Composed of 2-5 atoms
- Single, focused responsibility
- May have simple state
- Reusable in multiple contexts
- Typically 50-150 lines

## Organisms

**Definition**: Complex components made of molecules and atoms that form distinct sections.

**Examples**:
- Header (Logo + Navigation + UserMenu)
- DataTable (Table + Pagination + Filters)
- Modal (Overlay + Card + Actions)
- Form (Multiple FormFields + Buttons)
- Sidebar (Navigation + UserInfo + Actions)
- Calendar (Grid + Controls + Events)

**Characteristics**:
- Business-logic aware
- May connect to state/context
- Often page-specific
- May have complex interactions
- Typically >150 lines

## Decision Tree

```
Is it a single, indivisible UI element?
├── YES → ATOM
└── NO → Does it combine 2-5 atoms for a focused purpose?
    ├── YES → MOLECULE
    └── NO → Does it form a distinct page section with business logic?
        ├── YES → ORGANISM
        └── NO → Consider splitting into smaller components
```

## Naming Conventions

| Category | Prefix | Example |
|----------|--------|---------|
| Atoms | None | `Button`, `Input`, `Badge` |
| Molecules | None | `SearchBar`, `FormField` |
| Organisms | Feature-prefixed | `BookingCalendar`, `UserProfile` |
