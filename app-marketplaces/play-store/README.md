# Google Play listings

`play_store.dart` syncs the Google Play store listings with this repository:

- **Texts**: `listings/<language>/title.txt`, `short_description.txt` and `full_description.txt`. Max 30, 80 and 4000 characters. Committed, so every change is reviewed in its PR.
- **Phone screenshots**: the images exported by the store images editor to `app-marketplaces/screenshots/store/<set>/` (see `../screenshots/generator/README.md`). Each listing uses the set with its same id or, failing that, the first set of its language (e.g. `de-DE` for `de-AT`). Listings without any keep their current images.

Uploads are committed with **"changes not sent for review"**, so nothing gets published until you check them and send them for review from the Play Console.

## Setup (once)

1. In the [Play Console](https://play.google.com/console) go to **Users and permissions**, invite the service account email (`...@...iam.gserviceaccount.com`) and give it access to Monekin with the **Manage store presence** permission. It can take a few minutes to work.
2. Save its JSON key as `app-marketplaces/play-store/service-account.json` (ignored by git), or set the `PLAY_STORE_KEY` env var to its path. **Never commit it.**
3. Install the dependencies: `cd app-marketplaces/play-store && dart pub get`.

## Usage

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

Only the listings or screenshots that differ from the Play Store are uploaded. A new folder in `listings/` creates that listing. Listings in the Play Store without a folder keep their texts.

Then, in the Play Console, open **Publishing overview**, review the changes under **Changes not yet sent for review** and send them.

> [!NOTE]
> Before pushing screenshots, generate and export the images of every set (`scripts\generate_screenshots.bat` and the editor), as only `en-US` is committed.
