/// Classifies an animation or transition by its functional purpose.
///
/// Use this to decide how an animation behaves when the user enables reduced
/// motion (`MediaQuery.disableAnimationsOf(context)`) or when a context calls
/// for minimal visual disturbance.
enum MotionPriority {
  /// Essential for spatial continuity or preventing disorientation, such as
  /// keeping a focused state transition understandable. Under reduced motion,
  /// it collapses to an instant or minimal cross-fade rather than a spatial
  /// translation.
  essential,

  /// Meaningful transitions such as state switches, panel reveals, and tactile
  /// press feedback. Collapses to [Duration.zero] when reduced motion is active.
  standard,

  /// Optional polish such as staggered entrances or ambient emphasis. Skipped
  /// immediately when reduced motion is active or in high-frequency workflows.
  decorative,
}
