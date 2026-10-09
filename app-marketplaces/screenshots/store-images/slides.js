// Store slides. Open slides.html for a gallery of every locale, or
// slides.html?lang=es&slide=3 to render one slide at full size (used by
// scripts/render_store_images.bat). Captures are read from
// ../<lang>/Screenshots/, as written by scripts/generate_screenshots.bat.

let SHOTS;
const SHOT_W = 676; // Source capture size, used to place zooms.

const ICONS = {
  offline: '<path d="M12 3v12m0 0-4-4m4 4 4-4M5 21h14"/>',
  noads: '<circle cx="12" cy="12" r="9"/><path d="m5.6 5.6 12.8 12.8"/>',
  code: '<path d="m8 8-4 4 4 4m8-8 4 4-4 4m-6 3 4-14"/>',
  currency: '<circle cx="9" cy="9" r="6"/><path d="M15.5 9.5a6 6 0 1 1-6 6"/>',
  backup: '<path d="M4 7h16v13H4zM8 7V4h8v3M9 12h6"/>',
  lock: '<rect x="5" y="10" width="14" height="10" rx="2"/><path d="M8 10V7a4 4 0 0 1 8 0v3"/>',
};
const icon = (k) =>
  `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">${ICONS[k]}</svg>`;

const phone = (shot, { x, y, w, rot = 0, z = 1 }) => `
  <div class="phone" style="left:${x}px;top:${y}px;width:${w}px;transform:rotate(${rot}deg);z-index:${z}">
    <div class="cam"></div>
    <div class="screen"><img src="${SHOTS}/${shot}.png"></div>
  </div>`;

// Magnified crop of a capture. sx/sy/sw/sh are in capture pixels.
const zoom = (shot, { sx, sy, sw, sh, x, y, w, rot = 0 }) => {
  const k = w / sw;
  return `<div class="zoom" style="left:${x}px;top:${y}px;width:${w}px;height:${sh * k}px;
    transform:rotate(${rot}deg);background-image:url(${SHOTS}/${shot}.png);
    background-size:${SHOT_W * k}px auto;background-position:-${sx * k}px -${sy * k}px"></div>`;
};

const SLIDES = [
  // 1 · Hero: big phone bleeding off the bottom + zoom on the balance.
  (c) => `
    <div class="slide bg-sky">
      <div class="copy" style="top:120px">
        <div class="title">${c.hero.title}</div>
        <div class="sub">${c.hero.sub}</div>
      </div>
      ${phone('01_dashboard', { x: 190, y: 660, w: 700 })}
      ${zoom('01_dashboard', { sx: 0, sy: 160, sw: 520, sh: 170, x: 50, y: 980, w: 600, rot: -4 })}
      <div class="sticker dark" style="right:70px;top:1450px;transform:rotate(5deg)">${icon('lock')}${c.hero.sticker}</div>
    </div>`,

  // 2 · Transactions: whole device, copy below.
  (c) => `
    <div class="slide bg-cream">
      ${phone('02_transactions', { x: 215, y: 90, w: 650 })}
      ${c.transactions.chips.map((t, i) => `<div class="sticker" style="${
        ['left:60px;top:430px;transform:rotate(-6deg)', 'right:50px;top:720px;transform:rotate(5deg)', 'left:90px;top:1060px;transform:rotate(-3deg)'][i]
      }">${t}</div>`).join('')}
      <div class="copy" style="top:1540px">
        <div class="title" style="font-size:96px">${c.transactions.title}</div>
        <div class="sub" style="margin-top:20px">${c.transactions.sub}</div>
      </div>
    </div>`,

  // 3 · Stats: whole device, copy above, zoom on the chart.
  (c) => `
    <div class="slide bg-mist">
      <div class="copy" style="top:110px">
        <div class="title">${c.stats.title}</div>
        <div class="sub">${c.stats.sub}</div>
      </div>
      ${phone('03_stats', { x: 250, y: 600, w: 580 })}
      ${zoom('03_stats', { sx: 20, sy: 1020, sw: 640, sh: 280, x: 440, y: 1330, w: 590, rot: 3 })}
    </div>`,

  // 4 · Themes: fan of the dashboard in every style.
  (c) => `
    <div class="slide bg-sky">
      <div class="copy" style="top:110px">
        <div class="kicker">${c.themes.kicker}</div>
        <div class="title">${c.themes.title}</div>
        <div class="sub">${c.themes.sub}</div>
      </div>
      ${phone('01_dashboard_light_green', { x: -150, y: 860, w: 470, rot: -14, z: 1 })}
      ${phone('01_dashboard_dark_amoled_orange', { x: 760, y: 860, w: 470, rot: 14, z: 1 })}
      ${phone('01_dashboard_dark_purple', { x: 470, y: 760, w: 500, rot: 6, z: 2 })}
      ${phone('01_dashboard', { x: 130, y: 720, w: 520, rot: -4, z: 3 })}
      <div class="swatches" style="top:650px">
        ${['#0f3375', '#388e3c', '#8e24aa', '#fb8c00', '#000'].map((b) => `<span style="background:${b}"></span>`).join('')}
      </div>
    </div>`,

  // 5 · Quick add: three tilted forms on navy.
  (c) => `
    <div class="slide bg-navy">
      <div class="copy left" style="top:120px">
        <div class="title">${c.quickAdd.title}</div>
        <div class="sub">${c.quickAdd.sub}</div>
      </div>
      ${phone('09_form_expense', { x: -120, y: 820, w: 520, rot: -16, z: 1 })}
      ${phone('08_form_income', { x: 640, y: 760, w: 520, rot: 14, z: 1 })}
      ${phone('10_form_transfer', { x: 260, y: 900, w: 560, rot: 0, z: 2 })}
    </div>`,

  // 6 · Planning: two diagonal phones, copy top-right.
  (c) => `
    <div class="slide bg-cream">
      <div class="copy" style="top:120px">
        <div class="title" style="font-size:100px">${c.planning.title}</div>
        <div class="sub">${c.planning.sub}</div>
      </div>
      ${phone('05_budget_details', { x: 60, y: 620, w: 540, rot: -8, z: 1 })}
      ${phone('06_subscriptions', { x: 500, y: 820, w: 540, rot: 7, z: 2 })}
      ${zoom('05_budget_details', { sx: 20, sy: 230, sw: 640, sh: 270, x: 40, y: 1500, w: 560, rot: -3 })}
    </div>`,

  // 7 · Privacy + secondary features list.
  (c) => `
    <div class="slide bg-mist">
      <div class="copy left" style="top:110px">
        <div class="title">${c.privacy.title}</div>
      </div>
      <div class="features" style="top:560px">
        ${c.privacy.features.map(([k, t, d]) => `
          <div class="feature"><div class="ico">${icon(k)}</div><b>${t}</b><span>${d}</span></div>`).join('')}
      </div>
      ${phone('07_exchange_rate', { x: 590, y: 560, w: 520, rot: 6 })}
    </div>`,
];

const params = new URLSearchParams(location.search);
const root = document.getElementById('root');

const render = (lang, slide) => {
  SHOTS = `../${lang}/Screenshots`;
  return slide(COPY[lang]);
};

if (params.has('slide')) {
  document.body.className = 'render';
  root.innerHTML = render(params.get('lang') ?? 'en', SLIDES[+params.get('slide') - 1]);
} else {
  document.body.className = 'gallery';
  root.innerHTML = Object.keys(COPY).map((lang) => `
    <div class="lang-bar">${lang}</div>
    ${SLIDES.map((s) => `<div class="slide-wrap">${render(lang, s)}</div>`).join('')}`).join('');
}
