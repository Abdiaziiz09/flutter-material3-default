# Product Engagement & Experience Principles

A design system shapes more than colours, typography, and motion—it shapes how
people **feel** when they use a product, how effortlessly they act, and why they
return.

These six general-purpose principles apply to **any** domain (productivity
tools, dashboards, commerce, learning, media, or internal workflows). Adapt
their intensity to the product's purpose, never as rigid templates or
manipulative dark patterns.

---

## Overview: Entry and Momentum

```text
  [1. Trigger] ──▶ [2. Effortless Action] ──▶ [3. Guided Path]   (Entry)
                                                    │
  [6. Stored Value] ◀── [5. Continuous Flow] ◀── [4. Earned Feedback]  (Momentum)
```

---

## Part 1: Entering the Experience

### 1. Purposeful Triggers (Internal & External)

- **Principle:** People open an application because of an *internal trigger*
  (a need, curiosity, stress, or a recurring habit) or an *external trigger*
  (a notification, badge, or reminder). Over time, a well-crafted product
  becomes the natural, automatic response to the specific need it solves.
- **How to apply:**
  - Anchor every screen and prompt to the concrete user need it resolves.
  - Write notifications, badges, and calls-to-action that speak directly to
    relevant outcomes rather than generic reminders.
  - Surface timely, context-aware prompts only when they are genuinely useful.

### 2. Effortless Core Action (Reduce Friction)

- **Principle:** User energy and motivation fluctuate throughout the day. The
  core action of any screen must be simple enough to complete even when the
  user is tired, rushed, or distracted.
- **How to apply:**
  - Minimize steps required to complete the primary task; prefer one-tap or
    single-gesture execution over multi-screen forms when possible.
  - Place primary actions within natural reach (bottom `NavigationBar`,
    `FloatingActionButton`, or prominent `FilledButton` in the primary action
    zone).
  - Pre-fill or infer sensible values so users confirm rather than type from
    scratch.

### 3. Guided Default Path (Remove Decision Paralysis)

- **Principle:** Forcing users to choose among too many equal options creates
  friction and abandonment. People naturally follow a clear, well-chosen
  default path.
- **How to apply:**
  - Lead every screen with **one obvious primary action** or focus area; avoid
    crowded menus on entry.
  - Set intelligent defaults for filters, views, and settings.
  - Hide secondary or advanced options behind progressive disclosure
    (`SmoothExpandable`) so beginners stay focused while power users remain
    empowered.

---

## Part 2: Sustaining Momentum

### 4. Meaningful & Dynamic Feedback (Earned Rewards)

- **Principle:** Flat, predictable responses feel mechanical. Interfaces feel
  alive when feedback is immediate, proportional, and occasionally
  delightful—reinforcing progress and discovery.
- **How to apply:**
  - Confirm every user action immediately (`<= 100 ms`) with tactile and visual
    response (`TactileSurface`, Material ink ripples, `ContextualSwitcher`, and
    sparing `AppHaptics` on mobile).
  - Vary feedback naturally where appropriate (e.g., fresh discoveries,
    personalized insights, milestone acknowledgements) rather than repeating
    identical static messages.
  - Keep feedback respectful of the domain: calm and reassuring in utilitarian
    tools, expressive in exploratory or learning products.

### 5. Continuous Flow (Eliminate Dead Ends)

- **Principle:** Abrupt stopping points and blank screens break momentum and
  prompt users to leave. Every state should naturally point toward the next
  meaningful step.
- **How to apply:**
  - Never leave a user stranded on an unguided empty or error screen. Use
    `FeedbackStateView` with warm, clear copy and a single recovery or next
    action (`FilledButton`).
  - In content-rich or exploratory views, support seamless continuation
    (related items, next-step suggestions, or smooth infinite/paginated
    scrolling using `CustomScrollView` and `Sliver*`).
  - Preserve context across navigation (`PageStorageKey` on scroll views,
    `ListDetailLayout` on wide screens) so users never lose their place.

### 6. Compounding Value (Stored Investment)

- **Principle:** Every interaction should make the product more useful and
  personal over time. When a user's preferences, history, and progress
  accumulate inside the system, returning feels natural and rewarding.
- **How to apply:**
  - Remember user choices (theme mode, layout state, recent items, saved
    filters) across sessions.
  - Make accumulated progress visible (saved collections, history,
    completed milestones, or personalized views) in ways that serve the user's
    goals.
  - Use forgiveness patterns (`SnackBar` with Undo) so users feel safe
    investing effort and exploring without fear of mistakes.

---

## Mapping Principles to Foundation Primitives

| Principle | Relevant Foundation Primitives & Patterns |
| --------- | ----------------------------------------- |
| **1. Purposeful Triggers** | `Badge`, contextual `SnackBar`, clear `SectionHeader` hierarchy |
| **2. Effortless Core Action** | `TactileSurface`, `FilledButton`, bottom `NavigationBar` in `AdaptiveScaffold` |
| **3. Guided Default Path** | `SmoothExpandable`, `ListDetailLayout`, smart default state |
| **4. Meaningful Feedback** | `ContextualSwitcher`, `TactileSurface`, `AppHaptics`, `AppMotion` |
| **5. Continuous Flow** | `FeedbackStateView`, `CustomScrollView` / `Sliver*` (when appropriate), `PageStorageKey` |
| **6. Compounding Value** | Persistent state (`ThemeController` pattern), saved preferences, Undo `SnackBar` |

---

## Context-Driven Judgment

Apply these principles intelligently based on what you are building:

- **High-frequency / utilitarian tools** (admin consoles, editors, financial
  tools): prioritize **Effortless Core Action**, **Guided Default Path**, and
  **Forgiveness**; avoid gamified noise.
- **Exploratory / content-rich products** (catalogues, readers, feeds):
  lean into **Continuous Flow**, **Dynamic Feedback**, and scroll-linked
  `Sliver` choreography.
- **Habit-forming / learning products** (trackers, study tools, wellness):
  combine **Purposeful Triggers**, **Compounding Value** (visible progress),
  and **Earned Feedback**.

Always respect user autonomy: engagement comes from genuine usefulness,
clarity, and craft—never from deceptive patterns or artificial friction against
leaving.
