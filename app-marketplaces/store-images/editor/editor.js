import { renderSlide } from './components.js';

const config = await fetchJson('../config.json');
const slideHtml = Object.fromEntries(
  await Promise.all(config.slides.map(async (id) => [id, await (await fetch(`../slides/${id}.html`)).text()])),
);

const langSelect = document.getElementById('lang');
const status = document.getElementById('status');
const main = document.getElementById('slides');

// Only languages whose captures exist, as the rest would export empty phones.
const languages = (
  await Promise.all(config.languages.map(async (l) => ((await hasCaptures(l)) ? l : null)))
).filter(Boolean);

if (languages.length === 0) {
  document.querySelector('nav').hidden = true;
  main.innerHTML = `
    <div class="empty">
      <h2>No captures generated yet</h2>
      <p>Run this from the repository root, with an emulator or device running:</p>
      <code>scripts\\generate_screenshots.bat</code>
      <p>Then reload this page.</p>
    </div>`;
  throw new Error('No captures found in app-marketplaces/screenshots/<lang>/Screenshots/');
}

langSelect.innerHTML = languages.map((l) => `<option>${l}</option>`).join('');
const requested = new URLSearchParams(location.search).get('lang');
langSelect.value = languages.includes(requested) ? requested : languages[0];
langSelect.onchange = () => {
  history.replaceState(null, '', `?lang=${langSelect.value}`);
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
    figure.innerHTML = `<figcaption>${fileName(i)} · ${id}<button>Export</button></figcaption><div class="preview"></div>`;
    figure.querySelector('button').onclick = () => run(() => exportSlide(lang, i, texts));
    main.append(figure);

    figure.querySelector('.preview').append(await renderSlide(slideHtml[id], { slideId: id, lang, texts }));
  }
}

async function exportLanguages(langs) {
  await run(async () => {
    for (const lang of langs) {
      const texts = await fetchJson(`../texts/${lang}.json`);
      for (const i of config.slides.keys()) await exportSlide(lang, i, texts);
    }
  });
}

/** Renders the slide at full size off-screen and saves it through server.dart. */
async function exportSlide(lang, index, texts) {
  const id = config.slides[index];
  status.textContent = `Exporting ${lang}/${fileName(index)}…`;

  const slide = await renderSlide(slideHtml[id], { slideId: id, lang, texts });
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

/** Disables the buttons while `task` runs and reports how it went. */
async function run(task) {
  const buttons = document.querySelectorAll('button');
  buttons.forEach((b) => (b.disabled = true));
  try {
    await task();
    status.textContent = 'Saved to app-marketplaces/screenshots/<lang>/StoreImages/';
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
