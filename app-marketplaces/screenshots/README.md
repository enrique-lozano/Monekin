# Google Play presentation

This is one of the parts where we most appreciate your help. The presentation in the Google Play is important to achieve a greater number of downloads.

The store images are generated in two steps:

1. **Captures**: `scripts\generate_screenshots.bat` runs the app with demo data and saves raw captures to `<lang>/Screenshots/` (see `integration_test/README.md`).
2. **Store images**: `scripts\render_store_images.bat` lays those captures out with the HTML templates in `store-images/` and saves the final 1080x1920 images to `<lang>/StoreImages/`.

```
- store-images
    - slides.html / slides.css / slides.js   (templates, one function per image in slides.js)
    - copy
         - en.js                             (texts of each image, one file per language)
    - fonts
- lang1
    - Screenshots                            (raw captures, step 1)
    - StoreImages                            (final images, step 2)
```

## Editing the store images

- Open `store-images/slides.html` in a browser to preview every image of every language at once. Reload after any change.
- Texts live in `store-images/copy/<lang>.js`. Wrap a word in `<em>` to highlight it. To add a language, copy `en.js`, translate it and add its `<script>` tag to `slides.html`.
- Layout lives in `store-images/slides.js`. Each image is built from a few helpers: `phone()` (a device with a capture), `zoom()` (a magnified crop of a capture) and stickers.
- The renderer uses Microsoft Edge by default. Set `BROWSER` to the path of another Chromium browser to change it.

The `Mockup.pptx` and `Mockups/` folders are the old, manually made images, kept until the new ones are published.
