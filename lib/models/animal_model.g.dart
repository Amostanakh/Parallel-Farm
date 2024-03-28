// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'animal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Animal _$AnimalFromJson(Map<String, dynamic> json) => Animal(
      id: json['_id'] as String,
      batchId: json['batchId'] as String,
      userId: json['userId'] as String,
      age: json['age'] as int,
      price: json['price'] as int,
      numberOfAnimals: json['numberOfAnimals'] as int,
      contractLength: json['contractLength'] as int,
      animalLife: json['animalLife'] as int,
      isContractActive: json['isContractActive'] as bool,
      numberOfEggs: json['numberOfEggs'] as int,
      dateLastFed: json['dateLastFed'] as String,
      lastRedemptionDate: json['lastRedemptionDate'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: json['__v'] as int,
    );

Map<String, dynamic> _$AnimalToJson(Animal instance) => <String, dynamic>{
      'id': instance.id,
      'batchId': instance.batchId,
      'userId': instance.userId,
      'age': instance.age,
      'price': instance.price,
      'numberOfAnimals': instance.numberOfAnimals,
      'contractLength': instance.contractLength,
      'animalLife': instance.animalLife,
      'isContractActive': instance.isContractActive,
      'numberOfEggs': instance.numberOfEggs,
      'dateLastFed': instance.dateLastFed,
      'lastRedemptionDate': instance.lastRedemptionDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'v': instance.v,
    };
