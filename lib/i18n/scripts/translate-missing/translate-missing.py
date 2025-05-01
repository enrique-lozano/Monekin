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

    async def translate_recursive(obj: Any) -> Any:
        if isinstance(obj, dict):
            for key, value in obj.items():
                obj[key] = await translate_recursive(value)
            return obj
        elif isinstance(obj, list):
            return [await translate_recursive(item) for item in obj]
        elif isinstance(obj, str):
            return await translate_text(obj, lang)
        else:
            return obj

    await translate_recursive(data)


async def translate_data(data: Dict[str, Any]) -> None:
    for lang, translations in data.items():
        if lang == "@@info":
            continue

        await translate_lang_json(translations, lang)

    save_json(FILE_PATH, data)
    print("\n✅ Translation completed and file updated.\n")


data = load_json(FILE_PATH)
asyncio.run(translate_data(data))
