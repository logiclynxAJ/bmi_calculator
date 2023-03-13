import 'package:bmi_calculator/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:bmi_calculator/common/constants/gen/assets.gen.dart';
import 'package:bmi_calculator/common/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key, required this.state});

  final BmiState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GenderCard(
          image: Assets.images.male,
          title: 'Male',
          onClick: () {
            context.read<BmiBloc>().add(const UpdateGender(Gender.male));
          },
          height: 100,
          selected: state.gender == Gender.male,
        ),
        GenderCard(
          image: Assets.images.female,
          title: 'Female',
          alignRight: true,
          height: 150,
          selected: state.gender == Gender.female,
          onClick: () {
            context.read<BmiBloc>().add(const UpdateGender(Gender.female));
          },
        ),
      ],
    );
  }
}

class GenderCard extends StatelessWidget {
  const GenderCard({
    super.key,
    required this.image,
    required this.title,
    this.alignRight = false,
    this.height,
    required this.onClick,
    this.selected = false,
  });

  final SvgGenImage image;
  final String title;
  final bool alignRight, selected;
  final double? height;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        fixedSize: const Size(180, 160),
        padding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 10,
        shadowColor: shadowColor,
        side: selected
            ? const BorderSide(color: primary, width: 2)
            : BorderSide.none,
      ),
      child: Stack(
        children: [
          Positioned(
            width: 180,
            top: 24,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: alignRight ? null : 8,
            right: alignRight ? 8 : null,
            child: image.svg(
              theme: const SvgTheme(currentColor: Colors.white),
              width: 120,
              height: height,
            ),
          ),
        ],
      ),
    );
  }
}
