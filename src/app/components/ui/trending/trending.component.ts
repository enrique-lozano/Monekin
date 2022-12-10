import { Component, Input, OnInit } from '@angular/core';
import { LangService } from 'src/app/services/translate/translate.service';

@Component({
  selector: 'app-trending',
  templateUrl: './trending.component.html',
  styleUrls: ['./trending.component.scss'],
})
export class TrendingComponent implements OnInit {
  @Input() value: number;
  @Input() form: 'outline-box' | 'default' = 'default';
  @Input() textAfter: string;

  constructor(public lang: LangService) {}

  ngOnInit() {}
}
