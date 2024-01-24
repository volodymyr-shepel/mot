import 'package:flutter/material.dart';
import 'package:mot/size_config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
//flutter test lib/test/widget/test_size_config.dart
  testWidgets('Test Proportionate Screen Height', (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          var actual = SizeConfig(context: context).getProportionateScreenHeight(10);
          expect(actual, (10 / 812.0) * MediaQuery.of(context).size.height);

          // The builder function must return a widget.
          return Placeholder();
        },
      ),
    );
  });

  testWidgets('Test Proportionate Screen Width', (WidgetTester tester) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          var actual = SizeConfig(context: context).getProportionateScreenWidth(10);
          expect(actual, (10 / 375.0) * MediaQuery.of(context).size.width);

          // The builder function must return a widget.
          return Placeholder();
        },
      ),
    );
  });

  testWidgets('Test SizeConfig', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          // Create an instance of SizeConfig
          SizeConfig sizeConfig = SizeConfig(context: context);

          // Test the values
          expect(sizeConfig.screenWidth, equals(MediaQuery.of(context).size.width));
          expect(sizeConfig.screenHeight, equals(MediaQuery.of(context).size.height));
          expect(sizeConfig.orientation, equals(MediaQuery.of(context).orientation));

          // Test getProportionateScreenHeight
          double inputHeight = 100.0;
          double expectedHeight = (inputHeight / 812.0) * sizeConfig.screenHeight;
          expect(sizeConfig.getProportionateScreenHeight(inputHeight), equals(expectedHeight));

          // Test getProportionateScreenWidth
          double inputWidth = 50.0;
          double expectedWidth = (inputWidth / 375.0) * sizeConfig.screenWidth;
          expect(sizeConfig.getProportionateScreenWidth(inputWidth), equals(expectedWidth));

          return Container();
        },
      ),
    );
  });

}
