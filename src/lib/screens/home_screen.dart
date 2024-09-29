
import 'package:flutter/material.dart';
import 'package:com.example.flutter_cubit_app/cubits/home_cubit.dart';

class HomeScreen extends StatelessWidget {
	final HomeCubit cubit;

	HomeScreen({Key? key, required this.cubit}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Home'),
			),
			body: Center(
				child: ElevatedButton(
					onPressed: () {
						cubit.logout();
					},
					child: Text('Logout'),
				),
			),
		);
	}
}
