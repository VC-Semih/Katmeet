/*
* Copyright 2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the AnimalModel type in your schema. */
@immutable
class AnimalModel extends Model {
  static const classType = const AnimalModelType();
  final String id;
  final TypeAnimal type;
  final String race;
  final String description;
  final DateTime birthdate;
  final List<UserModelAnimalModel> usermodels;
  final UserModel animalOwner;
  final List<PhotosModel> photosAnimal;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const AnimalModel._internal(
      {@required this.id,
      this.type,
      this.race,
      this.description,
      this.birthdate,
      this.usermodels,
      this.animalOwner,
      this.photosAnimal});

  factory AnimalModel(
      {@required String id,
      TypeAnimal type,
      String race,
      String description,
      DateTime birthdate,
      List<UserModelAnimalModel> usermodels,
      UserModel animalOwner,
      List<PhotosModel> photosAnimal}) {
    return AnimalModel._internal(
        id: id == null ? UUID.getUUID() : id,
        type: type,
        race: race,
        description: description,
        birthdate: birthdate,
        usermodels:
            usermodels != null ? List.unmodifiable(usermodels) : usermodels,
        animalOwner: animalOwner,
        photosAnimal: photosAnimal != null
            ? List.unmodifiable(photosAnimal)
            : photosAnimal);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AnimalModel &&
        id == other.id &&
        type == other.type &&
        race == other.race &&
        description == other.description &&
        birthdate == other.birthdate &&
        DeepCollectionEquality().equals(usermodels, other.usermodels) &&
        animalOwner == other.animalOwner &&
        DeepCollectionEquality().equals(photosAnimal, other.photosAnimal);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("AnimalModel {");
    buffer.write("id=" + id + ", ");
    buffer.write("type=" + enumToString(type) + ", ");
    buffer.write("race=" + race + ", ");
    buffer.write("description=" + description + ", ");
    buffer.write("birthdate=" +
        (birthdate != null ? birthdate.toDateTimeIso8601String() : "null") +
        ", ");
    buffer.write("animalOwner=" +
        (animalOwner != null ? animalOwner.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  AnimalModel copyWith(
      {@required String id,
      TypeAnimal type,
      String race,
      String description,
      DateTime birthdate,
      List<UserModelAnimalModel> usermodels,
      UserModel animalOwner,
      List<PhotosModel> photosAnimal}) {
    return AnimalModel(
        id: id ?? this.id,
        type: type ?? this.type,
        race: race ?? this.race,
        description: description ?? this.description,
        birthdate: birthdate ?? this.birthdate,
        usermodels: usermodels ?? this.usermodels,
        animalOwner: animalOwner ?? this.animalOwner,
        photosAnimal: photosAnimal ?? this.photosAnimal);
  }

  AnimalModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = enumFromString<TypeAnimal>(json['type'], TypeAnimal.values),
        race = json['race'],
        description = json['description'],
        birthdate = DateTimeParse.fromString(json['birthdate']),
        usermodels = json['usermodels'] is List
            ? (json['usermodels'] as List)
                .map((e) => UserModelAnimalModel.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        animalOwner = json['animalOwner'] != null
            ? UserModel.fromJson(
                new Map<String, dynamic>.from(json['animalOwner']))
            : null,
        photosAnimal = json['photosAnimal'] is List
            ? (json['photosAnimal'] as List)
                .map((e) =>
                    PhotosModel.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': enumToString(type),
        'race': race,
        'description': description,
        'birthdate': birthdate?.toDateTimeIso8601String(),
        'usermodels': usermodels?.map((e) => e?.toJson()),
        'animalOwner': animalOwner?.toJson(),
        'photosAnimal': photosAnimal?.map((e) => e?.toJson())
      };

  static final QueryField ID = QueryField(fieldName: "animalModel.id");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField RACE = QueryField(fieldName: "race");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField BIRTHDATE = QueryField(fieldName: "birthdate");
  static final QueryField USERMODELS = QueryField(
      fieldName: "usermodels",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (UserModelAnimalModel).toString()));
  static final QueryField ANIMALOWNER = QueryField(
      fieldName: "animalOwner",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (UserModel).toString()));
  static final QueryField PHOTOSANIMAL = QueryField(
      fieldName: "photosAnimal",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (PhotosModel).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "AnimalModel";
    modelSchemaDefinition.pluralName = "AnimalModels";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: AnimalModel.TYPE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: AnimalModel.RACE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: AnimalModel.DESCRIPTION,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: AnimalModel.BIRTHDATE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: AnimalModel.USERMODELS,
        isRequired: false,
        ofModelName: (UserModelAnimalModel).toString(),
        associatedKey: UserModelAnimalModel.ANIMALMODEL));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: AnimalModel.ANIMALOWNER,
        isRequired: false,
        targetName: "animalModelAnimalOwnerId",
        ofModelName: (UserModel).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: AnimalModel.PHOTOSANIMAL,
        isRequired: false,
        ofModelName: (PhotosModel).toString(),
        associatedKey: PhotosModel.ANIMALMODELID));
  });
}

class AnimalModelType extends ModelType<AnimalModel> {
  const AnimalModelType();

  @override
  AnimalModel fromJson(Map<String, dynamic> jsonData) {
    return AnimalModel.fromJson(jsonData);
  }
}
