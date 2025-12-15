# Todo List Example Walkthrough

**Difficulty:** Beginner  
**Time to complete:** ~3 hours (spec + planning + initial code)  
**Team size:** 1-3 people  
**Tech stack:** Vanilla HTML/CSS/JavaScript, SQLite  

## Overview

This example walks through building a simple Todo List application from initial idea
to working code. We'll follow the complete Team-Driven Development workflow:

1. **Specify** - Define what we're building
2. **Review** - Get team feedback  
3. **Plan** - Decide technical approach
4. **Tasks** - Break into actionable work
5. **Implement** - Build the code

---

## Phase 1: Specification (15 minutes)

### The Idea
"Build a todo list application where users can create tasks, mark them complete, delete them, and filter by status."

### Team Input Session

**Product Manager perspective:**
- Users want to quickly add tasks
- Ability to see task count by status (To Do, In Progress, Done)
- Task filtering is important for staying focused

**Technical Architect perspective:**
- Keep it simple (vanilla JS, no frameworks for MVP)
- Local data storage (SQLite) for startup
- Responsive design for mobile

**UX Designer perspective:**
- One-page interface, minimal scrolling
- Clear visual distinction between statuses
- Drag-and-drop would be nice but not required for MVP

**QA perspective:**
- How do we save data between sessions?
- What happens if user closes browser mid-edit?
- Edge cases: very long task names, special characters

**Developer perspective:**
- Local storage is simpler than backend initially
- SQLite option for future scaling
- Use HTML5 features (local storage API)

**DevOps perspective:**
- No server deployment needed initially
- Easy to version and package as static site
- Future: containerize if needed

### Result: Specification Document

**Key Decisions:**
- ✅ Store tasks locally in browser (localStorage)
- ✅ Support 3 statuses: To Do, In Progress, Done
- ✅ Add, edit, delete, filter operations
- ✅ No authentication (single user)
- ✅ Desktop-first, mobile-friendly

**Acceptance Criteria:**
- User can add a task with a title
- User can change task status by clicking status selector
- User can delete a task
- User can filter by status
- Tasks persist after page reload
- Application works offline

---

## Phase 2: Review (10 minutes)

### What the Review Found

**Product Manager Review:**
✅ Clear user value: Helps organize tasks  
✅ MVP scope is right  
❓ Question: Can users edit task descriptions?  
→ Decision: Yes, add edit feature

**Technical Architect Review:**
✅ localStorage is appropriate for MVP  
⚠️ Concern: What about data migration if we move to backend?  
→ Decision: Document data export function for future

**UX Designer Review:**
✅ Simple interface is good  
❓ Question: Drag-and-drop for status changes?  
→ Decision: Use dropdown selects for MVP, add drag-and-drop in v2

**QA Review:**
✅ Edge cases identified  
⚠️ Concern: localStorage limits (5-10MB)  
→ Decision: Document limit, warn user at 80%

**Developer Review:**
✅ Technically straightforward  
❓ Question: Use Vue/React or vanilla?  
→ Decision: Vanilla JS for true simplicity, no framework dependencies

**DevOps Review:**
✅ Easy to deploy  
✅ No operational concerns for MVP  

### Changes Made
- Added task description/notes field
- Added edit task feature
- Documented future migration path

---

## Phase 3: Planning (20 minutes)

### Technical Decisions Made

**Data Structure:**
```javascript
Task {
  id: unique-identifier,
  title: string,
  description: string,
  status: "todo" | "in-progress" | "done",
  createdAt: timestamp,
  updatedAt: timestamp
}
```

**Architecture:**
```
index.html          - Main UI
css/styles.css      - Styling
js/app.js           - Main application logic
js/storage.js       - localStorage abstraction
js/ui.js            - DOM manipulation
```

**Key Technologies:**
- **Storage:** localStorage (browser API)
- **UI:** Vanilla HTML/CSS/JavaScript
- **Data Format:** JSON serialized to localStorage
- **Styling:** CSS Grid for responsive layout

**Why these choices:**
- ✅ No build step needed
- ✅ No external dependencies
- ✅ Works offline
- ✅ Fast loading time
- ✅ Good starting point for learning

**Future Enhancement Path:**
- → Add SQLite backend via Tauri/Electron
- → Add cloud sync via Firebase
- → Add collaborative features via WebSocket

### Implementation Approach

**Order of implementation:**
1. **UI/HTML** - Create page structure
2. **Storage layer** - localStorage abstraction
3. **Core logic** - Add, edit, delete, filter
4. **UI interactions** - Wire up buttons/forms
5. **Testing** - Manual testing, edge cases
6. **Polish** - Styling, responsive design

**Quality Approach:**
- Test-driven: Write tests first for storage layer
- Manual testing: Verify UI interactions work
- Cross-browser: Test in Chrome, Firefox, Safari
- Mobile: Test on iPhone/Android

---

## Phase 4: Tasks (15 minutes)

### Breakdown (Simplified)

| # | Task | Type | Owner | File | Status |
|---|------|------|-------|------|--------|
| 1 | Create project structure | Setup | Dev | `index.html` | ✅ |
| 2 | Implement storage layer | IMPL | Dev | `js/storage.js` | ✅ |
| 3 | Create task model tests | TEST | Dev | `tests/storage.test.js` | ✅ |
| 4 | Implement UI render function | IMPL | Dev | `js/ui.js` | ✅ |
| 5 | Add button: Create task | IMPL | Dev | `index.html` | ✅ |
| 6 | Add button: Delete task | IMPL | Dev | `index.html` | ✅ |
| 7 | Add dropdown: Change status | IMPL | Dev | `index.html` | ✅ |
| 8 | Add filter buttons | IMPL | Dev | `index.html` | ✅ |
| 9 | Style: Responsive layout | UI | Designer | `css/styles.css` | ✅ |
| 10 | Manual testing: Edge cases | TEST | QA | `TESTING.md` | ✅ |

**Key dependencies:**
- Storage layer must be done first (needed by everything else)
- UI rendering depends on storage layer
- Styling can happen in parallel

---

## Phase 5: Implementation (2+ hours)

### What Gets Built

**1. HTML Structure** (10 min)
```html
<div id="app">
  <h1>My Todo List</h1>
  <div id="filters">
    <button class="filter" data-status="all">All</button>
    <button class="filter" data-status="todo">To Do</button>
    <button class="filter" data-status="in-progress">In Progress</button>
    <button class="filter" data-status="done">Done</button>
  </div>
  <div id="task-form">
    <input type="text" id="title" placeholder="Add a task...">
    <button id="add-btn">Add Task</button>
  </div>
  <div id="tasks"></div>
</div>
```

**2. Storage Layer** (15 min)
```javascript
class TodoStore {
  getTasks() { /* return tasks from localStorage */ }
  addTask(title, description) { /* create new task */ }
  updateTask(id, updates) { /* modify existing task */ }
  deleteTask(id) { /* remove task */ }
  save() { /* persist to localStorage */ }
}
```

**3. UI Logic** (20 min)
```javascript
function renderTasks(tasks) {
  // Render tasks based on current filter
  // Wire up event listeners for buttons
  // Update status selectors
}

function handleAddTask() {
  // Get input values
  // Call store.addTask()
  // Re-render UI
}
```

**4. Styling** (15 min)
- Responsive grid layout
- Status color coding (todo = gray, in-progress = yellow, done = green)
- Mobile-friendly buttons and forms

**5. Testing** (15 min)
- Manual testing: add/edit/delete tasks
- Test filter functionality
- Verify localStorage persistence
- Test on mobile device
- Test with 50+ tasks
- Test with special characters

### Challenges Encountered

**Challenge 1: Task ID uniqueness**
- Problem: How to generate unique IDs?
- Solution: Use timestamp + random (simple but works for MVP)

**Challenge 2: Filter persistence**
- Problem: Which filter is active after page reload?
- Solution: Store selected filter in localStorage too

**Challenge 3: Long task names**
- Problem: Text overflow on mobile
- Solution: Use CSS text-truncate + full text in modal

### Lessons Learned (See LESSONS-LEARNED.md for details)

✅ **What went well:**
- Vanilla JS was fast to implement
- Team collaboration prevented rework
- localStorage API is simpler than expected

⚠️ **What to improve next time:**
- Add tests first (we did them late)
- Create more detailed task descriptions
- Involve designer earlier in layout decisions

---

## Files Generated

```
001-simple-todo-list/
├── WALKTHROUGH.md (this file)
├── spec.md (full specification)
├── plan.md (technical plan)
├── tasks.md (task breakdown)
├── decision-log.md (decisions made)
├── LESSONS-LEARNED.md (retrospective)
└── code/
    ├── index.html
    ├── css/styles.css
    ├── js/
    │   ├── app.js
    │   ├── storage.js
    │   └── ui.js
    └── tests/
        └── storage.test.js
```

---

## Key Takeaways for Your Feature

### From Specification
- ✅ Get input from all personas before planning
- ✅ Document decisions and rationale
- ✅ Use clarification markers for ambiguities
- ✅ Create acceptance criteria for each feature

### From Planning  
- ✅ Be explicit about technology choices and why
- ✅ Document the implementation approach
- ✅ Consider future scalability but start simple
- ✅ Define data structures clearly

### From Tasks
- ✅ Break work into achievable pieces
- ✅ Show dependencies clearly
- ✅ Assign clear acceptance criteria
- ✅ Mark parallel work with [P]

### From Implementation
- ✅ Follow the plan but iterate if needed
- ✅ Test as you go
- ✅ Update documentation when you change approach
- ✅ Get feedback early

---

## Timeline Summary

| Phase | Time | Output |
|-------|------|--------|
| Specify | 15 min | spec.md |
| Review | 10 min | Updates to spec |
| Plan | 20 min | plan.md |
| Tasks | 15 min | tasks.md |
| Implement | 2 hours | Working code |
| **Total** | **~3 hours** | Complete feature |

---

## What's Different from Waterfall?

**Waterfall approach:**
```
Spec (4 hours) → Design (3 hours) → Code (8 hours) → Test (2 hours)
= 17 hours, serial, lots of handoffs, high risk of misalignment
```

**Team-Driven approach:**
```
Spec (15 min) with all personas
→ Review (10 min) catches issues early  
→ Plan (20 min) with team perspectives
→ Code (2 hours) with clear direction
= 3 hours total, parallel thinking, low risk
```

The time savings come from:
- ✅ Catching misalignment early
- ✅ All perspectives represented from start
- ✅ Clear specification reduces rework
- ✅ Faster decision-making

---

## Next Features

After completing the todo list, consider adding:

1. **002-todo-categories** - Group tasks by category
2. **003-todo-collaboration** - Share lists with others
3. **004-todo-backend** - Move to cloud storage
4. **005-todo-mobile-app** - Native mobile version

Each would follow the same workflow documented here.

---

## Questions?

See:
- [FAQ.md](../FAQ.md) - Common questions
- [QUICK-START.md](../QUICK-START.md) - Getting started
- [TROUBLESHOOTING.md](../TROUBLESHOOTING.md) - Problem solving
- [team-driven.md](../../team-driven.md) - Full methodology

