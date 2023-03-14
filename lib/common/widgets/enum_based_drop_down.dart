import 'package:bmi_calculator/common/utils.dart';
import 'package:flutter/material.dart';

class EnumDropDown<Type extends Enum> extends StatelessWidget {
  const EnumDropDown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.values,
  });

  final Type value;
  final List<Type> values;
  final void Function(Type?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = textThemeOf(context);
    return DropdownButton<Type>(
      underline: const SizedBox.shrink(),
      value: value,
      items: values
          .map((Type e) => DropdownMenuItem<Type>(
                value: e,
                child: Text('${e.type} (${e.name})'),
              ))
          .toList(),
      onChanged: onChanged,
      style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
    );
  }
}
