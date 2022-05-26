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

/** This is an auto generated class representing the UserModel type in your schema. */
@immutable
class UserModel extends Model {
  static const classType = const _UserModelModelType();
  final String id;
  final String username;
  final String email;
  final String profilePictureS3Key;
  final String aboutMe;
  final String phoneNumber;
  final String adress;
  final List<AnimalModel> ownedAnimals;
  final List<UserModelAnimalModel> likedAnimals;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const UserModel._internal(
      {@required this.id,
      @required this.username,
      @required this.email,
      this.profilePictureS3Key,
      this.aboutMe,
      this.phoneNumber,
      this.adress,
      this.ownedAnimals,
      this.likedAnimals});

  factory UserModel(
      {String id,
      @required String username,
      @required String email,
      String profilePictureS3Key,
      String aboutMe,
      String phoneNumber,
      String adress,
      List<AnimalModel> ownedAnimals,
      List<UserModelAnimalModel> likedAnimals}) {
    return UserModel._internal(
        id: id == null ? UUID.getUUID() : id,
        username: username,
        email: email,
        profilePictureS3Key: profilePictureS3Key,
        aboutMe: aboutMe,
        phoneNumber: phoneNumber,
        adress: adress,
        ownedAnimals: ownedAnimals != null
            ? List<AnimalModel>.unmodifiable(ownedAnimals)
            : ownedAnimals,
        likedAnimals: likedAnimals != null
            ? List<UserModelAnimalModel>.unmodifiable(likedAnimals)
            : likedAnimals);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserModel &&
        id == other.id &&
        username == other.username &&
        email == other.email &&
        profilePictureS3Key == other.profilePictureS3Key &&
        aboutMe == other.aboutMe &&
        phoneNumber == other.phoneNumber &&
        adress == other.adress &&
        DeepCollectionEquality().equals(ownedAnimals, other.ownedAnimals) &&
        DeepCollectionEquality().equals(likedAnimals, other.likedAnimals);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("UserModel {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$username" + ", ");
    buffer.write("email=" + "$email" + ", ");
    buffer.write("profilePictureS3Key=" + "$profilePictureS3Key" + ", ");
    buffer.write("aboutMe=" + "$aboutMe" + ", ");
    buffer.write("phoneNumber=" + "$phoneNumber" + ", ");
    buffer.write("adress=" + "$adress");
    buffer.write("}");

    return buffer.toString();
  }

  UserModel copyWith(
      {String id,
      String username,
      String email,
      String profilePictureS3Key,
      String aboutMe,
      String phoneNumber,
      String adress,
      List<AnimalModel> ownedAnimals,
      List<UserModelAnimalModel> likedAnimals}) {
    return UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        profilePictureS3Key: profilePictureS3Key ?? this.profilePictureS3Key,
        aboutMe: aboutMe ?? this.aboutMe,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        adress: adress ?? this.adress,
        ownedAnimals: ownedAnimals ?? this.ownedAnimals,
        likedAnimals: likedAnimals ?? this.likedAnimals);
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        profilePictureS3Key = json['profilePictureS3Key'],
        aboutMe = json['aboutMe'],
        phoneNumber = json['phoneNumber'],
        adress = json['adress'],
        ownedAnimals = json['ownedAnimals'] is List
            ? (json['ownedAnimals'] as List)
                .map((e) =>
                    AnimalModel.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        likedAnimals = json['likedAnimals'] is List
            ? (json['likedAnimals'] as List)
                .map((e) => UserModelAnimalModel.fromJson(
                    new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'profilePictureS3Key': profilePictureS3Key,
        'aboutMe': aboutMe,
        'phoneNumber': phoneNumber,
        'adress': adress,
        'ownedAnimals':
            ownedAnimals?.map((AnimalModel e) => e?.toJson())?.toList(),
        'likedAnimals':
            likedAnimals?.map((UserModelAnimalModel e) => e?.toJson())?.toList()
      };

  static final QueryField ID = QueryField(fieldName: "userModel.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PROFILEPICTURES3KEY =
      QueryField(fieldName: "profilePictureS3Key");
  static final QueryField ABOUTME = QueryField(fieldName: "aboutMe");
  static final QueryField PHONENUMBER = QueryField(fieldName: "phoneNumber");
  static final QueryField ADRESS = QueryField(fieldName: "adress");
  static final QueryField OWNEDANIMALS = QueryField(
      fieldName: "ownedAnimals",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (AnimalModel).toString()));
  static final QueryField LIKEDANIMALS = QueryField(
      fieldName: "likedAnimals",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (UserModelAnimalModel).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserModel";
    modelSchemaDefinition.pluralName = "UserModels";

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
        key: UserModel.USERNAME,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserModel.EMAIL,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserModel.PROFILEPICTURES3KEY,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserModel.ABOUTME,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserModel.PHONENUMBER,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: UserModel.ADRESS,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: UserModel.OWNEDANIMALS,
        isRequired: false,
        ofModelName: (AnimalModel).toString(),
        associatedKey: AnimalModel.ANIMALOWNER));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: UserModel.LIKEDANIMALS,
        isRequired: false,
        ofModelName: (UserModelAnimalModel).toString(),
        associatedKey: UserModelAnimalModel.USERMODEL));
  });
}

class _UserModelModelType extends ModelType<UserModel> {
  const _UserModelModelType();

  @override
  UserModel fromJson(Map<String, dynamic> jsonData) {
    return UserModel.fromJson(jsonData);
  }
}
