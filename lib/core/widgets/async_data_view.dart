import 'package:flutter/widgets.dart';
import 'package:flutter_material3_default/core/motion/contextual_switcher.dart';
import 'package:flutter_material3_default/core/widgets/feedback_state_view.dart';
import 'package:flutter_material3_default/core/widgets/skeleton_box.dart';

/// The possible states of an asynchronous data load.
enum AsyncDataState {
  /// Data is being fetched for the first time.
  loading,

  /// Data has been fetched and is available.
  content,

  /// The fetch completed successfully but returned no items.
  empty,

  /// The fetch failed with an error.
  error,
}

/// A single widget that manages every state of an asynchronous data load.
///
/// Compose [SkeletonBox], [ContextualSwitcher], and [FeedbackStateView] into
/// one place so individual screens never have to stitch them together manually.
///
/// ## States
///
/// | [state]              | Rendered widget                        |
/// |----------------------|----------------------------------------|
/// | [AsyncDataState.loading] | [loadingBuilder] or default skeleton   |
/// | [AsyncDataState.content] | [contentBuilder]                       |
/// | [AsyncDataState.empty]   | [emptyBuilder] or default [FeedbackStateView] |
/// | [AsyncDataState.error]   | [errorBuilder] or default [FeedbackStateView] |
///
/// ## Example
///
/// ```dart
/// AsyncDataView(
///   state: _state,
///   contentBuilder: (context) => ListView(children: _items),
///   emptyTitle: 'Nothing here yet',
///   emptyMessage: 'Pull down to refresh.',
///   errorTitle: 'Could not load data',
///   onRetry: _fetchData,
/// )
/// ```
class AsyncDataView extends StatelessWidget {
  /// Creates an async data view.
  const AsyncDataView({
    required this.state,
    required this.contentBuilder,
    this.loadingBuilder,
    this.emptyBuilder,
    this.errorBuilder,
    this.emptyTitle = 'Nothing here yet',
    this.emptyMessage,
    this.errorTitle = 'Something went wrong',
    this.errorMessage,
    this.onRetry,
    this.retryLabel = 'Try again',
    super.key,
  });

  /// Current loading / content state that drives which widget is shown.
  final AsyncDataState state;

  /// Builds the content widget when [state] is [AsyncDataState.content].
  final WidgetBuilder contentBuilder;

  /// Optional custom loading widget. Defaults to a column of [SkeletonBox]
  /// placeholders that mirror the content area's height.
  final WidgetBuilder? loadingBuilder;

  /// Optional custom empty-state widget. Defaults to a [FeedbackStateView].
  final WidgetBuilder? emptyBuilder;

  /// Optional custom error-state widget. Defaults to a [FeedbackStateView].
  final WidgetBuilder? errorBuilder;

  /// Title shown in the default empty state.
  final String emptyTitle;

  /// Optional supporting message shown in the default empty state.
  final String? emptyMessage;

  /// Title shown in the default error state.
  final String errorTitle;

  /// Optional supporting message shown in the default error state.
  final String? errorMessage;

  /// Callback for the "retry" button in the default error state.
  /// When `null`, no button is shown.
  final VoidCallback? onRetry;

  /// Label for the retry button.
  final String retryLabel;

  Widget _buildLoading(BuildContext context) {
    if (loadingBuilder != null) return loadingBuilder!(context);
    return const _DefaultSkeleton();
  }

  Widget _buildEmpty(BuildContext context) {
    if (emptyBuilder != null) return emptyBuilder!(context);
    return FeedbackStateView(
      icon: _AsyncDataViewIcons.empty,
      title: emptyTitle,
      message: emptyMessage,
    );
  }

  Widget _buildError(BuildContext context) {
    if (errorBuilder != null) return errorBuilder!(context);
    return FeedbackStateView(
      icon: _AsyncDataViewIcons.error,
      title: errorTitle,
      message: errorMessage,
      isError: true,
      actionLabel: onRetry != null ? retryLabel : null,
      onAction: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget resolved;
    switch (state) {
      case AsyncDataState.loading:
        resolved = KeyedSubtree(
          key: const ValueKey(AsyncDataState.loading),
          child: _buildLoading(context),
        );
      case AsyncDataState.content:
        resolved = KeyedSubtree(
          key: const ValueKey(AsyncDataState.content),
          child: contentBuilder(context),
        );
      case AsyncDataState.empty:
        resolved = KeyedSubtree(
          key: const ValueKey(AsyncDataState.empty),
          child: _buildEmpty(context),
        );
      case AsyncDataState.error:
        resolved = KeyedSubtree(
          key: const ValueKey(AsyncDataState.error),
          child: _buildError(context),
        );
    }

    return ContextualSwitcher(child: resolved);
  }
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

/// Default skeleton: three placeholder rows that occupy the loading space.
class _DefaultSkeleton extends StatelessWidget {
  const _DefaultSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SkeletonBox(height: 24, width: 180),
          const SizedBox(height: 12),
          const SkeletonBox(height: 16),
          const SizedBox(height: 8),
          const SkeletonBox(height: 16),
          const SizedBox(height: 8),
          SkeletonBox(
            height: 16,
            width: MediaQuery.sizeOf(context).width * 0.6,
          ),
        ],
      ),
    );
  }
}

/// Icons used by the default empty / error states. Centralised so they can be
/// updated in one place without searching through the codebase.
abstract final class _AsyncDataViewIcons {
  static const empty = _emptyIcon;
  static const error = _errorIcon;
}

// ignore: constant_identifier_names
const _emptyIcon = IconData(0xe1be, fontFamily: 'MaterialIcons'); // inbox
// ignore: constant_identifier_names
const _errorIcon = IconData(
  0xe237,
  fontFamily: 'MaterialIcons',
); // error_outline
