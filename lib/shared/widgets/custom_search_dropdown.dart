import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_theme.dart';

class CustomSearchDropdown<T> extends StatefulWidget {
  final String hint;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final bool isLoading;
  final String? Function(T?)? validator;
  final String Function(T) itemAsString;
  final int Function(T item) itemId;
  final T Function(int id) itemFromId;
  final String prefKey;

  const CustomSearchDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    required this.itemAsString,
    required this.itemFromId,
    this.isLoading = false,
    this.hint = 'Pilih',
    this.validator,
    required this.prefKey,
    required this.itemId,
  });

  @override
  State<CustomSearchDropdown<T>> createState() =>
      _CustomSearchDropdownState<T>();
}

class _CustomSearchDropdownState<T> extends State<CustomSearchDropdown<T>> {
  SharedPreferences? _prefs;
  T? _selectedItem;

  void _onChanged(T? value) async {
    _prefs!.setInt(widget.prefKey, widget.itemId(value as T));
    widget.onChanged(value);
  }

  void _getPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void _getValue() {
    if (_prefs == null) return;
    final id = _prefs!.getInt(widget.prefKey);
    if (widget.items.isEmpty || id == null || _selectedItem != null) {
      return;
    }

    final item = widget.itemFromId(id);
    _selectedItem = item;
  }

  @override
  void initState() {
    super.initState();
    _getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    _getValue();

    return DropdownSearch<T>(
      items: (filter, infiniteScrollProps) async {
        await Future.delayed(const Duration(milliseconds: 100));
        if (filter.isEmpty) {
          return widget.items;
        }
        return widget.items
            .where(
              (item) => widget
                  .itemAsString(item)
                  .toLowerCase()
                  .contains(filter.toLowerCase()),
            )
            .toList();
      },
      popupProps: PopupProps.menu(
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: "Cari...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ),
      itemAsString: (item) => widget.itemAsString(item),
      selectedItem: _selectedItem,
      compareFn: (item1, item2) {
        return item1 == item2;
      },
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          suffixIcon: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SpinKitThreeBounce(color: AppColors.primary),
                  ),
                )
              : null,
        ),
      ),
      dropdownBuilder: (context, selectedItem) {
        final displayText = selectedItem != null
            ? widget.itemAsString(selectedItem)
            : widget.hint;
        return Text(
          displayText,
          style: TextStyle(
            color: selectedItem == null ? Colors.grey.shade600 : Colors.black87,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
      },
      onChanged: widget.isLoading ? null : _onChanged,
      enabled: !widget.isLoading,
      validator: widget.validator,
    );
  }
}
