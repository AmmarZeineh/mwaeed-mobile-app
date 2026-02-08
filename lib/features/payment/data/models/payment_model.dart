import 'package:mwaeed_mobile_app/features/payment/domain/entities/payment_entity.dart';

class PaymentModel {
  int? amount;
  String? type;
  String? status;

  PaymentModel({this.amount, this.type, this.status});

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    amount: json['amount'] as int?,
    type: json['type'] as String?,
    status: json['status'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'type': type,
    'status': status,
  };

  PaymentEntity toEntity() {
    return PaymentEntity(
      amount: amount ?? 0,
      type: type ?? '',
      status: status ?? '',
    );
  }
}
