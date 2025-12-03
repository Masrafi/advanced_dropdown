import 'package:flutter/material.dart';
import 'package:advanced_dropdown/advanced_dropdown.dart';

class AdvancedDropdownDemo extends StatefulWidget {
  const AdvancedDropdownDemo({super.key});

  @override
  State<AdvancedDropdownDemo> createState() => _AdvancedDropdownDemoState();
}

class _AdvancedDropdownDemoState extends State<AdvancedDropdownDemo> {
  // For single select
  dynamic _selectedFruit;
  dynamic _selectedFruitSearch;

  // For multi select
  List<dynamic> _selectedColors = [];
  List<dynamic> _selectedColorsMultiple = [];

  // For map-based dropdown
  dynamic _selectedCountry;
  List<dynamic> _selectedCities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Advanced Dropdown Example")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ------------------------------------------------------------------
            /// SINGLE SELECT
            /// ------------------------------------------------------------------
            const Text(
              "Single Select Dropdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            AdvancedDropdown(
              items: ['Apple', 'Banana', 'Cherry', 'Mango', 'Orange'],

              initialValue: 'Cherry', // Preselected

              onChanged: (value) {
                setState(() => _selectedFruit = value);
              },

              hintText: "Select your favorite fruit",
              hintStyle: const TextStyle(color: Colors.grey),

              selectedTextStyle: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),

              itemTextStyle: const TextStyle(fontSize: 16),

              icon: const Icon(Icons.arrow_drop_down),

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),

              dropdownDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Text("Selected: ${_selectedFruit ?? "None"}"),

            const Divider(height: 40),


            /// ------------------------------------------------------------------
            /// SINGLE SELECT WITH SEARCH
            /// ------------------------------------------------------------------
            const Text(
              "Single Select Dropdown with Search",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            AdvancedDropdown(
              items: ['Apple', 'Banana', 'Cherry', 'Mango', 'Orange'],

              isSearch: true,

              onChanged: (value) {
                setState(() => _selectedFruitSearch = value);
              },

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400, width: 1),
                color: Colors.white,
              ),

              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),

              inputDecoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                hintText: 'Search fruit',
                prefixIcon: const Icon(Icons.search, size: 20),
              ),

              icon: const Icon(Icons.arrow_drop_down),
              hintText: "Select your favorite fruit",
              hintStyle: const TextStyle(color: Colors.grey),
              itemTextStyle: const TextStyle(fontSize: 16),
              selectedTextStyle: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              chipColor: const Color(0xFFD0E6FF),
              chipTextColor: Colors.black,
              chipTextStyle: const TextStyle(fontWeight: FontWeight.w500),
              chipRemoveIconColor: Colors.black54,
            ),

            const SizedBox(height: 8),
            Text("Selected: ${_selectedFruitSearch ?? "None"}"),

            const Divider(height: 40),


            /// ------------------------------------------------------------------
            /// MULTI SELECT
            /// ------------------------------------------------------------------
            const Text(
              "Multi Select Dropdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            AdvancedDropdown(
              items: ['Red', 'Blue', 'Green', 'Yellow', 'Black'],
              isMultiSelect: true,

              maxSelection: 2,   // User can select maximum 2 items

              initialValues: ['Blue'], // Pre-selected

              onChanged: (values) {
                setState(() => _selectedColors = values);
              },

              hintText: "Select colors",

              chipColor: Colors.blue.shade100,
              chipTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Selected: ${_selectedColors.join(", ")}"),

            const Divider(height: 40),


            /// ------------------------------------------------------------------
            /// MULTI SELECT WITH SEARCH
            /// ------------------------------------------------------------------
            const Text(
              "Multi Select Dropdown with Search",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            AdvancedDropdown(
              items: ['Red', 'Blue', 'Green', 'Yellow', 'Black'],
              isSearch: true,
              isMultiSelect: true,

              onChanged: (values) {
                setState(() => _selectedColorsMultiple = values);
              },

              hintText: "Select colors",

              chipColor: Colors.blue.shade100,
              chipTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Selected: ${_selectedColorsMultiple.join(", ")}"),

            const Divider(height: 40),


            /// ------------------------------------------------------------------
            /// MAP BASED DROPDOWN (SINGLE SELECT)
            /// ------------------------------------------------------------------
            const Text(
              "Map-based Dropdown (Single Select)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            AdvancedDropdown(
              items: const [
                {'label': 'United States', 'value': 'US'},
                {'label': 'Bangladesh', 'value': 'BD'},
                {'label': 'India', 'value': 'IN'},
                {'label': 'Germany', 'value': 'DE'},
                {'label': 'Japan', 'value': 'JP'},
              ],

              labelBuilder: (item) => item['label'],
              valueBuilder: (item) => item['value'],

              onChanged: (value) {
                setState(() => _selectedCountry = value);
              },

              hintText: "Select a country",

              selectedTextStyle: const TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),

              itemTextStyle: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text("Selected Country: ${_selectedCountry ?? "None"}"),

            const Divider(height: 40),


            /// ------------------------------------------------------------------
            /// MAP BASED DROPDOWN (MULTI SELECT)
            /// ------------------------------------------------------------------
            const Text(
              "Map-based Dropdown (Multi Select)",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            AdvancedDropdown(
              items: const [
                {'label': 'New York', 'value': 1},
                {'label': 'London', 'value': 2},
                {'label': 'Tokyo', 'value': 3},
                {'label': 'Delhi', 'value': 4},
              ],

              isSearch: true,
              isMultiSelect: true,

              labelBuilder: (item) => item['label'],
              valueBuilder: (item) => item['value'],

              initialValues: [1, 4],

              onChanged: (values) {
                setState(() => _selectedCities = values);
              },

              hintText: "Select cities",

              chipColor: Colors.teal.shade100,
              chipTextStyle: const TextStyle(color: Colors.teal),
            ),
            const SizedBox(height: 8),
            Text("Selected Cities IDs: ${_selectedCities.join(", ")}"),

            const SizedBox(height: 500),
          ],
        ),
      ),
    );
  }
}