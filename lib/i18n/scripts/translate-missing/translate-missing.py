import asyncio
import json
from typing import Any, Dict

from googletrans import Translator

FILE_PATH = "./_missing_translations.json"
translator = Translator()

# Limit concurrency to avoid rate limiting / overload
SEM = asyncio.Semaphore(20)


def load_json(file_path: str) -> Dict[str, Any]:
    with open(file_path, "r", encoding="utf-8") as file:
        return json.load(file)


def save_json(file_path: str, data: Dict[str, Any]) -> None:
    with open(file_path, "w", encoding="utf-8") as file:
        json.dump(data, file, ensure_ascii=False, indent=2)


async def translate_text(text: str, dest_language: str) -> str:
    async with SEM:
        translation = await translator.translate(text, dest=dest_language)
        return translation.text


async def translate_recursive(obj: Any, lang: str) -> Any:
    if isinstance(obj, dict):
        keys = list(obj.keys())
        values = await asyncio.gather(
            *(translate_recursive(obj[k], lang) for k in keys)
        )
        return dict(zip(keys, values))

    elif isinstance(obj, list):
        return await asyncio.gather(*(translate_recursive(item, lang) for item in obj))

    elif isinstance(obj, str):
        return await translate_text(obj, lang)

    else:
        return obj


async def translate_lang_json(data: Dict[str, Any], lang: str) -> None:
    if not data:
        return

    print(f"- Translating '{lang}'")
    translated = await translate_recursive(data, lang)

    # mutate original dict to keep reference
    data.clear()
    data.update(translated)


async def translate_data(data: Dict[str, Any]) -> None:
    tasks = []

    for lang, translations in data.items():
        if lang == "@@info":
            continue

        tasks.append(translate_lang_json(translations, lang))

    await asyncio.gather(*tasks)

    save_json(FILE_PATH, data)
    print("\n✅ Translation completed and file updated.\n")


data = load_json(FILE_PATH)
asyncio.run(translate_data(data))
