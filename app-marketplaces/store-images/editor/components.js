// Turns the custom tags used in slides/*.html into plain HTML:
//
//   <store-slide background="light">      Slide canvas. Backgrounds live in slides.css.
//   <store-text key="title">              Text of texts/<lang>.json → "<slide id>" → key.
//   <store-phone shot="01_dashboard">     Device showing <lang>/Screenshots/01_dashboard.png
//                                         (or the English one, if that language has none).
//   <store-zoom shot="..." crop="...">    Magnified part of a capture. `crop` is
//                                         "left top width height", as % of the capture.
//   <store-icon name="lock">              One of the ICONS below.
//
// Position and size elements with inline `style` (left/right, top, width, rotate...).
// Add `class="center"` to center an element horizontally instead of setting `left`.

const ICONS = {
  lock: '<rect x="5" y="10" width="14" height="10" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/>',
  offline:
    '<path d="M7.5 18h9.75a3.75 3.75 0 0 0 1.1-7.34A6 6 0 0 0 7.2 8.3 4.5 4.5 0 0 0 7.5 18z"/><path d="m3 3 18 18"/>',
  noAds: '<circle cx="12" cy="12" r="9"/><path d="m5.6 5.6 12.8 12.8"/>',
  code: '<path d="m8 8-4 4 4 4m8-8 4 4-4 4m-6 3 4-14"/>',
  currency: '<circle cx="9" cy="9" r="6"/><path d="M15.5 9.5a6 6 0 1 1-6 6"/>',
  chart: '<path d="M4 4v16h16"/><path d="m8 14 3-4 3 3 5-6"/>',
  backup: '<path d="M4 7h16v13H4zM8 7V4h8v3M9 12h6"/>',
  search: '<circle cx="11" cy="11" r="7"/><path d="m20 20-4-4"/>',
  filter: '<path d="M4 5h16l-6 8v6l-4-2v-4z"/>',
  tag: '<path d="M3 12V4h8l10 10-8 8z"/><circle cx="7.5" cy="8.5" r="1.5"/>',
};

/**
 * Builds the slide `html` for `lang`. Resolves once every capture has loaded,
 * with `usesFallback` telling if any of them is the English one.
 */
export async function renderSlide(html, { slideId, lang, texts }) {
  // Not a <template>: images inside its inert content never load.
  const wrapper = document.createElement('div');
  wrapper.innerHTML = html.trim();
  const root = wrapper.firstElementChild;

  for (const el of root.querySelectorAll('store-text')) {
    const value = el.getAttribute('key').split('.').reduce((obj, k) => obj?.[k], texts[slideId]);
    el.outerHTML = value ?? `<mark>${slideId}.${el.getAttribute('key')}</mark>`;
  }

  for (const el of root.querySelectorAll('store-icon')) {
    el.outerHTML = `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
      stroke-linecap="round" stroke-linejoin="round">${ICONS[el.getAttribute('name')]}</svg>`;
  }

  const loads = [];

  for (const el of root.querySelectorAll('store-phone')) {
    const phone = replaceWith(el, 'div', 'phone');
    phone.innerHTML = '<div class="screen"></div>';
    loads.push(loadCapture(phone.querySelector('.screen'), lang, el.getAttribute('shot')));
  }

  for (const el of root.querySelectorAll('store-zoom')) {
    const zoom = replaceWith(el, 'div', 'zoom');
    loads.push(
      loadCapture(zoom, lang, el.getAttribute('shot')).then((capture) => {
        if (capture) cropZoom(zoom, capture.img, el);
        return capture;
      }),
    );
  }

  const slide = replaceWith(root, 'div', `slide ${root.getAttribute('background') ?? ''}`);
  const captures = await Promise.all(loads);
  return { slide, usesFallback: captures.some((c) => c?.isFallback) };
}

/** Swaps a custom tag for a `tag` element that keeps its classes and inline style. */
function replaceWith(el, tag, className) {
  const node = document.createElement(tag);
  node.className = `${className} ${el.getAttribute('class') ?? ''}`.trim();
  node.setAttribute('style', el.getAttribute('style') ?? '');
  node.append(...el.childNodes);
  el.replaceWith(node);
  return node;
}

/**
 * Puts the capture of `lang` inside `container`, falling back to the English
 * one, or a warning if neither has been generated.
 */
async function loadCapture(container, lang, shot) {
  const img = new Image();
  container.append(img);

  for (const candidate of new Set([lang, 'en'])) {
    if (await loadImage(img, `../../screenshots/${candidate}/Screenshots/${shot}.png`)) {
      return { img, isFallback: candidate !== lang };
    }
  }

  container.innerHTML = `<div class="missing">Missing capture<br>${lang}/Screenshots/${shot}.png</div>`;
  return null;
}

function loadImage(img, src) {
  return new Promise((resolve) => {
    img.onload = () => resolve(true);
    img.onerror = () => resolve(false);
    img.src = src;
  });
}

/** Sizes the capture in % of the zoom box, so the box `width` can be any CSS value. */
function cropZoom(zoom, img, el) {
  const [left, top, width, height] = el.getAttribute('crop').split(' ').map((v) => parseFloat(v) / 100);

  zoom.style.aspectRatio = `${width * img.naturalWidth} / ${height * img.naturalHeight}`;
  img.style.width = `${100 / width}%`;
  img.style.left = `${(-left / width) * 100}%`;
  img.style.top = `${(-top / height) * 100}%`;
}
