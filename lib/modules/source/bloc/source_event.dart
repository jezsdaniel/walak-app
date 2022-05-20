part of 'source_bloc.dart';

@immutable
abstract class SourceEvent {}

class SourceEventGetBalance extends SourceEvent {
  SourceEventGetBalance();
}

class SourceEventGetPaymentMethods extends SourceEvent {
  SourceEventGetPaymentMethods();
}
