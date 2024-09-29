
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:com.example.flutter_cubit_app/models/user_model.dart';

// Define the states for the LoginCubit

abstract class LoginState extends Equatable {
	const LoginState();

	@override
	List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
	final String message;
	const LoginFailure(this.message);

	@override
	List<Object> get props => [message];
}

// Define the LoginCubit

class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		try {
			emit(LoginLoading());
			// Simulate a network call
			await Future.delayed(Duration(seconds: 1));
			// Simplified user validation logic
			if (email == 'test@example.com' && password == 'password') {
				emit(LoginSuccess());
			} else {
				emit(LoginFailure('Invalid credentials'));
			}
		} catch (e) {
			emit(LoginFailure(e.toString()));
		}
	}
}
