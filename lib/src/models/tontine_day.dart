/// Represents a single day in the tontine calendar
class TontineDay {
  /// The day number (1-31)
  final int day;
  
  /// The month this day belongs to (1-12)
  final int month;
  
  /// Whether this day has been validated/paid
  final bool isValidated;
  
  /// The amount associated with this day (optional)
  final double? amount;
  
  /// Additional metadata for this day (optional)
  final Map<String, dynamic>? metadata;
  
  /// The date when this day was validated (optional)
  final DateTime? validatedDate;

  const TontineDay({
    required this.day,
    required this.month,
    this.isValidated = false,
    this.amount,
    this.metadata,
    this.validatedDate,
  }) : assert(day >= 1 && day <= 31, 'Day must be between 1 and 31'),
       assert(month >= 1 && month <= 12, 'Month must be between 1 and 12');

  /// Creates a copy of this TontineDay with the given fields replaced
  TontineDay copyWith({
    int? day,
    int? month,
    bool? isValidated,
    double? amount,
    Map<String, dynamic>? metadata,
    DateTime? validatedDate,
  }) {
    return TontineDay(
      day: day ?? this.day,
      month: month ?? this.month,
      isValidated: isValidated ?? this.isValidated,
      amount: amount ?? this.amount,
      metadata: metadata ?? this.metadata,
      validatedDate: validatedDate ?? this.validatedDate,
    );
  }

  /// Creates a TontineDay from a JSON map
  factory TontineDay.fromJson(Map<String, dynamic> json) {
    return TontineDay(
      day: json['day'] as int,
      month: json['month'] as int,
      isValidated: json['isValidated'] as bool? ?? false,
      amount: json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      metadata: json['metadata'] as Map<String, dynamic>?,
      validatedDate: json['validatedDate'] != null 
          ? DateTime.parse(json['validatedDate'] as String)
          : null,
    );
  }

  /// Converts this TontineDay to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'month': month,
      'isValidated': isValidated,
      'amount': amount,
      'metadata': metadata,
      'validatedDate': validatedDate?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TontineDay &&
        other.day == day &&
        other.month == month &&
        other.isValidated == isValidated &&
        other.amount == amount &&
        other.validatedDate == validatedDate;
  }

  @override
  int get hashCode {
    return Object.hash(day, month, isValidated, amount, validatedDate);
  }

  @override
  String toString() {
    return 'TontineDay(day: $day, month: $month, isValidated: $isValidated, amount: $amount, validatedDate: $validatedDate)';
  }
}
