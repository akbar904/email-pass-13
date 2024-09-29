
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/screens/login_screen.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('Should display email and password text fields and login button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));
			
			expect(find.byType(TextField), findsNWidgets(2)); // For email and password
			expect(find.byType(ElevatedButton), findsOneWidget); // For login button
			expect(find.text('Login'), findsOneWidget); // Button text
		});

		testWidgets('Should display error message on invalid login', (WidgetTester tester) async {
			final mockLoginCubit = MockLoginCubit();

			when(() => mockLoginCubit.state).thenReturn(LoginFailure('Invalid credentials'));

			await tester.pumpWidget(MaterialApp(
				home: BlocProvider<LoginCubit>(
					create: (_) => mockLoginCubit,
					child: LoginScreen(),
				),
			));

			expect(find.text('Invalid credentials'), findsOneWidget);
		});
	});

	group('LoginCubit Tests', () {
		blocTest<MockLoginCubit, LoginState>(
			'Should emit LoginLoading then LoginSuccess when login is successful',
			build: () => MockLoginCubit(),
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [LoginLoading(), LoginSuccess()],
		);

		blocTest<MockLoginCubit, LoginState>(
			'Should emit LoginLoading then LoginFailure when login fails',
			build: () => MockLoginCubit(),
			act: (cubit) => cubit.login('wrong@example.com', 'wrongpassword'),
			expect: () => [LoginLoading(), LoginFailure('Invalid credentials')],
		);
	});
}
