import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/access_menu_provider.dart';

/// Recursive widget for displaying menu items with hierarchical structure
class MenuAccessItemWidget extends StatefulWidget {
  const MenuAccessItemWidget({
    super.key,
    required this.menu,
  });

  final dynamic menu; // MenuAccessEntity

  @override
  State<MenuAccessItemWidget> createState() => _MenuAccessItemWidgetState();
}

class _MenuAccessItemWidgetState extends State<MenuAccessItemWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final hasChildren = widget.menu.children != null && 
                        (widget.menu.children as List).isNotEmpty;

    return Consumer<AccessMenuProvider>(
      builder: (context, provider, child) {
        final isSelected = provider.currentSelectedIds.contains(widget.menu.id);

        void toggleSelect() {
          if (isSelected) {
            provider.unselectMenu(widget.menu.id);
          } else {
            provider.selectMenu(widget.menu.id);
          }
        }

        return Container(
          margin: const EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.black26),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: hasChildren
                    ? () => setState(() => _expanded = !_expanded)
                    : null,
                minLeadingWidth: 0,
                contentPadding: const EdgeInsets.only(left: 4, right: 18),
                leading: Checkbox(
                  value: isSelected,
                  onChanged: (_) => toggleSelect(),
                  side: const BorderSide(color: Colors.black38, width: 2),
                  fillColor: WidgetStateColor.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.red;
                    }
                    return Colors.transparent;
                  }),
                ),
                title: Text(
                  widget.menu.name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                trailing: hasChildren
                    ? Icon(
                        _expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: Colors.black54,
                      )
                    : null,
              ),
              if (_expanded && hasChildren)
                ...List.generate(
                  (widget.menu.children as List).length,
                  (index) {
                    final child = (widget.menu.children as List)[index];
                    return MenuAccessItemWidget(menu: child);
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}

