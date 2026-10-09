import { renderSlide } from './components.js';

const config = await fetchJson('config.json');
const slideHtml = Object.fromEntries(
  await Promise.all(config.slides.map(async (id) => [id, await (await fetch(`slides/${id}.html`)).text()])),
);

const langSelect = document.getElementById('lang');
const status = document.getElementById('status');
const main = document.getElementById('slides');

langSelect.innerHTML = config.languages.map((l) => `<option>${l}</option>`).join('');
langSelect.value = new URLSearchParams(location.search).get('lang') ?? config.languages[0];
langSelect.onchange = () => {
  history.replaceState(null, '', `?lang=${langSelect.value}`);
  showPreviews(langSelect.value);
};

document.getElementById('export-lang').onclick = () => exportLanguages([langSelect.value]);
document.getElementById('export-all').onclick = () => exportLanguages(config.languages);

await showPreviews(langSelect.value);

async function showPreviews(lang) {
  const texts = await fetchJson(`texts/${lang}.json`);
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
      const texts = await fetchJson(`texts/${lang}.json`);
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

async function fetchJson(path) {
  return (await fetch(path)).json();
}
