import 'package:equatable/equatable.dart';

/// Catalog copy for one lab test. Its `code` is a stable, locale-independent
/// identifier (SCD, TSH, …) used to key the facility's enabled/price state.
class LabTest extends Equatable {
  const LabTest({required this.code, required this.name, required this.sub});

  final String code;
  final String name;
  final String sub;

  @override
  List<Object> get props => [code, name, sub];
}
