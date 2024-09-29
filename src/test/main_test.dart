
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/main.dart';

void main() {
	group('Main App Initialization', () {
		testWidgets('App initializes and shows LoginScreen', (WidgetTester tester) async {
			// Build our app and trigger a frame.
			await tester.pumpWidget(MyApp());

			// Verify LoginScreen is displayed
			expect(find.text('Login'), findsOneWidget);
			expect(find.byType(TextField), findsNWidgets(2)); // Email and password fields
			expect(find.text('Login'), findsOneWidget); // Login button
		});
	});
}
