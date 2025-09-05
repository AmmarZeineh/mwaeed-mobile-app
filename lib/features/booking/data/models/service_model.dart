class ServiceModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final double? depositAmount;
  final int durationInMin;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.depositAmount,
    required this.durationInMin,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      depositAmount: json['depositAmount'] != null
          ? (json['depositAmount'] as num).toDouble()
          : null,
      durationInMin: json['durationInMin'],
    );
  }
}
