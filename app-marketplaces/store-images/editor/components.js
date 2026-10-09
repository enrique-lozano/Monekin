// Turns the custom tags used in slides/*.html into plain HTML:
//
//   <store-slide background="sky">        Slide canvas. Backgrounds live in slides.css.
//   <store-text key="title">              Text of texts/<lang>.json → "<slide id>" → key.
//   <store-phone shot="01_dashboard">     Device showing <lang>/Screenshots/01_dashboard.png.
//   <store-zoom shot="..." crop="...">    Magnified part of a capture. `crop` is
//                                         "left top width height", as % of the capture.
//   <store-icon name="lock">              One of the ICONS below.
//
// Position and size elements with inline `style` (left/right, top, width, rotate...).
// Add `class="center"` to center an element horizontally instead of setting `left`.

const ICONS = {
  lock: '<rect x="5" y="10" width="14" height="10" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/>',
  offline: '<path d="M12 3v12m0 0-4-4m4 4 4-4M5 21h14"/>',
  noAds: '<circle cx="12" cy="12" r="9"/><path d="m5.6 5.6 12.8 12.8"/>',
  code: '<path d="m8 8-4 4 4 4m8-8 4 4-4 4m-6 3 4-14"/>',
  currency: '<circle cx="9" cy="9" r="6"/><path d="M15.5 9.5a6 6 0 1 1-6 6"/>',
  backup: '<path d="M4 7h16v13H4zM8 7V4h8v3M9 12h6"/>',
  search: '<circle cx="11" cy="11" r="7"/><path d="m20 20-4-4"/>',
  filter: '<path d="M4 5h16l-6 8v6l-4-2v-4z"/>',
  tag: '<path d="M3 12V4h8l10 10-8 8z"/><circle cx="7.5" cy="8.5" r="1.5"/>',
};

/** Builds the slide `html` for `lang`. Resolves once every capture has loaded. */
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
    loads.push(loadCapture(zoom, lang, el.getAttribute('shot')).then((img) => img && cropZoom(zoom, img, el)));
  }

  const slide = replaceWith(root, 'div', `slide ${root.getAttribute('background') ?? ''}`);
  await Promise.all(loads);
  return slide;
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

/** Puts the capture inside `container`, or a warning if it hasn't been generated. */
function loadCapture(container, lang, shot) {
  const img = new Image();
  container.append(img);

  return new Promise((resolve) => {
    img.onload = () => resolve(img);
    img.onerror = () => {
      container.innerHTML = `<div class="missing">Missing capture<br>${lang}/Screenshots/${shot}.png</div>`;
      resolve(null);
    };
    img.src = `../../screenshots/${lang}/Screenshots/${shot}.png`;
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
