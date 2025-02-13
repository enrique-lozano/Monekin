import asyncio
import json
from typing import Any, Dict

from googletrans import Translator

FILE_PATH = "./_missing_translations.json"
translator = Translator()


def load_json(file_path: str) -> Dict[str, Any]:
    with open(file_path, "r", encoding="utf-8") as file:
        return json.load(file)


def save_json(file_path: str, data: Dict[str, Any]) -> None:
    with open(file_path, "w", encoding="utf-8") as file:
        json.dump(data, file, ensure_ascii=False, indent=2)


async def translate_text(text: str, dest_language: str) -> str:
    translation = await translator.translate(text, dest=dest_language)
    return translation.text


async def translate_lang_json(data: Dict[str, Any], lang: str) -> None:
    if len(data) == 0:
        return

    print(f"- Translating '{lang}'")

    for category, items in data.items():
        if isinstance(items, dict):
            for key, value in items.items():
                if isinstance(value, dict):
                    for sub_key, sub_value in value.items():
                        data[category][key][sub_key] = await translate_text(
                            sub_value, lang
                        )
                else:
                    data[category][key] = await translate_text(value, lang)


async def translate_data(data: Dict[str, Any]) -> None:
    for lang, translations in data.items():
        if lang == "@@info":
            continue

        await translate_lang_json(translations, lang)

    save_json(FILE_PATH, data)
    print("\n✅ Translation completed and file updated.\n")


data = load_json(FILE_PATH)
asyncio.run(translate_data(data))
