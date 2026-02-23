import 'package:flutter/material.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';

class PercentageSlider extends StatefulWidget {
  const PercentageSlider({super.key, this.onChanged});
  final void Function(double value)? onChanged;

  @override
  State<PercentageSlider> createState() => _PercentageSliderState();
}

class _PercentageSliderState extends State<PercentageSlider> {
  double _value = 50;

  void _onChanged(double value) {
    setState(() => _value = value);
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4),
        _CustomLabel("Atur Presentase"),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: _value,
                min: 0,
                max: 100,
                divisions: 10,
                onChanged: _onChanged,
                label: "${_value.round()}%",
                inactiveColor: Colors.grey.shade300,
                activeColor: AppColors.blue,
                thumbColor: Colors.grey.shade400,
                padding: EdgeInsets.zero,
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 50,
              child: Text(
                "${_value.round()}%",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
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
