import { renderSlide } from './components.js';

const config = await fetchJson('../config.json');
const slideHtml = Object.fromEntries(
  await Promise.all(config.slides.map(async (id) => [id, await (await fetch(`../slides/${id}.html`)).text()])),
);

const langSelect = document.getElementById('lang');
const status = document.getElementById('status');
const main = document.getElementById('slides');
const openFolder = document.getElementById('open-folder');

const languages = config.languages.map((l) => l.code);

// Languages without captures use the English ones, so only stop when even
// those are missing.
if (!(await hasCaptures('en'))) {
  document.querySelector('nav').hidden = true;
  main.innerHTML = `
    <div class="empty">
      <h2>No English captures generated yet</h2>
      <p>Run this from the repository root, with an emulator or device running:</p>
      <code>scripts\\generate_screenshots.bat en</code>
      <p>Other languages use the English captures until theirs are generated. Then reload this page.</p>
    </div>`;
  throw new Error('No captures found in app-marketplaces/screenshots/<lang>/Screenshots/');
}

langSelect.innerHTML = config.languages.map((l) => `<option value="${l.code}">${l.name}</option>`).join('');
const requested = new URLSearchParams(location.search).get('lang');
langSelect.value = languages.includes(requested) ? requested : languages[0];
langSelect.onchange = () => {
  history.replaceState(null, '', `?lang=${langSelect.value}`);
  openFolder.hidden = true;
  showPreviews(langSelect.value);
};

document.getElementById('export-lang').onclick = () => exportLanguages([langSelect.value]);
document.getElementById('export-all').onclick = () => exportLanguages(languages);

await showPreviews(langSelect.value);

async function showPreviews(lang) {
  const texts = await fetchJson(`../texts/${lang}.json`);
  main.replaceChildren();

  for (const [i, id] of config.slides.entries()) {
    const figure = document.createElement('figure');
    figure.innerHTML = `
      <figcaption>
        <span>${fileName(i)} · ${id}</span>
        <span class="fallback" hidden title="No captures in this language yet: showing the English ones">EN</span>
        <button>Export</button>
      </figcaption>
      <div class="preview"></div>`;
    figure.querySelector('button').onclick = () => run(() => exportSlide(lang, i, texts), lang);
    main.append(figure);

    const { slide, usesFallback } = await renderSlide(slideHtml[id], { slideId: id, lang, texts });
    figure.querySelector('.preview').append(slide);
    figure.querySelector('.fallback').hidden = !usesFallback;
  }
}

async function exportLanguages(langs) {
  await run(async () => {
    for (const lang of langs) {
      const texts = await fetchJson(`../texts/${lang}.json`);
      for (const i of config.slides.keys()) await exportSlide(lang, i, texts);
    }
  }, langs.length === 1 ? langs[0] : null);
}

/** Renders the slide at full size off-screen and saves it through server.dart. */
async function exportSlide(lang, index, texts) {
  const id = config.slides[index];
  status.textContent = `Exporting ${lang}/${fileName(index)}…`;

  const { slide } = await renderSlide(slideHtml[id], { slideId: id, lang, texts });
  const stage = Object.assign(document.createElement('div'), { style: 'position: fixed; left: -99999px; top: 0' });
  stage.append(slide);
  document.body.append(stage);

  try {
    await document.fonts.ready;
    const blob = await htmlToImage.toBlob(slide, { width: 1080, height: 1920, pixelRatio: 1 });
    const res = await fetch(`/export/${lang}/${fileName(index)}`, { method: 'POST', body: blob });
    if (!res.ok) throw new Error(`Saving failed (${res.status})`);
  } finally {
    stage.remove();
  }
}

/**
 * Disables the buttons while `task` runs and reports how it went. When the
 * export is of a single language, offers to open its folder afterwards.
 */
async function run(task, lang) {
  const buttons = document.querySelectorAll('button');
  buttons.forEach((b) => (b.disabled = true));
  openFolder.hidden = true;
  try {
    await task();
    status.textContent = lang
      ? `✓ Saved to screenshots/${lang}/StoreImages/`
      : '✓ Saved to screenshots/<lang>/StoreImages/';
    if (lang) {
      openFolder.hidden = false;
      openFolder.onclick = () => fetch(`/open/${lang}`, { method: 'POST' });
    }
  } catch (e) {
    status.textContent = `Error: ${e.message}`;
    throw e;
  } finally {
    buttons.forEach((b) => (b.disabled = false));
  }
}

function fileName(index) {
  return `${String(index + 1).padStart(2, '0')}.png`;
}

/** Whether the screenshots test has run for `lang`. */
async function hasCaptures(lang) {
  const res = await fetch(`../../screenshots/${lang}/Screenshots/01_dashboard.png`, { method: 'HEAD' });
  return res.ok;
}

async function fetchJson(path) {
  return (await fetch(path)).json();
}
