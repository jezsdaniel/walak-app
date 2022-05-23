part of 'mlc24_bloc.dart';

@immutable
abstract class MLC24Event {}

class MLC24EventGetHistory extends MLC24Event {
  final DateTime from;
  final DateTime to;
  final int? status;

  MLC24EventGetHistory({
    required this.from,
    required this.to,
    this.status,
  });
}
