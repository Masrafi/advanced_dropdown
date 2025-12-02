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

           /// ---------------- SINGLE SELECT ----------------
            const Text( "Single Select Dropdown",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
            const SizedBox(height: 8),
            AdvancedDropdown(
              items: ['Apple', 'Banana', 'Cherry', 'Mango', 'Orange'],
              initialValue: 'Cherry', // Preselected
              onChanged: (value) {
                setState(() => _selectedFruit = value);
              },
              //decoration: BoxDecoration(),
              hintText: "Select your favorite fruit",
              hintStyle: const TextStyle(color: Colors.grey),
              selectedTextStyle: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
              itemTextStyle: const TextStyle(fontSize: 16),
              icon: Icon(Icons.add),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            ),
            const SizedBox(height: 8),
            Text("Selected: ${_selectedFruit ?? "None"}"), 

           
           /// ---------------- SINGLE SELECT SEARCH ----------------
            const Text( "Single Select Dropdown with Search",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
            const SizedBox(height: 8),
           AdvancedDropdown(
             items: ['Apple', 'Banana', 'Cherry', 'Mango', 'Orange'],

             // Preselect a value for single select mode
             // initialValue: 'Cherry',

             // Called when the selection changes
             onChanged: (value) {
               setState(() => _selectedFruitSearch = value);
             },

             // Enable search bar in dropdown popup
             isSearch: true,

             // Enable multi-selection mode (checkboxes + chips)
             // isMultiSelect: false,

             // Label builder for complex data (e.g. List<Map<String, dynamic>>)
             // labelBuilder: (item) => item['label'],

             // Value builder for selection logic
             // valueBuilder: (item) => item['value'],

             // Decoration for the dropdown button itself
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               border: Border.all(color: Colors.grey.shade400, width: 1),
               color: Colors.white,
             ),

             // Decoration for the dropdown popup container
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

             // Decoration for the search field inside dropdown popup
             inputDecoration: InputDecoration(
               contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
               border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
               hintText: 'Search fruit',
               prefixIcon: Icon(Icons.search, size: 20),
             ),

             // Dropdown icon next to the button
             icon: const Icon(Icons.arrow_drop_down),

             // Hint text when nothing is selected
             hintText: "Select your favorite fruit",

             // Style for the hint text
             hintStyle: const TextStyle(color: Colors.grey),

             // Style for the dropdown list items
             itemTextStyle: const TextStyle(fontSize: 16),

             // Style for selected item(s) shown inside the button
             selectedTextStyle: const TextStyle(
               color: Colors.blue,
               fontWeight: FontWeight.w600,
             ),

             // Background color for chips in multi-select mode
             chipColor: const Color(0xFFD0E6FF),

             // Text color for chips in multi-select mode
             chipTextColor: Colors.black,

             // Text style for chips
             chipTextStyle: const TextStyle(fontWeight: FontWeight.w500),

             // Color for the chip remove (×) icon
             chipRemoveIconColor: Colors.black54,

             // Maximum number of selections allowed in multi-select mode
             // maxSelection: 3,

             // Standard Flutter key (optional)
             // key: Key('fruit-dropdown'),
           ),


            const SizedBox(height: 8),
            Text("Selected: ${_selectedFruitSearch ?? "None"}"),
            const Divider(height: 40),

           
           /// ---------------- MULTI SELECT ----------------
            const Text(
              "Multi Select Dropdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AdvancedDropdown(
              items: ['Red', 'Blue', 'Green', 'Yellow', 'Black'],
              isMultiSelect: true,
              maxSelection: 2,   /// user can not select more then 2
              initialValues: ['Blue'], // Preselected
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
           
           
           /// ---------------- MULTI SELECT SEARCH ----------------
            const Text(
              "Multi Select Dropdown with Search",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            AdvancedDropdown(
            isSearch: true,
              items: ['Red', 'Blue', 'Green', 'Yellow', 'Black'],
              isMultiSelect: true,
              initialValues: [], // Preselected
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

           
           /// ---------------- MAP BASED DROPDOWN (SINGLE SELECT) ----------------
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
              //initialValue: 'Germany', // Preselected by value
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

           
           /// ---------------- MAP BASED DROPDOWN (MULTI SELECT) ----------------
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
              initialValues: [1, 4], // Preselected by value
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