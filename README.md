## 📸 Screenshots

| Custom Decoration                                       | Single Select                                   | Single Select with Search                                          | Multi Select                                  | Multi Select with Search                                         |
|---------------------------------------------------------|-------------------------------------------------|--------------------------------------------------------------------|-----------------------------------------------|------------------------------------------------------------------|
| ![Custom Decoration](screenshots/custom_decoration.png) | ![Single Select](screenshots/single_select.png) | ![Single Select with Search](screenshots/single_select_search.png) | ![Multi Select](screenshots/multi_select.png) | ![Multi Select with Search](screenshots/multi_select_search.png) |


# 🧩 Custom Dropdown for Flutter

A **fully customizable dropdown widget** for Flutter that supports **single-select**, **multi-select**, and **search** — all in one widget.  
Lightweight, flexible, and easy to integrate into any Flutter project.

---

## 📱 Platform Support

| Platform | Supported | Tested |
|-----------|------------|---------|
| Android | ✅ | ✅ |
| iOS | ✅ | ✅ |
| Web | ✅ | ✅ |
| Windows | ✅ | ⚙️ |
| macOS | ✅ | ⚙️ |
| Linux | ✅ | ⚙️ |

> 💡 Works with **Flutter 3.0+** and **Dart 3.0+**

---

## ✨ Features

✅ **Single Select (default)** — behaves like a normal dropdown  
✅ **Multi Select** — users can select multiple items  
✅ **Searchable Dropdown** — optional search bar for filtering  
✅ **Flexible Decoration** — customize dropdown and list appearance  
✅ **Custom InputDecoration** for search bar  
✅ **Auto position below the button**  
✅ **Lightweight (~3 KB compressed)**  
✅ **No external dependencies**
✅ **Custom Dropdown Button Design**
✅ **Custom Dropdown Icon**

---

## ⚙️ Customization Options

Below is a complete list of customizable properties available in the **`AdvancedDropdown`** widget.

| Property                | Type                                              | Required | Default                                                    | Description                                                                                                                |
|-------------------------|---------------------------------------------------|----------|------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| **items**               | `List<dynamic>` <br/>`List<Map<String, dynamic>>` | ✅ Yes    | –                                                          | The list of items to display in the dropdown. Supports both plain `List<String>` and complex `List<Map<String, dynamic>>`. |
| **onChanged**           | `Function(dynamic)`                               | ✅ Yes    | –                                                          | Callback triggered when a selection changes. Returns a single value (for single select) or a list (for multi-select).      |
| **isSearch**            | `bool`                                            | ❌ No     | `false`                                                    | Enables a search bar for filtering dropdown items.                                                                         |
| **isMultiSelect**       | `bool`                                            | ❌ No     | `false`                                                    | Enables multiple selection mode with checkboxes and removable chips.                                                       |
| **labelBuilder**        | `String Function(dynamic)?`                       | ❌ No     | `null`                                                     | Defines how to display text for each dropdown item (especially for `Map` data). Example: `(item) => item['label']`.        |
| **valueBuilder**        | `dynamic Function(dynamic)?`                      | ❌ No     | `null`                                                     | Defines the actual value used in selection logic. Example: `(item) => item['value']`.                                      |
| **initialValue**        | `dynamic`                                         | ❌ No     | `null`                                                     | Preselects a value for **single-select** dropdowns — ideal for restoring saved data.                                       |
| **initialValues**       | `List<dynamic>?`                                  | ❌ No     | `null`                                                     | Preselects multiple values for **multi-select** dropdowns — ideal for restoring saved user preferences.                    |
| **maxSelection**        | `int?`                                            | ❌ No     | `null`                                                     | Sets a limit for maximum selected items in multi-select mode. Displays a `SnackBar` when exceeded.                         |
| **decoration**          | `BoxDecoration?`                                  | ❌ No     | `null`                                                     | Customizes the main dropdown button (border, color, shape, etc.).                                                          |
| **dropdownDecoration**  | `BoxDecoration?`                                  | ❌ No     | `null`                                                     | Styles the dropdown popup container.                                                                                       |
| **inputDecoration**     | `InputDecoration?`                                | ❌ No     | `null`                                                     | Customizes the search field’s appearance and behavior.                                                                     |
| **icon**                | `Icon?`                                           | ❌ No     | `Icon(Icons.arrow_drop_down)`                              | The dropdown icon displayed beside the main button.                                                                        |
| **hintText**            | `String?`                                         | ❌ No     | `"Select item"`                                            | Text displayed when no item is selected.                                                                                   |
| **hintStyle**           | `TextStyle?`                                      | ❌ No     | `null`                                                     | Custom text style for the hint text.                                                                                       |
| **itemTextStyle**       | `TextStyle?`                                      | ❌ No     | `null`                                                     | Text style for dropdown list items.                                                                                        |
| **selectedTextStyle**   | `TextStyle?`                                      | ❌ No     | `null`                                                     | Text style for selected item(s) inside the main dropdown.                                                                  |
| **chipColor**           | `Color`                                           | ❌ No     | `Color(0xFFD0E6FF)`                                        | Background color for chips in multi-select mode.                                                                           |
| **chipTextColor**       | `Color`                                           | ❌ No     | `Colors.black`                                             | Default text color for chip labels.                                                                                        |
| **chipTextStyle**       | `TextStyle?`                                      | ❌ No     | `null`                                                     | Allows full customization of chip text (font, size, weight, etc.).                                                         |
| **chipRemoveIconColor** | `Color`                                           | ❌ No     | `Colors.black54`                                           | Color for the chip’s remove (×) icon.                                                                                      |
| **key**                 | `Key?`                                            | ❌ No     | `null`                                                     | Standard Flutter key for widget identification or testing.                                                                 |
| **padding**             | `Padding?`                                        | ❌ No     | `const EdgeInsets.symmetric(horizontal: 20, vertical: 20)` | Customize padding for better UI design                                                                                     |

---

## 💡 Notes

- Use labelBuilder and valueBuilder for complex data structures (List<Map<String, dynamic>>).
- initialValue and initialValues are perfect for restoring selections when reloading saved data.
- You can mix and match text styles (hintStyle, itemTextStyle, chipTextStyle) for full design flexibility.
- Default mode = **Single Select**
- When `isMultiSelect: true`, the `onChanged` callback returns a **List** of selected items.
- Dropdown automatically opens **below the button**.
- The dropdown closes automatically when clicking outside its overlay area.
- You can style **everything** (dropdown, button, list, search bar).
- Works seamlessly with **light** and **dark** themes.

---