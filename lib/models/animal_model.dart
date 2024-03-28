import 'package:json_annotation/json_annotation.dart';

part 'animal_model.g.dart';

@JsonSerializable()
class Animal {
  final String id;
  final String batchId;
  final String userId;
  final int age;
  final int price;
  final int numberOfAnimals;
  final int contractLength;
  final int animalLife;
  final bool isContractActive;
  final int numberOfEggs;
  final String dateLastFed;
  final String lastRedemptionDate;
  final String createdAt;
  final String updatedAt;
  final int v;

  Animal({
    required this.id,
    required this.batchId,
    required this.userId,
    required this.age,
    required this.price,
    required this.numberOfAnimals,
    required this.contractLength,
    required this.animalLife,
    required this.isContractActive,
    required this.numberOfEggs,
    required this.dateLastFed,
    required this.lastRedemptionDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);

  Map<String, dynamic> toJson() => _$AnimalToJson(this);
}