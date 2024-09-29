
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.flutter_cubit_app/cubits/login_cubit.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocProvider<LoginCubit>(
				create: (context) => LoginCubit(),
				child: LoginForm(),
			),
		);
	}
}

class LoginForm extends StatelessWidget {
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Padding(
			padding: const EdgeInsets.all(16.0),
			child: Column(
				children: [
					TextField(
						controller: _emailController,
						decoration: InputDecoration(labelText: 'Email'),
					),
					TextField(
						controller: _passwordController,
						decoration: InputDecoration(labelText: 'Password'),
						obscureText: true,
					),
					ElevatedButton(
						onPressed: () {
							BlocProvider.of<LoginCubit>(context).login(
								_emailController.text,
								_passwordController.text,
							);
						},
						child: Text('Login'),
					),
					BlocBuilder<LoginCubit, LoginState>(
						builder: (context, state) {
							if (state is LoginFailure) {
								return Text(
									state.error,
									style: TextStyle(color: Colors.red),
								);
							}
							return Container();
						},
					),
				],
			),
		);
	}
}
