# Form Patterns

Consistent, forgiving forms are one of the highest-impact quality signals in
any application. This document tells AI agents exactly when and how to validate
input, how to colour feedback using the design system's semantic tokens, and
how to avoid punishing the user for exploring.

---

## 1. The core rule: forgiveness first

A form should never make the user feel stupid. Validate at the right moment,
explain clearly when something is wrong, and always offer a path forward.

| Situation | Rule |
|-----------|------|
| User is typing for the first time | Show nothing — do not validate yet. |
| User leaves a field (unfocuses) | Validate that field only. |
| User submits the form | Validate all fields simultaneously. |
| User corrects a field | Clear the error immediately on change. |

---

## 2. Colour and styling

Always use the [ColorScheme] error tokens — never hard-code `Colors.red`.

```dart
// ✅ Correct — uses theme tokens
TextField(
  decoration: InputDecoration(
    labelText: 'Email address',
    errorText: _emailError, // null = no error border
  ),
)

// ❌ Wrong — hard-codes a colour
TextField(
  style: const TextStyle(color: Colors.red),
)
```

For custom inline status indicators, use [`AppStatusColors`]:

| State | Token | Use case |
|-------|-------|---------|
| Error / invalid | `colorScheme.error` / `errorContainer` | Required field empty, format wrong |
| Warning / degraded | `statusColors.warning` / `warningContainer` | Optional but recommended, weak password |
| Success / valid | `statusColors.success` / `successContainer` | Password strength OK, username available |
| Info / neutral | `statusColors.info` / `infoContainer` | Character count, helper text |

```dart
// Inline status indicator pattern
Container(
  padding: const EdgeInsets.symmetric(
    horizontal: AppSpacing.small,
    vertical: AppSpacing.extraSmall,
  ),
  decoration: BoxDecoration(
    color: context.statusColors.warningContainer,
    borderRadius: AppRadii.borderRadiusSmall,
  ),
  child: Text(
    'Password could be stronger',
    style: theme.textTheme.labelSmall?.copyWith(
      color: context.statusColors.onWarningContainer,
    ),
  ),
)
```

---

## 3. Validation strategy patterns

### 3.1 Inline validation (validate on blur)

Use for fields where feedback is immediately useful and non-intrusive.

```dart
class _EmailFieldState extends State<EmailField> {
  String? _errorText;
  bool _hasBeenTouched = false;

  String? _validate(String value) {
    if (value.isEmpty) return 'Email is required.';
    if (!value.contains('@')) return 'Enter a valid email address.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        // Validate only when the field loses focus for the first time.
        if (!hasFocus && !_hasBeenTouched) {
          setState(() {
            _hasBeenTouched = true;
            _errorText = _validate(_controller.text);
          });
        }
      },
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Email address',
          errorText: _hasBeenTouched ? _errorText : null,
        ),
        onChanged: (value) {
          // Once touched, clear the error as the user types.
          if (_hasBeenTouched) {
            setState(() => _errorText = _validate(value));
          }
        },
      ),
    );
  }
}
```

### 3.2 Submit-time validation

Use for shorter forms (login, sign-up). Validate everything at once on submit.

```dart
class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // All fields are valid — proceed.
      _formKey.currentState!.save();
      _submitLogin();
    }
    // On failure, Form automatically shows errors under each invalid field.
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // Validate in real-time only after the first submit attempt.
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (v) =>
                (v == null || v.isEmpty) ? 'Email is required.' : null,
          ),
          const SizedBox(height: AppSpacing.medium),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (v) =>
                (v == null || v.length < 8)
                    ? 'Password must be at least 8 characters.'
                    : null,
          ),
          const SizedBox(height: AppSpacing.large),
          FilledButton(
            onPressed: _handleSubmit,
            child: const Text('Sign in'),
          ),
        ],
      ),
    );
  }
}
```

---

## 4. Forgiveness patterns

### 4.1 Preserve user input on error

After a failed submission, **never clear** valid fields. Only clear the field
that caused the error when the user has successfully corrected it.

### 4.2 Undo / cancel safety net

Destructive actions (deleting a draft, cancelling a long form) must offer an
undo step. Use `AppFeedback.showUndoSnackBar` for recoverable deletions.

```dart
AppFeedback.showUndoSnackBar(
  context,
  message: 'Draft deleted',
  onUndo: () => _restoreDraft(draft),
);
```

### 4.3 Sensible defaults and auto-fill

Pre-populate fields from the user's existing data when possible. Respect
`autofillHints` so the system can fill email, phone and password fields
automatically:

```dart
TextFormField(
  autofillHints: const [AutofillHints.email],
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next,
  decoration: const InputDecoration(labelText: 'Email'),
)
```

### 4.4 Smart defaults for optional fields

Always set a sensible default value for optional fields (toggles, pickers,
dropdowns) so the user can submit without touching every control.

---

## 5. Accessibility requirements

- `TextField` and `TextFormField` must always have a `labelText` or a `label`
  widget — never a `hintText`-only field (hints disappear when the user types).
- Error messages must be short (< 80 characters), specific, and actionable.
  *"Required"* is not enough; *"Email is required."* is correct.
- Use `textInputAction: TextInputAction.next` for mid-form fields and
  `TextInputAction.done` / `TextInputAction.send` for the last field so the
  keyboard's action button moves the cursor or submits.
- Minimum touch target for submit and clear buttons: **48 × 48 dp**.

---

## 6. What AI agents must not do

- Do **not** validate while the user is still typing in an untouched field.
- Do **not** hard-code `Colors.red` or `Colors.green` for status colours.
- Do **not** clear valid input after a failed submit.
- Do **not** dismiss the keyboard mid-flow unless the user triggers it.
- Do **not** show more than one error per field at the same time.
