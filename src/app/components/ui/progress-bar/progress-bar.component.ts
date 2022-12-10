import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-progress-bar',
  templateUrl: './progress-bar.component.html',
  styleUrls: ['./progress-bar.component.scss'],
})
export class ProgressBarComponent implements OnInit {
  /** Color in hex format, without the "#" */ @Input() color: string;

  /** The level of completion of the bar. A value between 0 and 100 */
  @Input() infillPercentage: number;

  /** Set if the bar will be vertical or horizontal
   *
   * @default "Horizontal"
   */ @Input() mode: 'Vertical' | 'Horizontal' = 'Horizontal';

  constructor() {}

  ngOnInit() {}
}
