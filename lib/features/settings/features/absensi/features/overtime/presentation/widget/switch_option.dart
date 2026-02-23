import 'package:flutter/material.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';

class SwitchOption extends StatefulWidget {
  const SwitchOption({
    super.key,
    required this.label,
    required this.description,
    this.onChanged,
  });

  final String label;
  final String description;
  final void Function(bool value)? onChanged;

  @override
  State<SwitchOption> createState() => _SwitchOptionState();
}

class _SwitchOptionState extends State<SwitchOption> {
  bool _active = false;

  Icon? _resolveThumbIcon(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return Icon(
        Icons.check,
        color: Colors.white,
      );
    }
    return Icon(
      Icons.close,
      color: Colors.grey,
    );
  }

  Color _resolveTrackOutlineColor(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) {
      return AppColors.primary;
    }
    return Colors.black26;
  }

  void _onChanged(bool? value) {
    setState(() => _active = !_active);
    widget.onChanged?.call(_active);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CustomLabel(widget.label),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 13),
              ),
            ),
            SizedBox(width: 8),
            Switch(
              value: _active,
              padding: EdgeInsets.all(0),
              activeColor: AppColors.primary,
              inactiveThumbColor: Colors.white,
              thumbIcon: WidgetStateProperty.resolveWith(_resolveThumbIcon),
              activeTrackColor: AppColors.primary.withAlpha(30),
              trackOutlineWidth: WidgetStatePropertyAll(1),
              trackOutlineColor: WidgetStateColor.resolveWith(
                _resolveTrackOutlineColor,
              ),
              onChanged: _onChanged,
            ),
          ],
        ),
      ],
    );
  }
}

class _CustomLabel extends StatelessWidget {
  const _CustomLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
