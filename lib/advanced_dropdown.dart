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
  final List<dynamic> items;
  final Function(dynamic) onChanged;

  final bool isSearch;
  final bool isMultiSelect;

  /// Main dropdown field decoration
  final BoxDecoration? decoration;

  /// Popup dropdown decoration (separate)
  final BoxDecoration? dropdownDecoration;

  /// Search field decoration
  final InputDecoration? inputDecoration;

  /// Padding inside dropdown field
  final EdgeInsets padding;

  /// Dropdown icon
  final Icon? icon;

  /// Maximum number of items that can be selected in multi-select
  final int? maxSelection;

  final String Function(dynamic)? labelBuilder;
  final dynamic Function(dynamic)? valueBuilder;

  final dynamic initialValue;
  final List<dynamic>? initialValues;

  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? itemTextStyle;
  final TextStyle? selectedTextStyle;
  final TextStyle? chipTextStyle;

  final Color chipColor;
  final Color chipTextColor;
  final Color chipRemoveIconColor;

  const AdvancedDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.isSearch = false,
    this.isMultiSelect = false,
    this.decoration,
    this.dropdownDecoration,
    this.inputDecoration,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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

  String? _selectedLabel;
  List<String> _selectedLabels = [];
  String _searchText = '';

  @override
  void initState() {
    super.initState();

    // Pre-selected multi-select items
    if (widget.isMultiSelect && widget.initialValues != null) {
      _selectedLabels = widget.initialValues!
          .map((v) {
            final item = widget.items.firstWhere(
              (it) => _getValue(it) == v,
              orElse: () => null,
            );
            return item != null ? _getLabel(item) : v.toString();
          })
          .toList();
    }

    // Pre-selected single-select item
    if (!widget.isMultiSelect && widget.initialValue != null) {
      final item = widget.items.firstWhere(
        (it) => _getValue(it) == widget.initialValue,
        orElse: () => null,
      );
      _selectedLabel = item != null
          ? _getLabel(item)
          : widget.initialValue.toString();
    }
  }

  // ================= OVERLAY =================

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

  void _refreshDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox box = context.findRenderObject() as RenderBox;
    Size fieldSize = box.size;

    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final fieldPosition = box.localToGlobal(Offset.zero);

    double spaceBelow = overlay.size.height - (fieldPosition.dy + fieldSize.height);
    double spaceAbove = fieldPosition.dy;

    bool openUpward = spaceBelow < 300; // auto open up if small space

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

              // POPUP
              Positioned(
                width: fieldSize.width,
                child: CompositedTransformFollower(
                  link: _layerLink,
                  showWhenUnlinked: false,
                  offset: openUpward
                      ? Offset(0, -(300.0 + 10.0))  // upward
                      : Offset(0, fieldSize.height + 5), // downward
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: widget.dropdownDecoration ??
                          BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                      constraints: BoxConstraints(
                        maxHeight: openUpward ? spaceAbove - 20 : 400,
                      ),
                      child: _buildPopupContent(),
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

  // ================= POPUP CONTENT =================

  Widget _buildPopupContent() {
    return StatefulBuilder(
      builder: (context, setInner) {
        final filtered = widget.items
            .where((item) =>
                _getLabel(item).toLowerCase().contains(_searchText.toLowerCase()))
            .toList();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isSearch)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: widget.inputDecoration ??
                      const InputDecoration(
                        hintText: "Search...",
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                  onChanged: (v) {
                    setInner(() => _searchText = v);
                  },
                ),
              ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: filtered.map((item) {
                  final label = _getLabel(item);
                  final value = _getValue(item);

                  final isSelected = widget.isMultiSelect &&
                      _selectedLabels.contains(label);

                  return ListTile(
                    title: Text(label, style: widget.itemTextStyle),
                    trailing: widget.isMultiSelect
                        ? Checkbox(
                            value: isSelected,
                            onChanged: (_) => _onItemSelect(value, label),
                          )
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
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: _closeDropdown,
                  child: const Text("OK"),
                ),
              ),
          ],
        );
      },
    );
  }

  // ================= SELECTION LOGIC =================

  void _onItemSelect(dynamic value, String label) {
    setState(() {
      if (widget.isMultiSelect) {
        if (_selectedLabels.contains(label)) {
          _selectedLabels.remove(label);
        } else {
          if (widget.maxSelection != null &&
              _selectedLabels.length >= widget.maxSelection!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "You can select up to ${widget.maxSelection} items"),
              ),
            );
            return;
          }
          _selectedLabels.add(label);
        }

        widget.onChanged(
          _selectedLabels
              .map((lbl) => _getValue(
                  widget.items.firstWhere((it) => _getLabel(it) == lbl)))
              .toList(),
        );

        _refreshDropdown();
      } else {
        _selectedLabel = label;
        widget.onChanged(value);
        _closeDropdown();
      }
    });
  }

  // ================= HELPERS =================

  String _getLabel(dynamic item) {
    if (widget.labelBuilder != null) return widget.labelBuilder!(item);
    if (item is Map && item.containsKey("label")) return item["label"].toString();
    return item.toString();
  }

  dynamic _getValue(dynamic item) {
    if (widget.valueBuilder != null) return widget.valueBuilder!(item);
    if (item is Map && item.containsKey("value")) return item["value"];
    return item;
  }

  // ================= CHIPS =================

  Widget _buildChips() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: _selectedLabels.map((label) {
        return Chip(
          label: Text(
            label,
            style: widget.chipTextStyle ??
                TextStyle(color: widget.chipTextColor, fontSize: 14),
          ),
          backgroundColor: widget.chipColor,
          deleteIcon: Icon(Icons.close, color: widget.chipRemoveIconColor),
          onDeleted: () {
            setState(() {
              _selectedLabels.remove(label);
              widget.onChanged(
                _selectedLabels
                    .map((lbl) => _getValue(widget.items
                        .firstWhere((it) => _getLabel(it) == lbl)))
                    .toList(),
              );
            });
          },
        );
      }).toList(),
    );
  }

  // ================= BUILD DROPDOWN FIELD =================

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          padding: widget.padding,
          decoration: widget.decoration ??
              BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: widget.isMultiSelect
                    ? (_selectedLabels.isEmpty
                        ? Text(
                            widget.hintText ?? "Select items",
                            style: widget.hintStyle ??
                                const TextStyle(color: Colors.grey),
                          )
                        : _buildChips())
                    : Text(
                        _selectedLabel ?? (widget.hintText ?? "Select item"),
                        style: _selectedLabel == null
                            ? widget.hintStyle ??
                                const TextStyle(color: Colors.grey)
                            : widget.selectedTextStyle,
                      ),
              ),
              const SizedBox(width: 8),
              widget.icon ?? const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}