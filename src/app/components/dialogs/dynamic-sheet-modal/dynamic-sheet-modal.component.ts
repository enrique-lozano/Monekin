import { Component, EventEmitter, Input, Output } from '@angular/core';

@Component({
  selector: 'app-dynamic-sheet-modal',
  templateUrl: './dynamic-sheet-modal.component.html',
  styleUrls: ['./dynamic-sheet-modal.component.scss'],
})
export class DynamicSheetModalComponent {
  /** The title in the header of the modal. Should be an i18n key to translate */
  @Input() title: string;

  /** Display or not the footer buttons. If this option if disable the component will never emit any event.
   *
   * @default true */
  @Input() displayFooterButtons = true;

  /** Disable the confirm button (if exists).
   *
   * @default false */
  @Input() confirmButtonDisabled = false;

  @Output() dismissed = new EventEmitter<void>();
  @Output() confirmed = new EventEmitter<void>();

  constructor() {}

  submit() {
    this.confirmed.emit();
  }

  dismiss() {
    this.dismissed.emit();
  }
}
