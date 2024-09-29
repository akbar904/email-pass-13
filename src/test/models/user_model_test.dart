
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.flutter_cubit_app/models/user_model.dart';

void main() {
	group('UserModel', () {
		test('should create a UserModel from JSON', () {
			final userJson = {
				'email': 'test@example.com',
				'password': 'password123'
			};

			final user = UserModel.fromJson(userJson);

			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});

		test('should convert a UserModel to JSON', () {
			final user = UserModel(email: 'test@example.com', password: 'password123');

			final userJson = user.toJson();

			expect(userJson['email'], 'test@example.com');
			expect(userJson['password'], 'password123');
		});

		test('should return true for equality when all fields are the same', () {
			final user1 = UserModel(email: 'test@example.com', password: 'password123');
			final user2 = UserModel(email: 'test@example.com', password: 'password123');

			expect(user1, user2);
		});

		test('should return false for equality when any field is different', () {
			final user1 = UserModel(email: 'test@example.com', password: 'password123');
			final user2 = UserModel(email: 'test2@example.com', password: 'password123');

			expect(user1, isNot(user2));
		});

		test('should have correct string representation', () {
			final user = UserModel(email: 'test@example.com', password: 'password123');

			expect(user.toString(), 'UserModel(email: test@example.com, password: password123)');
		});
	});
}
