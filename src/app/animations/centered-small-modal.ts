import { createAnimation } from '@ionic/angular';

export function enterAnimation(baseEl) {
  const wrapperAnimation = createAnimation()
    .beforeStyles({
      transform: 'translateY(0) scale(1)',
      opacity: '1',
    })
    .addElement(baseEl.shadowRoot.querySelector('.modal-wrapper'));

  return createAnimation()
    .addElement(baseEl)
    .duration(250)
    .fromTo('opacity', '0', '1')
    .addAnimation([wrapperAnimation]);
}

export function leaveAnimation(baseEl) {
  const wrapperAnimation = createAnimation().addElement(
    baseEl.shadowRoot.querySelector('.modal-wrapper')
  );

  return createAnimation()
    .addElement(baseEl)
    .duration(250)
    .fromTo('opacity', '1', '0')
    .addAnimation([wrapperAnimation]);
}
