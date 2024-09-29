
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/screens/home_screen.dart';

// Mocking HomeCubit if needed for Cubit specific tests
class MockHomeCubit extends MockCubit<void> implements HomeCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('displays a logout button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: HomeScreen()));

			expect(find.text('Logout'), findsOneWidget);
			expect(find.byType(ElevatedButton), findsOneWidget);
		});
	});

	group('HomeScreen Cubit Tests', () {
		blocTest<MockHomeCubit, void>(
			'emits nothing when created',
			build: () => MockHomeCubit(),
			expect: () => [],
		);

		blocTest<MockHomeCubit, void>(
			'calls logout when logout button is pressed',
			build: () => MockHomeCubit(),
			act: (cubit) {
				// Simulating the button press
				final homeScreen = HomeScreen(cubit: cubit);
				final finder = find.text('Logout');
				
				tap(finder);
				verify(() => cubit.logout()).called(1);
			},
			expect: () => [],
		);
	});
}
