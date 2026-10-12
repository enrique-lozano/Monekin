import { DEFAULT_CAPTURE, renderSlide } from './components.js';

const config = await fetchJson('../config.json');
const slideHtml = Object.fromEntries(
  await Promise.all(config.slides.map(async (id) => [id, await (await fetch(`../slides/${id}.html`)).text()])),
);

const setSelect = document.getElementById('set');
const status = document.getElementById('status');
const main = document.getElementById('slides');
const openFolder = document.getElementById('open-folder');

const sets = Object.fromEntries(config.sets.map((s) => [s.id, s]));

// Sets without captures use the default ones, so only stop when even those
// are missing.
if (!(await hasCaptures(DEFAULT_CAPTURE))) {
  document.querySelector('nav').hidden = true;
  main.innerHTML = `
    <div class="empty">
      <h2>No ${DEFAULT_CAPTURE} captures generated yet</h2>
      <p>Run this from the repository root, with an emulator or device running:</p>
      <code>scripts\\generate_screenshots.bat en-US</code>
      <p>Other sets use these captures until theirs are generated. Then reload this page.</p>
    </div>`;
  throw new Error(`No captures found in app-marketplaces/screenshots/captures/${DEFAULT_CAPTURE}/`);
}

setSelect.innerHTML = config.sets
  .map((s) => `<option value="${s.id}">${s.name} · ${s.currency}</option>`)
  .join('');
const requested = new URLSearchParams(location.search).get('set');
setSelect.value = sets[requested] ? requested : config.sets[0].id;
setSelect.onchange = () => {
  history.replaceState(null, '', `?set=${setSelect.value}`);
  openFolder.hidden = true;
  showPreviews(sets[setSelect.value]);
};

document.getElementById('export-set').onclick = () => exportSets([sets[setSelect.value]]);
document.getElementById('export-all').onclick = () => exportSets(config.sets);

await showPreviews(sets[setSelect.value]);

/** Folder of the captures a set uses, e.g. `en-USD`. */
function captureOf(set) {
  return `${set.app}-${set.currency}`;
}

async function showPreviews(set) {
  const texts = await fetchJson(`../texts/${set.texts}.json`);
  main.replaceChildren();

  for (const [i, id] of config.slides.entries()) {
    const figure = document.createElement('figure');
    figure.innerHTML = `
      <figcaption>
        <span>${fileName(i)} · ${id}</span>
        <span class="fallback" hidden title="No ${captureOf(set)} captures yet: showing the ${DEFAULT_CAPTURE} ones">${DEFAULT_CAPTURE}</span>
        <button>Export</button>
      </figcaption>
      <div class="preview"></div>`;
    figure.querySelector('button').onclick = () => run(() => exportSlide(set, i, texts), set);
    main.append(figure);

    const { slide, usesFallback } = await renderSlide(slideHtml[id], {
      slideId: id,
      capture: captureOf(set),
      texts,
    });
    figure.querySelector('.preview').append(slide);
    figure.querySelector('.fallback').hidden = !usesFallback;
  }
}

async function exportSets(toExport) {
  await run(async () => {
    for (const set of toExport) {
      const texts = await fetchJson(`../texts/${set.texts}.json`);
      for (const i of config.slides.keys()) await exportSlide(set, i, texts);
    }
  }, toExport.length === 1 ? toExport[0] : null);
}

/** Renders the slide at full size off-screen and saves it through server.dart. */
async function exportSlide(set, index, texts) {
  const id = config.slides[index];
  status.textContent = `Exporting ${set.id}/${fileName(index)}…`;

  const { slide } = await renderSlide(slideHtml[id], { slideId: id, capture: captureOf(set), texts });
  const stage = Object.assign(document.createElement('div'), { style: 'position: fixed; left: -99999px; top: 0' });
  stage.append(slide);
  document.body.append(stage);

  try {
    await document.fonts.ready;
    const blob = await htmlToImage.toBlob(slide, { width: 1080, height: 1920, pixelRatio: 1 });
    const res = await fetch(`/export/${set.id}/${fileName(index)}`, { method: 'POST', body: blob });
    if (!res.ok) throw new Error(`Saving failed (${res.status})`);
  } finally {
    stage.remove();
  }
}

/**
 * Disables the buttons while `task` runs and reports how it went. When the
 * export is of a single set, offers to open its folder afterwards.
 */
async function run(task, set) {
  const buttons = document.querySelectorAll('button');
  buttons.forEach((b) => (b.disabled = true));
  openFolder.hidden = true;
  try {
    await task();
    status.textContent = set ? `✓ Saved to screenshots/store/${set.id}/` : '✓ Saved to screenshots/store/<set>/';
    if (set) {
      openFolder.hidden = false;
      openFolder.onclick = () => fetch(`/open/${set.id}`, { method: 'POST' });
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

/** Whether the screenshots test has generated the `capture` folder. */
async function hasCaptures(capture) {
  const res = await fetch(`../../screenshots/captures/${capture}/01_dashboard.png`, { method: 'HEAD' });
  return res.ok;
}

async function fetchJson(path) {
  return (await fetch(path)).json();
}
