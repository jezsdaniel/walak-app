part of 'mlc24_bloc.dart';

class MLC24State {
  final List<MLC24Transaction> transactions;

  final RequestStatus status;
  final String errorMessage;

  MLC24State({
    this.transactions = const [],
    this.status = RequestStatus.initial,
    this.errorMessage = '',
  });

  MLC24State copyWith({
    List<MLC24Transaction>? transactions,
    RequestStatus? status,
    String? errorMessage,
  }) {
    return MLC24State(
      transactions: transactions ?? this.transactions,
      status: status ?? RequestStatus.initial,
      errorMessage: errorMessage ?? '',
    );
  }
}
