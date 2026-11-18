import 'package:flutter/material.dart';
import 'package:flutter_material3_default/core/theme/app_spacing.dart';
import 'package:flutter_material3_default/core/widgets/section_header.dart';

/// Shows interactive Material 3 input controls: segmented button, switch,
/// checkbox, slider, chips and text field.
///
/// The section keeps its own state so every control responds to touch, mouse
/// and keyboard input.
class InputControlsShowcaseSection extends StatefulWidget {
  /// Creates the input controls section.
  const InputControlsShowcaseSection({super.key});

  @override
  State<InputControlsShowcaseSection> createState() =>
      _InputControlsShowcaseSectionState();
}

class _InputControlsShowcaseSectionState
    extends State<InputControlsShowcaseSection> {
  /// Largest width of the text field, so it does not stretch on wide windows.
  static const double _maxTextFieldWidth = 400;

  String _selectedRange = 'week';
  bool _isNotificationsEnabled = true;
  bool _isTermsAccepted = false;
  double _volume = 40;
  bool _isFavouritesFilterSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'Selection and input',
          subtitle: 'Controls are keyboard accessible and show focus states.',
        ),
        // The scroll view lets the segmented button scroll sideways on very
        // narrow windows instead of overflowing.
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment<String>(value: 'day', label: Text('Day')),
              ButtonSegment<String>(value: 'week', label: Text('Week')),
              ButtonSegment<String>(value: 'month', label: Text('Month')),
            ],
            selected: {_selectedRange},
            onSelectionChanged: (selection) {
              setState(() {
                _selectedRange = selection.first;
              });
            },
          ),
        ),
        const SizedBox(height: AppSpacing.medium),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Notifications'),
          subtitle: const Text('Receive updates about your activity'),
          value: _isNotificationsEnabled,
          onChanged: (isEnabled) {
            setState(() {
              _isNotificationsEnabled = isEnabled;
            });
          },
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text('I accept the terms'),
          value: _isTermsAccepted,
          onChanged: (isAccepted) {
            setState(() {
              _isTermsAccepted = isAccepted ?? false;
            });
          },
        ),
        const SizedBox(height: AppSpacing.small),
        Text('Volume', style: Theme.of(context).textTheme.labelLarge),
        Slider(
          value: _volume,
          max: 100,
          divisions: 10,
          label: _volume.round().toString(),
          onChanged: (newVolume) {
            setState(() {
              _volume = newVolume;
            });
          },
        ),
        const SizedBox(height: AppSpacing.small),
        Wrap(
          spacing: AppSpacing.small,
          runSpacing: AppSpacing.small,
          children: [
            FilterChip(
              label: const Text('Favourites'),
              selected: _isFavouritesFilterSelected,
              onSelected: (isSelected) {
                setState(() {
                  _isFavouritesFilterSelected = isSelected;
                });
              },
            ),
            ActionChip(
              avatar: const Icon(Icons.event_outlined),
              label: const Text('Add to calendar'),
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.large),
        // Constraining the width keeps the field readable on wide windows while
        // it still shrinks to fit narrow ones.
        const ConstrainedBox(
          constraints: BoxConstraints(maxWidth: _maxTextFieldWidth),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Display name',
              helperText: 'Shown to other people',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
