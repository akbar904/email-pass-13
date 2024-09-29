
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.flutter_cubit_app/cubits/login_cubit.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginCubit', () {
		late LoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		tearDown(() {
			loginCubit.close();
		});

		test('initial state is LoginInitial', () {
			expect(loginCubit.state, equals(LoginInitial()));
		});

		blocTest<LoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login('test@example.com', 'password'))
					.thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future.delayed(Duration(seconds: 1));
					cubit.emit(LoginSuccess());
				});
				cubit.login('test@example.com', 'password');
			},
			expect: () => [
				LoginLoading(),
				LoginSuccess(),
			],
		);

		blocTest<LoginCubit, LoginState>(
			'emits [LoginLoading, LoginFailure] when login fails',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login('test@example.com', 'wrong_password'))
					.thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future.delayed(Duration(seconds: 1));
					cubit.emit(LoginFailure('Invalid credentials'));
				});
				cubit.login('test@example.com', 'wrong_password');
			},
			expect: () => [
				LoginLoading(),
				LoginFailure('Invalid credentials'),
			],
		);
	});
}
