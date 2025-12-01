import 'package:flutter/material.dart';

/// 🧩 AdvancedDropdown
/// A flexible, fully customizable dropdown for Flutter.
///
/// ✅ Features:
/// - Single select & multi-select
/// - Searchable dropdown
/// - Preselected values from backend
/// - Works with List<String> or List<Map<String, dynamic>>
/// - Customizable decoration, colors, and icons
/// - Max selection limit
/// - Chips with remove option for multi-select
///
/// Example:
/// ```dart
/// AdvancedDropdown(
///   items: [
///     {'id': 1, 'name': 'Flutter'},
///     {'id': 2, 'name': 'React'},
///     {'id': 3, 'name': 'Vue'},
///   ],
///   displayField: 'name',
///   valueField: 'id',
///   isMultiSelect: true,
///   initialValues: [1, 3],
///   maxSelection: 3,
///   chipColor: Colors.blue.shade100,
///   onChanged: (val) => print(val),
/// )
/// ```
class AdvancedDropdown extends StatefulWidget {
  /// List of items. Can be List<String>, List<dynamic>, or List<Map<String, dynamic>>
  final List<dynamic> items;

  /// Callback when selection changes
  final Function(dynamic) onChanged;

  /// Whether to enable the search bar inside dropdown
  final bool isSearch;

  /// Whether multiple selections are allowed
  final bool isMultiSelect;

  /// Optional decoration for the main dropdown button
  final BoxDecoration? decoration;

  /// Optional decoration for the dropdown popup
  final BoxDecoration? dropdownDecoration;

  /// Optional decoration for the search field
  final InputDecoration? inputDecoration;

  final EdgeInsets padding;

  /// Optional dropdown icon (default: arrow)
  final Icon? icon;

  /// Maximum number of items that can be selected in multi-select
  final int? maxSelection;

  /// Background color of selected chips (for multi-select)
  final Color chipColor;

  /// Text color of selected chips
  final Color chipTextColor;

  /// Remove (×) icon color for chips
  final Color chipRemoveIconColor;

  /// Label extractor for custom map items
  final String Function(dynamic)? labelBuilder;

  /// Value extractor for custom map items
  final dynamic Function(dynamic)? valueBuilder;

  /// Initial value for single-select
  final dynamic initialValue;

  /// Initial values for multi-select
  final List<dynamic>? initialValues;

  /// Hint text for unselected dropdown
  final String? hintText;

  /// Text style for hint text
  final TextStyle? hintStyle;

  /// Text style for dropdown list items
  final TextStyle? itemTextStyle;

  /// Text style for selected value (single select)
  final TextStyle? selectedTextStyle;

  /// Text style for chips (multi select)
  final TextStyle? chipTextStyle;

  const AdvancedDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.isSearch = false,
    this.isMultiSelect = false,
    this.inputDecoration,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.decoration,
    this.dropdownDecoration,
    this.icon,
    this.maxSelection,
    this.labelBuilder,
    this.valueBuilder,
    this.initialValue,
    this.initialValues,
    this.hintText,
    this.hintStyle,
    this.itemTextStyle,
    this.selectedTextStyle,
    this.chipTextStyle,
    this.chipColor = const Color(0xFFD0E6FF),
    this.chipTextColor = Colors.black,
    this.chipRemoveIconColor = Colors.black54,
  });

  @override
  State<AdvancedDropdown> createState() => _AdvancedDropdownState();
}

class _AdvancedDropdownState extends State<AdvancedDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  String? _selectedLabel; // for single select
  final List<String> _selectedLabels = []; // for multi select
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    // Handle preselected values
    if (widget.isMultiSelect && widget.initialValues != null) {
      _selectedLabels.addAll(
        widget.initialValues!.map((v) {
          final item = widget.items.firstWhere((it) => _getValue(it) == v, orElse: () => null);
          return item != null ? _getLabel(item) : v.toString();
        }),
      );
    } else if (!widget.isMultiSelect && widget.initialValue != null) {
      final item = widget.items.firstWhere((it) => _getValue(it) == widget.initialValue, orElse: () => null);
      _selectedLabel = item != null ? _getLabel(item) : widget.initialValue.toString();
    }
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _closeDropdown();
    }
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _rebuildDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;

    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _closeDropdown,
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeDropdown,
                  child: Container(color: Colors.transparent),
                ),
              ),
              CompositedTransformFollower(
                link: _layerLink,
                offset: Offset(0, size.height + 5),
                showWhenUnlinked: false,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: size.width,
                    decoration:
                        widget.dropdownDecoration ??
                        BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                    constraints: const BoxConstraints(maxHeight: 400),
                    child: StatefulBuilder(
                      builder: (context, setInnerState) {
                        final filteredItems = widget.items
                            .where((item) => _getLabel(item).toLowerCase().contains(_searchText.toLowerCase()))
                            .toList();

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.isSearch)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  style: const TextStyle(color: Colors.black),
                                  decoration:
                                      widget.inputDecoration ??
                                      const InputDecoration(
                                        hintText: 'Search...',
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                      ),
                                  onChanged: (val) {
                                    setInnerState(() => _searchText = val);
                                  },
                                ),
                              ),
                            Flexible(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                children: filteredItems.map((item) {
                                  final label = _getLabel(item);
                                  final value = _getValue(item);
                                  final isSelected = widget.isMultiSelect && _selectedLabels.contains(label);
                                  return ListTile(
                                    title: Text(label, style: widget.itemTextStyle),
                                    trailing: widget.isMultiSelect
                                        ? Checkbox(value: isSelected, onChanged: (_) => _onItemSelect(value, label))
                                        : null,
                                    onTap: () {
                                      if (!widget.isMultiSelect) {
                                        _onItemSelect(value, label);
                                      }
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            if (widget.isMultiSelect)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(onPressed: _closeDropdown, child: const Text("OK")),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onItemSelect(dynamic value, String label) {
    setState(() {
      if (widget.isMultiSelect) {
        if (_selectedLabels.contains(label)) {
          _selectedLabels.remove(label);
        } else {
          if (widget.maxSelection != null && _selectedLabels.length >= widget.maxSelection!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('You can select up to ${widget.maxSelection} items'),
                duration: const Duration(seconds: 2),
              ),
            );
            return;
          }
          _selectedLabels.add(label);
        }
        widget.onChanged(
          _selectedLabels.map((lbl) => _getValue(widget.items.firstWhere((it) => _getLabel(it) == lbl))).toList(),
        );
        _rebuildDropdown();
      } else {
        _selectedLabel = label;
        widget.onChanged(value);
        _closeDropdown();
      }
    });
  }

  String _getLabel(dynamic item) {
    if (widget.labelBuilder != null) return widget.labelBuilder!(item);
    if (item is Map && item.containsKey('label')) return item['label'].toString();
    return item.toString();
  }

  dynamic _getValue(dynamic item) {
    if (widget.valueBuilder != null) return widget.valueBuilder!(item);
    if (item is Map && item.containsKey('value')) return item['value'];
    return item;
  }

  Widget _buildChips() {
    return Wrap(
      spacing: 6,
      runSpacing: -6,
      children: _selectedLabels.map((item) {
        return Chip(
          label: Text(item, style: widget.chipTextStyle ?? TextStyle(color: widget.chipTextColor, fontSize: 14)),
          backgroundColor: widget.chipColor,
          deleteIcon: Icon(Icons.close, color: widget.chipRemoveIconColor),
          onDeleted: () {
            setState(() {
              _selectedLabels.remove(item);
              widget.onChanged(
                _selectedLabels.map((lbl) => _getValue(widget.items.firstWhere((it) => _getLabel(it) == lbl))).toList(),
              );
            });
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: widget.padding,
          decoration:
              widget.decoration ??
              BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: widget.isMultiSelect
                    ? (_selectedLabels.isEmpty
                          ? Text(
                              widget.hintText ?? 'Select items',
                              style: widget.hintStyle ?? const TextStyle(color: Colors.grey),
                            )
                          : _buildChips())
                    : Text(
                        _selectedLabel ?? (widget.hintText ?? 'Select item'),
                        style: _selectedLabel == null
                            ? (widget.hintStyle ?? const TextStyle(color: Colors.grey))
                            : widget.selectedTextStyle,
                      ),
              ),
              const SizedBox(width: 6),
              widget.icon ?? const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
