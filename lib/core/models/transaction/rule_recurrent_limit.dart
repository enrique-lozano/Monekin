import 'package:equatable/equatable.dart';

enum RuleUntilMode { infinity, date, nTimes }

class RecurrentRuleLimit extends Equatable {
  final DateTime? endDate;
  final int? remainingIterations;

  const RecurrentRuleLimit({this.endDate, this.remainingIterations})
    : assert(!(endDate != null && remainingIterations != null));

  const RecurrentRuleLimit.infinite()
    : endDate = null,
      remainingIterations = null;

  RuleUntilMode get untilMode {
    if (endDate != null) {
      return RuleUntilMode.date;
    } else if (remainingIterations != null) {
      return RuleUntilMode.nTimes;
    }
    return RuleUntilMode.infinity;
  }

  @override
  List<dynamic> get props => [endDate, remainingIterations];
}
