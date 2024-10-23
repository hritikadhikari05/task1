import 'package:flutter/material.dart';
import 'package:task/features/charger_type/models/ui_components_model.dart';
import 'package:task/features/charger_type/services/ui_config_service.dart';
import 'package:task/features/charger_type/widgets/server_driven_ui.dart';

class ChargerType extends StatelessWidget {
  const ChargerType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<UIComponent>(
            future: UIConfigService.loadConfig(),
            builder: (context, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshots.hasError) {
                return const Center(child: Text("Error"));
              }

              if (snapshots.hasData) {
                return ServerDrivenUI(component: snapshots.data!);
              }

              return const Center(child: Text("Loading"));
            }),
      ),
    );
  }
}
