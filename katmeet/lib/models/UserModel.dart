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
  final List<PhotosModel> PhotosModels;

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
      this.PhotosModels});

  factory UserModel(
      {@required String id,
      @required String username,
      @required String email,
      List<PhotosModel> PhotosModels}) {
    return UserModel._internal(
        id: id == null ? UUID.getUUID() : id,
        username: username,
        email: email,
        PhotosModels: PhotosModels != null
            ? List.unmodifiable(PhotosModels)
            : PhotosModels);
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
        DeepCollectionEquality().equals(PhotosModels, other.PhotosModels);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("UserModel {");
    buffer.write("id=" + id + ", ");
    buffer.write("username=" + username + ", ");
    buffer.write("email=" + email);
    buffer.write("}");

    return buffer.toString();
  }

  UserModel copyWith(
      {@required String id,
      @required String username,
      @required String email,
      List<PhotosModel> PhotosModels}) {
    return UserModel(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        PhotosModels: PhotosModels ?? this.PhotosModels);
  }

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        email = json['email'],
        PhotosModels = json['PhotosModels'] is List
            ? (json['PhotosModels'] as List)
                .map((e) =>
                    PhotosModel.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'PhotosModels': PhotosModels?.map((e) => e?.toJson())
      };

  static final QueryField ID = QueryField(fieldName: "userModel.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHOTOSMODELS = QueryField(
      fieldName: "PhotosModels",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (PhotosModel).toString()));
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

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: UserModel.PHOTOSMODELS,
        isRequired: false,
        ofModelName: (PhotosModel).toString(),
        associatedKey: PhotosModel.USERMODELID));
  });
}

class UserModelType extends ModelType<UserModel> {
  const UserModelType();

  @override
  UserModel fromJson(Map<String, dynamic> jsonData) {
    return UserModel.fromJson(jsonData);
  }
}
