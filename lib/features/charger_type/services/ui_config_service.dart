import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:task/features/charger_type/core/constants/assets_constants.dart';
import 'package:task/features/charger_type/models/ui_components_model.dart';

class UIConfigService {
  static Future<UIComponent> loadConfig() async {
    try {
      final String jsonString =
          await rootBundle.loadString(AssetsConstants.uiConfig);

      final UIComponent jsonData = UIComponent.fromJson(jsonDecode(jsonString));

      return jsonData;
    } catch (e) {
      throw Exception('Failed to load UI configuration: $e');
    }
  }
}
