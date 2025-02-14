# Translations Contributing Guide for Monekin

Welcome! This guide explains how you can contribute in our app translations. We welcome both technical and non-technical contributors to improve and add translations. Thank you for helping make this app accessible to more people!

---

## Where Are the Translations Stored?

Translations are stored in the **JSON files** located in the `/json` directory, with one file per language.

JSON files are simple text files that are normally used to organize information. Each file has the following naming format:

- **`en.json`**: English
- **`es.json`**: Spanish
- **`fr.json`**: French

To find your language code, you can use [this resource](https://en.wikipedia.org/wiki/List_of_ISO_639_language_codes).

---

## How Are Translations Organized?

Each JSON file contains the translated texts that appears in the app. Here's a simple example:

```json
{
  "welcome": "Welcome!",
  "expense_summary": "Expense Summary",
  "add_transaction": "Add Transaction"
}
```

As you will see, each line inside this type of files has:

- The **keys** (like `welcome`, `expense_summary`) must stay the same.
- The **values** (like `"Welcome!"`) are the words that need to be translated.

> **Important:** Only change the text inside the quotation marks (`"`).

---

## How to Contribute Translations

### For Non-Technical Contributors

If you are not familiar with GitHub or JSON, don’t worry! Follow these steps:

1. **Download a JSON file**: Choose one of the already created JSON file that is in the `/json` directory, for the language you want to translate (e.g., `en.json` for English). Create a copy of this file and rename it with the corresponding language code if you want to add another language to the app.

2. **Edit the file**:

   - Open the file in a text editor (e.g., Notepad or TextEdit).
   - Translate the text on the right side of the `:` for each entry. That is, modify the values of each key.

   Example:

   ```json
   {
     "welcome": "Bienvenido!",
     "expense_summary": "Resumen de gastos",
     "add_transaction": "Añadir transacción"
   }
   ```

3. **Save your changes**.

4. **Send the file via email**:
   - You could email your new translations files to **lozin.technologies@gmail.com** using as the subject line something like: _Translation Contribution for [Language]_.

### For Technical Contributors

If you are familiar with GitHub and JSON files, please follow the [developer contribution guide](https://github.com/enrique-lozano/Monekin/blob/main/docs/CODE_CONTRIBUTING.md) to fork the project, add/modify your translations, and create a Pull Request (PR).

If you want to apply and view your new generated/edited translations in your local project you should run:

```bash
dart run slang
```

You can learn more about the slang library tools in the [docs](https://github.com/slang-i18n/slang/tree/main?tab=readme-ov-file#tools). We also provide a Python script to automatically translate missing keys. You can see more info about it in the `/scripts/translate-missing` directory.

---

## Best Practices for Translating

- **Keep the keys unchanged**: Only modify the text inside the quotation marks.
- **Maintain formatting**: Be careful not to add or remove commas, braces, or other symbols.
- **Keep it consistent**: Match the tone and style of the existing translations.
- **Test your translations**: Read them aloud to ensure they sound natural.
- **Ask questions**: If something is unclear, feel free to write in the [Monekin Forum](https://github.com/enrique-lozano/Monekin/discussions/categories/q-a).

---

## Resources to Help You

- **What is JSON?** [Learn JSON Basics](https://www.w3schools.com/js/js_json_intro.asp)
- **Translation Tips**: [Tips for Translators](https://www.tomedes.com/translator-hub/tips-for-new-translators)
- **Validate your JSON**: Use [this resoruce](https://jsonlint.com/) to check if there are any error with your JSON file

## Questions?

If you have any doubts or need further guidance, feel free to ask! You can:

- **Post on the Forum**: Join discussions or raise your queries in our [community forum](https://github.com/enrique-lozano/Monekin/discussions).
- **Contact Directly**: Reach out to me via email at [lozin.technologies@gmail.com].

We’re here to help and excited to see your contributions to Monekin!
