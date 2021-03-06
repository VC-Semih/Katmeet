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
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the UserModelAnimalModel type in your schema. */
@immutable
class UserModelAnimalModel extends Model {
  static const classType = const _UserModelAnimalModelModelType();
  final String id;
  final AnimalModel animalmodel;
  final UserModel usermodel;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const UserModelAnimalModel._internal(
      {@required this.id,
      @required this.animalmodel,
      @required this.usermodel});

  factory UserModelAnimalModel(
      {String id,
      @required AnimalModel animalmodel,
      @required UserModel usermodel}) {
    return UserModelAnimalModel._internal(
        id: id == null ? UUID.getUUID() : id,
        animalmodel: animalmodel,
        usermodel: usermodel);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModelAnimalModel &&
        id == other.id &&
        animalmodel == other.animalmodel &&
        usermodel == other.usermodel;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("UserModelAnimalModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("animalmodel=" +
        (animalmodel != null ? animalmodel.toString() : "null") +
        ", ");
    buffer.write(
        "usermodel=" + (usermodel != null ? usermodel.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  UserModelAnimalModel copyWith(
      {String id, AnimalModel animalmodel, UserModel usermodel}) {
    return UserModelAnimalModel(
        id: id ?? this.id,
        animalmodel: animalmodel ?? this.animalmodel,
        usermodel: usermodel ?? this.usermodel);
  }

  UserModelAnimalModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        animalmodel = json['animalmodel'] != null
            ? AnimalModel.fromJson(
                new Map<String, dynamic>.from(json['animalmodel']))
            : null,
        usermodel = json['usermodel'] != null
            ? UserModel.fromJson(
                new Map<String, dynamic>.from(json['usermodel']))
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'animalmodel': animalmodel?.toJson(),
        'usermodel': usermodel?.toJson()
      };

  static final QueryField ID = QueryField(fieldName: "userModelAnimalModel.id");
  static final QueryField ANIMALMODEL = QueryField(
      fieldName: "animalmodel",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (AnimalModel).toString()));
  static final QueryField USERMODEL = QueryField(
      fieldName: "usermodel",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (UserModel).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserModelAnimalModel";
    modelSchemaDefinition.pluralName = "UserModelAnimalModels";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ]),
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: UserModelAnimalModel.ANIMALMODEL,
        isRequired: true,
        targetName: "animalmodelID",
        ofModelName: (AnimalModel).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: UserModelAnimalModel.USERMODEL,
        isRequired: true,
        targetName: "usermodelID",
        ofModelName: (UserModel).toString()));
  });
}

class _UserModelAnimalModelModelType extends ModelType<UserModelAnimalModel> {
  const _UserModelAnimalModelModelType();

  @override
  UserModelAnimalModel fromJson(Map<String, dynamic> jsonData) {
    return UserModelAnimalModel.fromJson(jsonData);
  }
}
