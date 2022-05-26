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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter/foundation.dart';

/** This is an auto generated class representing the PhotosModel type in your schema. */
@immutable
class PhotosModel extends Model {
  static const classType = const _PhotosModelModelType();
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
      {String id, @required String s3key, @required String animalmodelID}) {
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
    buffer.write("id=" + "$id" + ", ");
    buffer.write("s3key=" + "$s3key" + ", ");
    buffer.write("animalmodelID=" + "$animalmodelID");
    buffer.write("}");

    return buffer.toString();
  }

  PhotosModel copyWith({String id, String s3key, String animalmodelID}) {
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

class _PhotosModelModelType extends ModelType<PhotosModel> {
  const _PhotosModelModelType();

  @override
  PhotosModel fromJson(Map<String, dynamic> jsonData) {
    return PhotosModel.fromJson(jsonData);
  }
}
