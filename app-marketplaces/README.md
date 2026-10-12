# Store presence

Our Google Play listing is the first thing most people see of Monekin, and one of the places where we most appreciate your help. Everything in it lives here, so you can improve it with a regular Pull Request:

| I want to... | Edit | Guide |
| --- | --- | --- |
| Improve or translate the **store texts** (title, descriptions) | `play-store/listings/<language>/*.txt` | [Below](#store-texts) |
| Improve or translate the **captions** of the images | `screenshots/generator/texts/<language>.json` | [generator](screenshots/generator/README.md) |
| Improve the **design** of the images | `screenshots/generator/slides/*.html` | [generator](screenshots/generator/README.md) |
| Add a **new language** to the store | All of the above, plus a set in `screenshots/generator/config.json` | [Below](#store-texts) and [generator](screenshots/generator/README.md) |

You don't need any account or key: the maintainers upload the changes to the store once your PR is merged.

```
app-marketplaces/
├── screenshots/
│   ├── generator/      Source of the store images: sets, slides, captions and editor
│   ├── captures/       Raw app captures (generated, not committed)
│   └── store/<set>/    Final store images (generated, only en-US is committed)
└── play-store/
    ├── listings/       Store texts of every listing
    └── play_store.dart Uploads texts and images to Google Play (maintainers)
```

## Store texts

Each folder in `play-store/listings/` is a store listing with its `title.txt`, `short_description.txt` and `full_description.txt`, of up to 30, 80 and 4000 characters. Descriptions can use `<b>` for bold text. For a new language, copy `en-US/` to a folder named with its Play Store language code (e.g. `pl-PL`).
