import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme/app_theme.dart';

class CustomSearchDropdown<T> extends StatefulWidget {
  final String label;
  final String hint;
  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T?> onChanged;
  final bool isLoading;
  final String? Function(T?)? validator;
  final String Function(T) itemAsString;
  final String Function(T)? itemId;

  const CustomSearchDropdown({
    super.key,
    required this.label,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    required this.itemAsString,
    this.itemId,
    this.isLoading = false,
    this.hint = 'Pilih',
    this.validator,
  });

  @override
  State<CustomSearchDropdown<T>> createState() => _CustomSearchDropdownState<T>();
}

class _CustomSearchDropdownState<T> extends State<CustomSearchDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 6),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xff404040),
              ),
            ),
          ),
        ],
        DropdownSearch<T>(
          items: (filter, infiniteScrollProps) async {
            await Future.delayed(const Duration(milliseconds: 100));
            if (filter.isEmpty) {
              return widget.items;
            }
            return widget.items
                .where(
                  (item) => widget.itemAsString(item).toLowerCase().contains(filter.toLowerCase()),
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          itemAsString: (item) => widget.itemAsString(item),
          selectedItem: widget.selectedItem,
          compareFn: (item1, item2) {
            if (widget.itemId != null) {
              return widget.itemId!(item1) == widget.itemId!(item2);
            }
            return item1 == item2;
          },
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          onChanged: widget.isLoading ? null : widget.onChanged,
          enabled: !widget.isLoading,
          validator: widget.validator,
        ),
      ],
    );
  }
}
