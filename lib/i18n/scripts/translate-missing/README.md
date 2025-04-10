## Setup

Navigate to this directory in your terminal and execute the following steps:

### 1. Create a Virtual Environment

```bash
python -m venv env
source env/bin/activate  # On MacOs
.\env\Scripts\activate   # On Windows (or `env\\Scripts\\activate`)
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

## Generating translations

### 1. Generate the inputs to be translated

In the app root directory, run the following command to analyze the current translation files and find the missing translations:

```bash
dart run slang analyze --outdir=lib/i18n/scripts/translate-missing
```

A file called `_missing_translations.json` should have been generated here with the missing translations.

### 2. Translate the inputs

Go to this folder in your terminal and run

```bash
python translate-missing.py
```

This overwrite the previously generated file putting the translated values when needed

### 3. Confirm the translations

Verify that all the translations make sense and apply them using the folloing command in the root folder of the app:

```bash
dart run slang apply --outdir=lib/i18n/scripts/translate-missing
```
