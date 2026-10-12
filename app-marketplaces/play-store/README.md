# Google Play listings

Each folder in `listings/` is a store listing (`en-US`, `es-ES`...) with its `title.txt`, `short_description.txt` and `full_description.txt`, of up to 30, 80 and 4000 characters. To improve or translate them, edit those files and open a PR. For a new language, copy `en-US/` to a folder named with its Play Store language code (e.g. `pl-PL`).

Descriptions can use `<b>` for bold text. Keep the same meaning and structure in every language.

## For maintainers

`play_store.dart` uploads the texts and the phone screenshots of `../screenshots/store/<set>/` to Google Play. Each listing uses the set with its same id or, failing that, the first set of its language (e.g. `de-DE` for `de-AT`). Only what differs from the Play Store is uploaded, as **changes not sent for review**: check and send them from **Publishing overview** in the Play Console.

### Setup (once)

1. In the [Play Console](https://play.google.com/console) go to **Users and permissions**, invite the service account email (`...@...iam.gserviceaccount.com`) and give it access to Monekin with the **Manage store presence** permission. It can take a few minutes to work.
2. Save its JSON key as `app-marketplaces/play-store/service-account.json` (ignored by git), or set the `PLAY_STORE_KEY` env var to its path. **Never commit it.**
3. Install the dependencies: `cd app-marketplaces/play-store && dart pub get`.

### Usage

From the repository root:

```bash
# Download the current texts of every listing to listings/ (e.g. after editing them
# in the Play Console). Check the changes with `git diff` before committing them
dart run app-marketplaces/play-store/play_store.dart pull

# Show what would change, without uploading anything
dart run app-marketplaces/play-store/play_store.dart push --dry-run

# Upload texts and screenshots of every listing (or only the given ones)
dart run app-marketplaces/play-store/play_store.dart push
dart run app-marketplaces/play-store/play_store.dart push es-ES en-US

# Only texts / only screenshots
dart run app-marketplaces/play-store/play_store.dart push --no-images
dart run app-marketplaces/play-store/play_store.dart push --no-texts
```

Before pushing screenshots, generate and export the images of every set, as only `en-US` is committed.
