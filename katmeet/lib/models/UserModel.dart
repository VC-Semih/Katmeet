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

/** This is an auto generated class representing the UserModel type in your schema. */
@immutable
class UserModel extends Model {
  static const classType = const UserModelType();
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
      {@required String id,
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
            ? List.unmodifiable(ownedAnimals)
            : ownedAnimals,
        likedAnimals: likedAnimals != null
            ? List.unmodifiable(likedAnimals)
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
    buffer.write("id=" + id + ", ");
    buffer.write("username=" + username + ", ");
    buffer.write("email=" + email + ", ");
    buffer.write("profilePictureS3Key=" + profilePictureS3Key + ", ");
    buffer.write("aboutMe=" + aboutMe + ", ");
    buffer.write("phoneNumber=" + phoneNumber + ", ");
    buffer.write("adress=" + adress);
    buffer.write("}");

    return buffer.toString();
  }

  UserModel copyWith(
      {@required String id,
      @required String username,
      @required String email,
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
        'ownedAnimals': ownedAnimals?.map((e) => e?.toJson()),
        'likedAnimals': likedAnimals?.map((e) => e?.toJson())
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

class UserModelType extends ModelType<UserModel> {
  const UserModelType();

  @override
  UserModel fromJson(Map<String, dynamic> jsonData) {
    return UserModel.fromJson(jsonData);
  }
}
