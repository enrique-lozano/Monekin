# Store presence

Our Google Play listing is the first thing most people see of Monekin, and one of the places where we most appreciate your help. Everything in it lives here, so you can improve it with a regular Pull Request:

| I want to... | Edit | Guide |
| --- | --- | --- |
| Improve or translate the **store texts** (title, descriptions) | `play-store/listings/<language>/*.txt` | [play-store](play-store/README.md) |
| Improve or translate the **captions** of the images | `screenshots/generator/texts/<language>.json` | [generator](screenshots/generator/README.md) |
| Improve the **design** of the images | `screenshots/generator/slides/*.html` | [generator](screenshots/generator/README.md) |
| Add a **new language** to the store | All of the above, plus a set in `screenshots/generator/config.json` | Both |

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
