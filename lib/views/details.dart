import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bmi_calculator/common/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import 'package:bmi_calculator/common/constants/colors.dart';
import 'package:bmi_calculator/common/constants/constants.dart';
import 'package:bmi_calculator/common/utils.dart';

final GlobalKey genKey = GlobalKey();

Future<void> captureWidget(CShare type) async {
  if (type == CShare.text) {
    await Share.share(details.join('\n\n'));
    return;
  }
  final RenderRepaintBoundary boundary =
      genKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  final ui.Image image = await boundary.toImage();

  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

  final Uint8List? pngBytes = byteData?.buffer.asUint8List();
  if (pngBytes != null) {
    XFile imgFile = XFile.fromData(pngBytes, mimeType: 'image/png');
    Share.shareXFiles([imgFile]);
  }
}

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = textThemeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'What is BMI?',
          style: textTheme.titleLarge,
        ),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: IconButton(
            onPressed: () => context.pop(),
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99),
              ),
              side: BorderSide.none,
              foregroundColor: primaryText,
              padding: const EdgeInsets.all(12),
            ),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        leadingWidth: 70,
        actions: [
          PopupMenuButton<CShare>(
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: CShare.text,
                child: Text('Share as text'),
              ),
              PopupMenuItem(
                value: CShare.image,
                child: Text('Share as image'),
              ),
            ],
            onSelected: (value) async {
              await captureWidget(value);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const SizedBox.square(
              dimension: 48,
              child: Icon(Icons.share),
            ),
          ),
        ],
        iconTheme: const IconThemeData(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://www.diabetes.co.uk/wp-content/uploads/2022/09/bmi-section.jpg",
                    ),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: 250,
              ),
              RepaintBoundary(
                key: genKey,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 48),
                  child: SelectableText.rich(
                    TextSpan(
                      text: details.first,
                      children: details
                          .sublist(1)
                          .map((e) => TextSpan(text: '\n\n$e'))
                          .toList(),
                    ),
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
