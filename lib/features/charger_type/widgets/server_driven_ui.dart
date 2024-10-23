import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/features/charger_type/models/ui_components_model.dart';

class ServerDrivenUI extends StatelessWidget {
  final UIComponent component;

  const ServerDrivenUI({
    super.key,
    required this.component,
  });

  @override
  Widget build(BuildContext context) {
    return _buildComponent(component);
  }

  Widget _buildComponent(UIComponent component) {
    switch (component.type) {
      case 'CONTAINER':
        return _buildContainer(component);
      case 'TEXT':
        return _buildText(component);
      case 'ROW':
        return _buildRow(component);
      case 'SIZEDBOX':
        return _buildSizedBox(component);
      case 'ICON':
        return _buildIcon(component);
      case 'COLUMN':
        return _buildColumn(component);
      case 'BUTTON':
        return _buildButton(component);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildContainer(UIComponent component) {
    final borderData = component.styles['border'] as Map<String, dynamic>?;
    return Container(
      height: component.styles['height']?.toDouble(),
      width: component.styles['width']?.toDouble(),
      padding: _getPadding(component.styles['padding']),
      margin: _getMargin(component.styles),
      decoration: BoxDecoration(
        color: _getColor(component.styles['backgroundColor']),
        borderRadius: _getBorderRadius(component.styles['border']),
        border: Border.all(
          color:
              _getColor(borderData?['color']) ?? Colors.black.withOpacity(0.2),
        ),
      ),
      child: component.children.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: component.children
                  .map((child) => _buildComponent(child))
                  .toList(),
            )
          : null,
    );
  }

  Widget _buildButton(UIComponent component) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
            _getColor(component.styles['backgroundColor'])),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(double.tryParse(
                component.styles['border']['borderRadius']?.toString() ??
                    '8')!))),
      ),
      onPressed: () {},
      child: Text(
        component.data ?? '',
        style: TextStyle(
          fontSize:
              double.tryParse(component.styles['fontStyle']['size'] ?? '14'),
          fontWeight: _getFontWeight(component.styles['fontStyle']['weight']),
          color: _getColor(component.styles['fontStyle']['color']),
        ),
      ),
    );
  }

  Widget _buildIcon(UIComponent component) {
    return SvgPicture.network(
      component.data ?? '',
      height: component.styles['height']?.toDouble(),
      width: component.styles['width']?.toDouble(),
    );
  }

  Widget _buildText(UIComponent component) {
    final fontStyle = component.styles['fontStyle'] ?? {};

    return Padding(
      padding: _getMargin(component.styles),
      child: Text(
        component.data ?? '',
        style: TextStyle(
          fontSize: double.tryParse(fontStyle['size'] ?? '14'),
          fontWeight: _getFontWeight(fontStyle['weight']),
          color: _getColor(fontStyle['color']),
        ),
      ),
    );
  }

  Widget _buildSizedBox(UIComponent component) {
    return SizedBox(
      height: component.styles['height']?.toDouble(),
      width: component.styles['width']?.toDouble(),
    );
  }

  Widget _buildRow(UIComponent component) {
    return Row(
      mainAxisAlignment:
          _getMainAxisAlignment(component.styles['mainAxisAlignment']),
      crossAxisAlignment:
          _getCrossAxisAlignment(component.styles['crossAxisAlignment']),
      children:
          component.children.map((child) => _buildComponent(child)).toList(),
    );
  }

  Widget _buildColumn(UIComponent component) {
    return Column(
      mainAxisAlignment:
          _getMainAxisAlignment(component.styles['mainAxisAlignment']),
      crossAxisAlignment:
          _getCrossAxisAlignment(component.styles['crossAxisAlignment']),
      children:
          component.children.map((child) => _buildComponent(child)).toList(),
    );
  }

  MainAxisAlignment _getMainAxisAlignment(String? alignment) {
    switch (alignment) {
      case 'start':
        return MainAxisAlignment.start;
      case 'end':
        return MainAxisAlignment.end;
      case 'center':
        return MainAxisAlignment.center;
      case 'spaceBetween':
        return MainAxisAlignment.spaceBetween;
      case 'spaceAround':
        return MainAxisAlignment.spaceAround;
      case 'spaceEvenly':
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.start;
    }
  }

  CrossAxisAlignment _getCrossAxisAlignment(String? alignment) {
    switch (alignment) {
      case 'start':
        return CrossAxisAlignment.start;
      case 'end':
        return CrossAxisAlignment.end;
      case 'center':
        return CrossAxisAlignment.center;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      case 'baseline':
        return CrossAxisAlignment.baseline;
      default:
        return CrossAxisAlignment.start;
    }
  }

  EdgeInsets _getPadding(dynamic padding) {
    if (padding is int) {
      return EdgeInsets.all(padding.toDouble());
    }
    return EdgeInsets.zero;
  }

  EdgeInsets _getMargin(Map<String, dynamic> styles) {
    final marginBottom = styles['marginBottom'];
    if (marginBottom != null) {
      return EdgeInsets.only(bottom: marginBottom.toDouble());
    }
    return EdgeInsets.zero;
  }

  Color? _getColor(String? colorString) {
    if (colorString == null) return null;
    if (colorString.startsWith('#')) {
      return Color(int.parse('FF${colorString.substring(1)}', radix: 16));
    }
    return null;
  }

  BorderRadius? _getBorderRadius(dynamic border) {
    if (border != null) {
      return BorderRadius.circular(border['borderRadius'].toDouble());
    }
    return null;
  }

  FontWeight _getFontWeight(String? weight) {
    switch (weight) {
      case 'w100':
        return FontWeight.w100;
      case 'w200':
        return FontWeight.w200;
      case 'w300':
        return FontWeight.w300;
      case 'w400':
        return FontWeight.w400;
      case 'w500':
        return FontWeight.w500;
      case 'w600':
        return FontWeight.w600;
      case 'w700':
        return FontWeight.w700;
      case 'w800':
        return FontWeight.w800;
      case 'w900':
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }
}
