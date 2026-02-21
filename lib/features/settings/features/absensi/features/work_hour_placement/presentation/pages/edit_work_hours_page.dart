import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';

class EditWorkHoursPage extends StatefulWidget {
  const EditWorkHoursPage({super.key, required this.name});
  final String name;

  @override
  State<EditWorkHoursPage> createState() => _EditWorkHoursPageState();
}

class _EditWorkHoursPageState extends State<EditWorkHoursPage> {
  final startClockInController = TextEditingController();
  final lateClockInController = TextEditingController();
  final endClockInController = TextEditingController();
  final startBreakController = TextEditingController();
  final lateBreakController = TextEditingController();
  final endBreakController = TextEditingController();
  final startClockOutController = TextEditingController();
  final endClockOutController = TextEditingController();

  bool _valid = false;

  void _validate() {
    final controllers = [
      startClockInController,
      lateClockInController,
      endClockInController,
      startBreakController,
      lateBreakController,
      endBreakController,
      startClockOutController,
      endClockOutController,
    ];

    bool valid = true;
    for (var controller in controllers) {
      if (controller.text.isEmpty) valid = false;
    }
    setState(() => _valid = valid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Atur Hari ${widget.name}"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            _HourFormField(
              controller: startClockInController,
              label: "Awal Jam Masuk",
              onChanged: _validate,
            ),
            _HourFormField(
              controller: lateClockInController,
              label: "Telat Masuk",
              onChanged: _validate,
            ),
            _HourFormField(
              controller: endClockInController,
              label: "Akhir Jam Masuk",
              onChanged: _validate,
            ),
            _HourFormField(
              controller: startBreakController,
              label: "Awal Masuk Istirahat",
              onChanged: _validate,
            ),
            _HourFormField(
              controller: lateBreakController,
              label: "Telat Masuk Istirahat",
              onChanged: _validate,
            ),
            _HourFormField(
              controller: endBreakController,
              label: "Akhir Masuk Istirahat",
              onChanged: _validate,
            ),
            _HourFormField(
              controller: startClockOutController,
              label: "Awal Jam Pulang",
              onChanged: _validate,
            ),
            _HourFormField(
              controller: endClockOutController,
              label: "Akhir Jam Pulang",
              onChanged: _validate,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomElevatedButton(
          onPressed: () => context.pop(),
          loading: !_valid,
          child: Text("Simpan"),
        ),
      ),
    );
  }
}

class _HourFormField extends StatelessWidget {
  const _HourFormField({
    required this.controller,
    required this.label,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final VoidCallback onChanged;

  void _showPicker(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => _HourPicker(textController: controller),
    );
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        TextField(
          controller: controller,
          onTap: () => _showPicker(context),
          readOnly: true,
          decoration: InputDecoration(
            hintText: "Atur $label",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            enabledBorder: _buildBorder(),
            errorBorder: _buildBorder(),
            focusedBorder: _buildBorder(),
            focusedErrorBorder: _buildBorder(),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }

  InputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey),
    );
  }
}

class _HourPicker extends StatefulWidget {
  const _HourPicker({required this.textController});
  final TextEditingController textController;

  @override
  State<_HourPicker> createState() => _HourPickerState();
}

class _HourPickerState extends State<_HourPicker> {
  late FixedExtentScrollController scrollControllerHour;
  late FixedExtentScrollController scrollControllerMinute;

  int selectedHour = 8;
  int selectedMinute = 0;
  int startHour = 0;
  int endHour = 23;
  int startMinute = 0;
  int endMinute = 59;

  @override
  void initState() {
    super.initState();
    scrollControllerHour = FixedExtentScrollController(
      initialItem: selectedHour,
    );
    scrollControllerMinute = FixedExtentScrollController(
      initialItem: selectedMinute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width - 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Pilih Jam',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade100,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildWheel(
                      controller: scrollControllerHour,
                      onChanged: (index) {
                        setState(() => selectedHour = index + startHour);
                      },
                      start: startHour,
                      end: endHour,
                      value: selectedHour,
                    ),
                    const Text(
                      ':',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    _buildWheel(
                      controller: scrollControllerMinute,
                      onChanged: (index) {
                        setState(() => selectedMinute = index + startMinute);
                      },
                      start: startMinute,
                      end: endMinute,
                      value: selectedMinute,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final hourString = "$selectedHour".padLeft(2, "0");
                  final minuteString = "$selectedMinute".padLeft(2, "0");
                  String formattedTime = "$hourString:$minuteString";
                  widget.textController.text = formattedTime;
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'Pilih',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWheel({
    required ScrollController controller,
    required Function(int index) onChanged,
    required int start,
    required int end,
    required int value,
  }) {
    return SizedBox(
      height: 150,
      width: 60,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onChanged,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List.generate(end - start + 1, (index) {
            final currentValue = index + start;
            String displayedHour = "$currentValue".padLeft(2, "0");
            return Center(
              child: Text(
                displayedHour,
                style: TextStyle(
                  fontSize: 24,
                  color: value == currentValue ? Colors.black : Colors.grey,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
