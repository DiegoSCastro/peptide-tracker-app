import 'dart:convert';

import 'package:equatable/equatable.dart';

/// A lightweight routine draft captured during onboarding.
class ProtocolDraft extends Equatable {
  /// Creates a protocol draft.
  const ProtocolDraft({
    required this.name,
    required this.compoundLabel,
    required this.category,
    required this.scheduleSummary,
    required this.startDate,
    this.plannedAmount,
    this.unitLabel = 'mg',
    this.reminderTime,
    this.notes = '',
  });

  /// Returns the default onboarding draft.
  factory ProtocolDraft.initial() {
    return ProtocolDraft(
      name: '',
      compoundLabel: '',
      category: 'GLP-1',
      scheduleSummary: 'Every 7 days',
      startDate: DateTime.now(),
      reminderTime: '09:00 AM',
    );
  }

  /// Restores a protocol draft from persisted json.
  factory ProtocolDraft.fromJson(Map<String, dynamic> json) {
    return ProtocolDraft(
      name: json['name'] as String? ?? '',
      compoundLabel: json['compoundLabel'] as String? ?? '',
      category: json['category'] as String? ?? 'GLP-1',
      scheduleSummary: json['scheduleSummary'] as String? ?? 'Every 7 days',
      startDate:
          DateTime.tryParse(json['startDate'] as String? ?? '') ??
          DateTime.now(),
      plannedAmount: json['plannedAmount'] as String?,
      unitLabel: json['unitLabel'] as String? ?? 'mg',
      reminderTime: json['reminderTime'] as String?,
      notes: json['notes'] as String? ?? '',
    );
  }

  /// Protocol display name.
  final String name;

  /// User-entered compound label.
  final String compoundLabel;

  /// User-selected category.
  final String category;

  /// User-selected schedule summary.
  final String scheduleSummary;

  /// User-entered routine start date.
  final DateTime startDate;

  /// Optional user-entered planned amount.
  final String? plannedAmount;

  /// Unit label stored as reference only.
  final String unitLabel;

  /// Optional reminder time label.
  final String? reminderTime;

  /// Optional routine notes.
  final String notes;

  /// Copies the current draft with selective overrides.
  ProtocolDraft copyWith({
    String? name,
    String? compoundLabel,
    String? category,
    String? scheduleSummary,
    DateTime? startDate,
    String? plannedAmount,
    String? unitLabel,
    String? reminderTime,
    String? notes,
  }) {
    return ProtocolDraft(
      name: name ?? this.name,
      compoundLabel: compoundLabel ?? this.compoundLabel,
      category: category ?? this.category,
      scheduleSummary: scheduleSummary ?? this.scheduleSummary,
      startDate: startDate ?? this.startDate,
      plannedAmount: plannedAmount ?? this.plannedAmount,
      unitLabel: unitLabel ?? this.unitLabel,
      reminderTime: reminderTime ?? this.reminderTime,
      notes: notes ?? this.notes,
    );
  }

  /// Converts the draft to a json-safe map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'compoundLabel': compoundLabel,
      'category': category,
      'scheduleSummary': scheduleSummary,
      'startDate': startDate.toIso8601String(),
      'plannedAmount': plannedAmount,
      'unitLabel': unitLabel,
      'reminderTime': reminderTime,
      'notes': notes,
    };
  }

  /// Encodes the draft for persistence.
  String encode() => jsonEncode(toJson());

  @override
  List<Object?> get props => [
    name,
    compoundLabel,
    category,
    scheduleSummary,
    startDate,
    plannedAmount,
    unitLabel,
    reminderTime,
    notes,
  ];
}
