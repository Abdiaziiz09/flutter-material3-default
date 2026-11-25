# Context-Aware Motion & Interaction

Motion in this design system is **communication, continuity and tactile
feedback** — never decoration. Every animation or interaction must earn its
place by making the interface clearer, more predictable and more responsive to
the user's intent.

## 1. Core Philosophy

1. **Purpose over polish.** Before adding any animation, ask: *What question
   does this motion answer for the user?* (e.g., "Where did this element come
   from?", "Did my tap register?", "Is the system still working?"). If there is
   no clear answer, do not animate.
2. **Continuity between action and response.** Interfaces should feel
   connected. When a user taps, toggles or navigates, the UI responds
   immediately (`<= 100 ms`) and settles organically instead of snapping
   abruptly or lagging behind.
3. **Context determines intensity.** A high-frequency data-entry form,
   spreadsheet or developer tool demands **snappy, minimal motion** so speed is
   never impeded. An editorial reader, onboarding flow or media gallery can
   use **emphasized spatial transitions** to build orientation.
4. **Never block the user.** Animations must remain interruptible and must not
   lock input while settling.
5. **Respect reduced motion unconditionally.** If
   `MediaQuery.disableAnimationsOf(context)` is `true`, non-essential motion
   must collapse to `Duration.zero`.

## 2. Decision Matrix: When to Animate vs. When to Avoid

| Situation | Animate? | Recommended Approach |
| --------- | -------- | -------------------- |
| **State change** (loading → content → empty/error) | **Yes** | Use `ContextualSwitcher` so changes feel smooth rather than jarring. |
| **Progressive disclosure** (expanding details, filters) | **Yes** | Use `SmoothExpandable` to preserve spatial context as layout height changes. |
| **Direct manipulation & taps** (cards, custom tiles) | **Yes (subtle)** | Use `TactileSurface` for immediate press feedback (`100 ms` quick scale + Material ripple). |
| **Spatial / layout adaptation** (list → detail) | **Yes** | Use `ListDetailLayout` or Material's default page transitions. |
| **High-frequency repetitive actions** (bulk table edits, rapid keyboard entry) | **No** | Keep updates instant (`AppMotion.instant`) so motion never slows down power users. |
| **Simultaneous competing elements** (many cards bouncing at once) | **No** | Animate only the primary focal change; avoid choreographed noise. |
| **Ambient loops without state meaning** (pulsing buttons, floating icons) | **No** | Reserve continuous motion strictly for active progress indicators. |
| **Reduced motion enabled** (`disableAnimationsOf == true`) | **No** | `AppMotion.durationFor` automatically resolves to `Duration.zero`. |

## 3. Motion Tokens (`AppMotion`)

All timing and easing values live in `AppMotion` (`lib/core/theme/app_motion.dart`)
and are registered as a `ThemeExtension` on `ThemeData` via `AppTheme`. Access
them with `context.motion`:

| Token | Value | Use it for |
| ----- | ----- | ---------- |
| `instant` | `0 ms` | Immediate updates and reduced-motion fallbacks |
| `quick` | `100 ms` | Micro-interactions: hover, tactile press, focus |
| `standard` | `250 ms` | State switches, inline reveals, cross-fades |
| `emphasized` | `400 ms` | Spatial transitions, pane changes, layout shifts |
| `slow` | `500 ms` | Large structural transitions |

| Curve | Use it for |
| ----- | ---------- |
| `standardCurve` (`easeInOutCubic`) | Symmetric fades and property changes |
| `emphasizedCurve` (`easeInOutCubicEmphasized`) | Spatial resizing and layout transitions |
| `emphasizedDecelerateCurve` | Elements entering or settling into place |
| `emphasizedAccelerateCurve` | Elements exiting the screen |

Always resolve durations through `context.motion.durationFor(context, ...)`:

```dart
final duration = context.motion.durationFor(
  context,
  context.motion.standard,
  priority: MotionPriority.standard,
);
```

## 4. Built-in Primitives

Prefer these core primitives over ad-hoc `AnimationController` boilerplate:

| Primitive | Location | Purpose |
| --------- | -------- | ------- |
| `ContextualSwitcher` | `lib/core/motion/contextual_switcher.dart` | Cross-fades between keyed states; instant under reduced motion. |
| `SmoothExpandable` | `lib/core/motion/smooth_expandable.dart` | Smoothly expands/collapses inline content; instant under reduced motion. |
| `TactileSurface` | `lib/core/interaction/tactile_surface.dart` | Organic press micro-scale (`0.985`), Material ink ripple, hover & keyboard focus. |
| `MotionPriority` | `lib/core/motion/motion_priority.dart` | Classifies animations as `essential`, `standard` or `decorative`. |

## 5. Multi-Platform Input Awareness

- **Touch**: Tactile press feedback (`TactileSurface`), native scroll physics,
  and >= 48 × 48 dp targets.
- **Mouse / Trackpad**: Visible hover overlays, `Tooltip`s on icon-only and
  custom interactive surfaces, and mouse-drag scrolling via `AppScrollBehavior`.
- **Keyboard**: Logical `Tab` traversal, visible focus rings, and `Enter`/`Space`
  activation on every interactive surface.
