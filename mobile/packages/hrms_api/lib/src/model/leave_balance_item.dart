//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_balance_item.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LeaveBalanceItem {
  /// Returns a new [LeaveBalanceItem] instance.
  LeaveBalanceItem({
    required this.leaveTypeId,

    required this.leaveTypeCode,

    required this.leaveTypeName,

    required this.year,

    required this.tracksBalance,

    required this.annualQuota,

    required this.opening,

    required this.accrued,

    required this.used,

    required this.encashed,

    required this.closing,

    required this.pending,

    required this.available,
  });

  @JsonKey(name: r'leaveTypeId', required: true, includeIfNull: false)
  final String leaveTypeId;

  @JsonKey(name: r'leaveTypeCode', required: true, includeIfNull: false)
  final String leaveTypeCode;

  @JsonKey(name: r'leaveTypeName', required: true, includeIfNull: false)
  final String leaveTypeName;

  @JsonKey(name: r'year', required: true, includeIfNull: false)
  final int year;

  @JsonKey(name: r'tracksBalance', required: true, includeIfNull: false)
  final bool tracksBalance;

  /// From the matching policy; null when no policy applies
  @JsonKey(name: r'annualQuota', required: true, includeIfNull: true)
  final num? annualQuota;

  @JsonKey(name: r'opening', required: true, includeIfNull: false)
  final num opening;

  @JsonKey(name: r'accrued', required: true, includeIfNull: false)
  final num accrued;

  @JsonKey(name: r'used', required: true, includeIfNull: false)
  final num used;

  @JsonKey(name: r'encashed', required: true, includeIfNull: false)
  final num encashed;

  @JsonKey(name: r'closing', required: true, includeIfNull: false)
  final num closing;

  /// Days in pending requests
  @JsonKey(name: r'pending', required: true, includeIfNull: false)
  final num pending;

  /// closing - pending
  @JsonKey(name: r'available', required: true, includeIfNull: false)
  final num available;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveBalanceItem &&
          other.leaveTypeId == leaveTypeId &&
          other.leaveTypeCode == leaveTypeCode &&
          other.leaveTypeName == leaveTypeName &&
          other.year == year &&
          other.tracksBalance == tracksBalance &&
          other.annualQuota == annualQuota &&
          other.opening == opening &&
          other.accrued == accrued &&
          other.used == used &&
          other.encashed == encashed &&
          other.closing == closing &&
          other.pending == pending &&
          other.available == available;

  @override
  int get hashCode =>
      leaveTypeId.hashCode +
      leaveTypeCode.hashCode +
      leaveTypeName.hashCode +
      year.hashCode +
      tracksBalance.hashCode +
      (annualQuota == null ? 0 : annualQuota.hashCode) +
      opening.hashCode +
      accrued.hashCode +
      used.hashCode +
      encashed.hashCode +
      closing.hashCode +
      pending.hashCode +
      available.hashCode;

  factory LeaveBalanceItem.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceItemFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveBalanceItemToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
