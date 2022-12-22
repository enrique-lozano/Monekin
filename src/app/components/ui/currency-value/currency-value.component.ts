import {
  formatCurrency,
  formatNumber,
  getCurrencySymbol,
} from '@angular/common';
import {
  AfterViewInit,
  Component,
  ElementRef,
  Inject,
  Input,
  LOCALE_ID,
  OnChanges,
  OnInit,
  SimpleChanges,
  ViewChild,
} from '@angular/core';
import { ISOCorrencyCodes } from 'src/app/constants/currencies/currency-code.enum';
import { Currency } from 'src/app/services/currency/currency.model';
import { CurrencyService } from 'src/app/services/currency/currency.service';

@Component({
  selector: 'currency-value',
  templateUrl: './currency-value.component.html',
  styleUrls: [],
})
export class CurrencyValueComponent
  implements OnInit, OnChanges, AfterViewInit
{
  @Input() value: number;
  @Input() showDecimals = true;

  /** Currency to format the number. If not defined, will get the preferred currency of the user */
  @Input() currencyCode: ISOCorrencyCodes;

  @ViewChild('valueContainer') valueContainer: ElementRef<HTMLSpanElement>;

  decimalSeparator: string;

  userCurrency: Currency;

  constructor(
    @Inject(LOCALE_ID) private userLocale: string,
    private currency: CurrencyService
  ) {}

  ngOnInit() {}

  ngAfterViewInit() {
    this.decimalSeparator = formatNumber(1.1, this.userLocale, '1.1-1').charAt(
      1
    );

    this.currency.onChangeCurrency.subscribe((currency) => {
      this.userCurrency = currency;
      this.getTextToShow();
    });
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (
      changes['value']?.firstChange === false ||
      changes['currencyCode']?.firstChange === false
    ) {
      this.getTextToShow();
    }
  }

  getTextToShow() {
    if (this.value === undefined || this.value === null || !this.userCurrency)
      return;

    const formatedNumber = formatCurrency(
      this.value,
      this.userLocale,
      getCurrencySymbol(
        this.currencyCode ?? this.userCurrency.code,
        'narrow',
        this.userLocale
      ),
      undefined,
      this.showDecimals ? '1.2-2' : '1.0-0'
    );

    const span = this.valueContainer.nativeElement;

    if (this.showDecimals) {
      // Parts with be an array with the form: [decimalPart, IntegerPart]
      const parts = formatedNumber.match(
        new RegExp('(\\' + this.decimalSeparator + ')(' + '\\d+)', 'g')
      );

      if (!parts) {
        // A non-finite number
        span.innerHTML = formatedNumber;
        return;
      }

      span.innerHTML = formatedNumber.replace(
        parts[0],
        `<span class="thin" style="font-size: max(0.75em,14px)">${parts[0]}</span>`
      );
    } else {
      span.innerHTML = formatedNumber;
    }
  }
}
