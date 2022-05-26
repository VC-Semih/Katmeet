/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the AnimalModel type in your schema. */
@immutable
class AnimalModel extends Model {
  static const classType = const _AnimalModelModelType();
  final String id;
  final TypeAnimal type;
  final String race;
  final String description;
  final TemporalDateTime birthdate;
  final List<UserModelAnimalModel> usermodels;
  final String animalOwner;
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
      {String id,
      TypeAnimal type,
      String race,
      String description,
      TemporalDateTime birthdate,
      List<UserModelAnimalModel> usermodels,
      String animalOwner,
      List<PhotosModel> photosAnimal}) {
    return AnimalModel._internal(
        id: id == null ? UUID.getUUID() : id,
        type: type,
        race: race,
        description: description,
        birthdate: birthdate,
        usermodels: usermodels != null
            ? List<UserModelAnimalModel>.unmodifiable(usermodels)
            : usermodels,
        animalOwner: animalOwner,
        photosAnimal: photosAnimal != null
            ? List<PhotosModel>.unmodifiable(photosAnimal)
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
    buffer.write("id=" + "$id" + ", ");
    buffer.write("type=" + (type != null ? enumToString(type) : "null") + ", ");
    buffer.write("race=" + "$race" + ", ");
    buffer.write("description=" + "$description" + ", ");
    buffer.write("birthdate=" +
        (birthdate != null ? birthdate.format() : "null") +
        ", ");
    buffer.write("animalOwner=" + "$animalOwner");
    buffer.write("}");

    return buffer.toString();
  }

  AnimalModel copyWith(
      {String id,
      TypeAnimal type,
      String race,
      String description,
      TemporalDateTime birthdate,
      List<UserModelAnimalModel> usermodels,
      String animalOwner,
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
        birthdate = json['birthdate'] != null
            ? TemporalDateTime.fromString(json['birthdate'])
            : null,
        usermodels = json['usermodels'] is List
            ? (json['usermodels'] as List)
                .map((e) => UserModelAnimalModel.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        animalOwner = json['animalOwner'],
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
        'birthdate': birthdate?.format(),
        'usermodels':
            usermodels?.map((UserModelAnimalModel e) => e?.toJson())?.toList(),
        'animalOwner': animalOwner,
        'photosAnimal':
            photosAnimal?.map((PhotosModel e) => e?.toJson())?.toList()
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
  static final QueryField ANIMALOWNER = QueryField(fieldName: "animalOwner");
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

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: AnimalModel.ANIMALOWNER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: AnimalModel.PHOTOSANIMAL,
        isRequired: false,
        ofModelName: (PhotosModel).toString(),
        associatedKey: PhotosModel.ANIMALMODELID));
  });
}

class _AnimalModelModelType extends ModelType<AnimalModel> {
  const _AnimalModelModelType();

  @override
  AnimalModel fromJson(Map<String, dynamic> jsonData) {
    return AnimalModel.fromJson(jsonData);
  }
}
