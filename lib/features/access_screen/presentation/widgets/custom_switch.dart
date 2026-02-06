import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: value ? Colors.red.shade100 : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: value ? Colors.red : Colors.grey, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: value ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!value) ...[
              _buildIconWithCircle(
                icon: Icons.close,
                color: Colors.grey,
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: 6),
              const Text(
                "Off",
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(width: 2),
            ],
            if (value) ...[
              const SizedBox(width: 2),
              const Text(
                "On",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(width: 6),
              _buildIconWithCircle(
                icon: Icons.check,
                color: Colors.red,
                backgroundColor: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIconWithCircle({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(child: Icon(icon, size: 15, color: color)),
    );
  }
}
