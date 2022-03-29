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
import 'AnimalModel.dart';
import 'PhotosModel.dart';
import 'UserModel.dart';
import 'UserModelAnimalModel.dart';

export 'AnimalModel.dart';
export 'PhotosModel.dart';
export 'TypeAnimal.dart';
export 'UserModel.dart';
export 'UserModelAnimalModel.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "fb4fe31f52814d14fae1aa9448a75a7f";
  @override
  List<ModelSchema> modelSchemas = [
    AnimalModel.schema,
    PhotosModel.schema,
    UserModel.schema,
    UserModelAnimalModel.schema
  ];
  static final ModelProvider _instance = ModelProvider();

  static ModelProvider get instance => _instance;

  @override
  ModelType<Model> getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "UserModel":
        {
          return UserModel.classType;
        }
        break;
      case "PhotosModel":
        {
          return PhotosModel.classType;
        }
        break;
      case "AnimalModel":
        {
          return AnimalModel.classType;
        }
        break;
      case "UserModelAnimalModel":
        {
          return UserModelAnimalModel.classType;
        }
        break;
      default:
        {
          throw Exception(
              "Failed to find model in model provider for model name: " +
                  modelName);
        }
    }
  }
}
