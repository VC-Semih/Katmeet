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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the PhotosModel type in your schema. */
@immutable
class PhotosModel extends Model {
  static const classType = const PhotosModelType();
  final String id;
  final String s3key;
  final String animalmodelID;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  const PhotosModel._internal(
      {@required this.id, @required this.s3key, @required this.animalmodelID});

  factory PhotosModel(
      {@required String id,
      @required String s3key,
      @required String animalmodelID}) {
    return PhotosModel._internal(
        id: id == null ? UUID.getUUID() : id,
        s3key: s3key,
        animalmodelID: animalmodelID);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PhotosModel &&
        id == other.id &&
        s3key == other.s3key &&
        animalmodelID == other.animalmodelID;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("PhotosModel {");
    buffer.write("id=" + id + ", ");
    buffer.write("s3key=" + s3key + ", ");
    buffer.write("animalmodelID=" + animalmodelID);
    buffer.write("}");

    return buffer.toString();
  }

  PhotosModel copyWith(
      {@required String id,
      @required String s3key,
      @required String animalmodelID}) {
    return PhotosModel(
        id: id ?? this.id,
        s3key: s3key ?? this.s3key,
        animalmodelID: animalmodelID ?? this.animalmodelID);
  }

  PhotosModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        s3key = json['s3key'],
        animalmodelID = json['animalmodelID'];

  Map<String, dynamic> toJson() =>
      {'id': id, 's3key': s3key, 'animalmodelID': animalmodelID};

  static final QueryField ID = QueryField(fieldName: "photosModel.id");
  static final QueryField S3KEY = QueryField(fieldName: "s3key");
  static final QueryField ANIMALMODELID =
      QueryField(fieldName: "animalmodelID");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "PhotosModel";
    modelSchemaDefinition.pluralName = "PhotosModels";

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
        key: PhotosModel.S3KEY,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: PhotosModel.ANIMALMODELID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class PhotosModelType extends ModelType<PhotosModel> {
  const PhotosModelType();

  @override
  PhotosModel fromJson(Map<String, dynamic> jsonData) {
    return PhotosModel.fromJson(jsonData);
  }
}
