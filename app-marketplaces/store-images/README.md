# Google Play presentation

This is one of the parts where we most appreciate your help. The presentation in the Google Play is important to achieve a greater number of downloads.

The store images are made in two steps:

1. **Captures**: `scripts\generate_screenshots.bat` runs the app with demo data and saves raw captures to `app-marketplaces/screenshots/captures/<app language>-<currency>/` (see `integration_test/README.md`).
2. **Store images**: the editor in this folder lays those captures out and exports the final 1080x1920 images to `app-marketplaces/screenshots/store/<set>/01.png`, `02.png`... ready to upload one by one.

## Sets

Each store listing gets a **set** of images, defined in `config.json` with:

| Field | Meaning | Example (`pt-BR`) |
| --- | --- | --- |
| `id` | Store listing, and folder of its exported images | `pt-BR` |
| `texts` | Language of the captions (`texts/<texts>.json`) | `pt` |
| `app` | Language of the app in the captures | `en` |
| `currency` | Currency of the demo data in the captures | `BRL` |

Sets with the same `app` and `currency` share captures. Listings without their own set reuse another one when uploading (e.g. `en-US` for `en-AU`, `de-DE` for `de-AT`).

> [!NOTE]
> Only the `en-US` store images (`screenshots/store/en-US/`) are committed, because the project README shows them. Everything else under `screenshots/` (captures and the store images of other sets) is ignored by git: generate it locally with the two steps above. Commit the `en-US` images only when publishing new ones to the stores, as every export changes them slightly (demo data dates) and each commit adds them to the history again. Discard them otherwise with `git restore app-marketplaces/screenshots/store/en-US/`.

## Using the editor

From the repository root:

```
dart app-marketplaces/store-images/editor/server.dart
```

Open the printed URL. You'll see every image of the selected set. Use **Export** on an image, or export a whole set at once, then **Open folder** to see the results in your file explorer. Reload the page after editing any file.

```
app-marketplaces/
├── store-images/            Source of the store images (edit here)
│   ├── config.json          Sets and slides, in store order
│   ├── slides/*.html        One file per image (layout)
│   ├── texts/<lang>.json    Texts of every image, one file per caption language
│   └── editor/              Editor, local server and shared styles (rarely needs changes)
└── screenshots/             Generated files (don't edit by hand)
    ├── captures/<app>-<currency>/  Raw captures from the integration test (not committed)
    └── store/<set>/                Final images exported by the editor (only en-US is committed)
```

### Editing a slide

Slides are plain HTML plus a few custom tags. Position elements with inline `style`, in pixels of the 1080x1920 canvas. Use `class="center"` to center an element horizontally, and `right` instead of `left` for elements near the right edge, so changing a `width` doesn't require recalculating positions:

```html
<store-slide background="light">                       <!-- light or navy -->
  <header>                                             <!-- class="bottom" to put it below the content -->
    <h1><store-text key="title"></store-text></h1>     <!-- texts/<lang>.json → "<slide>" → "title" -->
  </header>

  <!-- Device showing screenshots/captures/<app>-<currency>/01_dashboard.png -->
  <store-phone shot="01_dashboard" class="center" style="top: 660px; width: 700px"></store-phone>

  <!-- Magnified part of a capture. crop = "left top width height", in % of the capture -->
  <store-zoom shot="01_dashboard" crop="0 11 77 12" style="right: 50px; top: 980px; width: 600px; rotate: -4deg"></store-zoom>
</store-slide>
```

- Shared measures (texts position, margins, colors) are CSS variables at the top of `editor/slides.css`; components such as `.phone-grid` document their own variables, which you can override inline (`style="--phone-width: 360px"`).
- Phones take the capture's own aspect ratio, so the screen is never cropped. Keep every phone fully inside the canvas unless it's meant to bleed off an edge.
- `shot` is a capture name from `ScreenshotName` in `integration_test/tests/screenshots/screenshots_config.dart`, plus the style suffix for the extra styles (e.g. `01_dashboard_dark_purple`). A missing capture shows a striped warning instead.
- Colors live as variables at the top of `editor/slides.css`: navy text and coin yellow from the app icon, on light blue or navy backgrounds. Alternate `light` and `navy` so consecutive images don't look the same, and use `<div class="coin">` or `class="sticker yellow"` for touches of yellow.
- In texts, wrap a word in `<em>` to highlight it (yellow marker on light backgrounds, yellow text on navy). A missing text shows as a yellow `slide.key` mark.
- A set without captures uses the `en-USD` ones, marked with an **en-USD** badge in the editor, so its images can always be exported. To add a caption language, copy `texts/en.json` and translate it; to add a set, add it to `config.json`.
- To add or reorder images, edit `slides` in `config.json`. The order sets the exported file names.

The `Mockup.pptx` and `Mockups/` folders are the old, manually made images, kept until the new ones are published.
