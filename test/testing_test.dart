import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hec_eservices/test_Screen/test_screen.dart';

void main(){
  testWidgets("Testing", (WidgetTester tester) async{
    await tester.pumpWidget(TestScreen());

    expect(find.text('HELLO'), findsOneWidget);
  });

}