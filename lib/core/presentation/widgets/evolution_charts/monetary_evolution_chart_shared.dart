import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:monekin/core/database/app_db.dart';
import 'package:monekin/core/extensions/date.extensions.dart';
import 'package:monekin/core/presentation/widgets/number_ui_formatters/ui_number_formatter.dart';
import 'package:monekin/i18n/generated/translations.g.dart';

/// Day step for time-series charts (~100 samples across [timeRange]).
int timeSeriesChartDayStep(DateTimeRange timeRange) {
  return ((timeRange.end.difference(timeRange.start).inDays) / 100)
      .ceil()
      .clamp(1, 1 << 30);
}

/// A chart sample at [date] carrying forward [source]'s value.
class TimeSeriesFilledSample<T> {
  const TimeSeriesFilledSample({
    required this.date,
    required this.value,
    required this.source,
  });

  final DateTime date;
  final double value;
  final T source;
}

/// Fills [timeRange] with samples at [timeSeriesChartDayStep] intervals,
/// using the latest known value at or before each date.
List<TimeSeriesFilledSample<T>> fillTimeSeriesWithPreviousValue<T>({
  required List<T> data,
  required DateTime Function(T) dateExtractor,
  required double Function(T) valueExtractor,
  required DateTimeRange timeRange,
}) {
  if (data.isEmpty) return const [];

  final sorted = List<T>.from(data)
    ..sort((a, b) => dateExtractor(a).compareTo(dateExtractor(b)));

  final dayStep = timeSeriesChartDayStep(timeRange);
  final samples = <TimeSeriesFilledSample<T>>[];

  var dataIndex = 0;
  var currentDay = timeRange.start.justDay();
  T? lastSource;
  double? lastValue;

  while (dataIndex < sorted.length &&
      !dateExtractor(sorted[dataIndex]).justDay().isAfter(timeRange.start)) {
    final item = sorted[dataIndex];
    lastSource = item;
    lastValue = valueExtractor(item);
    dataIndex++;
  }

  while (currentDay.compareTo(timeRange.end) < 0) {
    while (dataIndex < sorted.length &&
        !dateExtractor(sorted[dataIndex]).justDay().isAfter(currentDay)) {
      final item = sorted[dataIndex];
      lastSource = item;
      lastValue = valueExtractor(item);
      dataIndex++;
    }

    if (lastSource != null && lastValue != null) {
      samples.add(
        TimeSeriesFilledSample(
          date: currentDay,
          value: lastValue,
          source: lastSource,
        ),
      );
    }

    currentDay = currentDay.add(Duration(days: dayStep));
  }

  return samples;
}

/// A time-series sample with a preformatted date [label] for tooltips.
class TimeSeriesLabeledPoint {
  const TimeSeriesLabeledPoint({
    required this.date,
    required this.value,
    required this.label,
  });

  final DateTime date;
  final double value;
  final String label;
}

bool evolutionChartTouchEnded(FlTouchEvent event) =>
    event is FlPanEndEvent || event is FlLongPressEnd || event is FlTapUpEvent;

/// Tracks the last hovered X (epoch ms) and fires haptic feedback when it changes.
final class EvolutionDateHoverHaptics {
  int? _lastHoveredXMs;

  void reset() {
    _lastHoveredXMs = null;
  }

  void onHoveredXMs(int xMs) {
    if (_lastHoveredXMs != xMs) {
      HapticFeedback.selectionClick();
      _lastHoveredXMs = xMs;
    }
  }
}

List<LineTooltipItem> buildMultiLineCurrencyLineTooltipItems(
  BuildContext context, {
  required List<LineBarSpot> touchedSpots,
  required CurrencyInDB? currency,
  required String Function(int barIndex) lineLabel,
}) {
  if (touchedSpots.isEmpty) {
    return const [];
  }

  final point = touchedSpots.first.x.toInt();

  final date = DateTime.fromMillisecondsSinceEpoch(point);
  const dataTextStyle = TextStyle(fontSize: 12, height: 1.25);

  return [
    ...touchedSpots.mapIndexed((index, spot) {
      return LineTooltipItem(
        index == 0 ? '${DateFormat.MMMd().format(date)}\n' : '',
        const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, height: 2),
        children: [
          TextSpan(
            text: '◉ ',
            style: dataTextStyle.copyWith(color: spot.bar.color),
          ),
          TextSpan(text: '${lineLabel(spot.barIndex)}: ', style: dataTextStyle),
          ...UINumberFormatter.currency(
            currency: currency,
            amountToConvert: spot.y,
            integerStyle: dataTextStyle,
          ).getTextSpanList(context),
        ],
      );
    }),
  ];
}

/// Legend row used under multi-line monetary evolution charts.
class EvolutionChartLegendItem extends StatelessWidget {
  const EvolutionChartLegendItem({
    super.key,
    required this.color,
    required this.label,
  });

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Text(label, style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}

/// Centers [child] and places the “insufficient data” chip on top (same layout
/// for single- and multi-line evolution charts).
class EvolutionChartInsufficientDataOverlay extends StatelessWidget {
  const EvolutionChartInsufficientDataOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            t.general.insufficient_data,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }
}
