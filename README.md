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

| Property                | Type                                               | Required | Default                                                    | Description                                                                                                                |
|-------------------------|----------------------------------------------------|----------|------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| **items**               | `List<dynamic>` <br/> `List<Map<String, dynamic>>` | ✅ Yes    | –                                                          | The list of items to show in the dropdown. Supports `List<String>` and complex maps (via `labelBuilder` / `valueBuilder`). |
| **onChanged**           | `Function(dynamic)`                                | ✅ Yes    | –                                                          | Callback when selection changes. Returns a single value in single-select mode, or a list of values in multi-select mode.   |
| **isSearch**            | `bool`                                             | ❌ No     | `false`                                                    | Enables an inline search field for filtering dropdown items.                                                               |
| **isMultiSelect**       | `bool`                                             | ❌ No     | `false`                                                    | Enables multiple selection with checkboxes and removable chips.                                                            |
| **labelBuilder**        | `String Function(dynamic)?`                        | ❌ No     | `null`                                                     | Extracts a display label from each item. Example: `(item) => item['label']`.                                               |
| **valueBuilder**        | `dynamic Function(dynamic)?`                       | ❌ No     | `null`                                                     | Extracts the item’s actual selectable value. Example: `(item) => item['value']`.                                           |
| **initialValue**        | `dynamic`                                          | ❌ No     | `null`                                                     | Sets the initial selected value for **single-select** dropdowns.                                                           |
| **initialValues**       | `List<dynamic>?`                                   | ❌ No     | `null`                                                     | Sets initial selected values for **multi-select** dropdowns.                                                               |
| **maxSelection**        | `int?`                                             | ❌ No     | `null`                                                     | If set, limits how many items can be selected in multi-select mode. Shows a SnackBar if exceeded.                          |
| **decoration**          | `BoxDecoration?`                                   | ❌ No     | `null`                                                     | Styles the main dropdown button (background, border, radius, shadow).                                                      |
| **dropdownDecoration**  | `BoxDecoration?`                                   | ❌ No     | `null`                                                     | Styles the popup dropdown container (background, border, radius).                                                          |
| **inputDecoration**     | `InputDecoration?`                                 | ❌ No     | `null`                                                     | Customizes the search box appearance.                                                                                      |
| **icon**                | `Icon?`                                            | ❌ No     | `Icon(Icons.arrow_drop_down)`                              | Icon displayed on the right side of the dropdown.                                                                          |
| **hintText**            | `String?`                                          | ❌ No     | `"Select item"`                                            | Text to display when no item is selected (single or multi).                                                                |
| **hintStyle**           | `TextStyle?`                                       | ❌ No     | `null`                                                     | Styling for the hint text.                                                                                                 |
| **itemTextStyle**       | `TextStyle?`                                       | ❌ No     | `null`                                                     | Style applied to items inside the dropdown popup list.                                                                     |
| **selectedTextStyle**   | `TextStyle?`                                       | ❌ No     | `null`                                                     | Style for the selected item when using single-select.                                                                      |
| **chipColor**           | `Color`                                            | ❌ No     | `Color(0xFFD0E6FF)`                                        | Background color of chips in multi-select mode.                                                                            |
| **chipTextColor**       | `Color`                                            | ❌ No     | `Colors.black`                                             | Default chip label text color.                                                                                             |
| **chipTextStyle**       | `TextStyle?`                                       | ❌ No     | `null`                                                     | Custom chip text appearance (font, size, weight, etc.).                                                                    |
| **chipRemoveIconColor** | `Color`                                            | ❌ No     | `Colors.black54`                                           | Color of the "remove" (×) icon on chips.                                                                                   |
| **padding**             | `EdgeInsets`                                       | ❌ No     | `const EdgeInsets.symmetric(horizontal: 12, vertical: 10)` | Controls internal padding of the main dropdown field.                                                                      |
| **key**                 | `Key?`                                             | ❌ No     | `null`                                                     | Standard Flutter Key for widget identity.                                                                                  |

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