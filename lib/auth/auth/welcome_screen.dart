import 'package:flutter/material.dart';
import 'package:graduation_yamen_afmin/auth/auth/sign_in_screen.dart';
import 'package:graduation_yamen_afmin/core/widgets/custom_image_view.dart';

import '../../core/utils/utils/constant_colors.dart';





class WelcomeScreen extends StatefulWidget {

	const WelcomeScreen({
		super.key,
	});

	@override
	State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
	late TabController tabController;
	bool isDarkMode = false;

	@override
	void initState() {
		tabController = TabController(
			initialIndex: 0,
			length: 2,
			vsync: this,
		);
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		isDarkMode = Theme.of(context).brightness == Brightness.dark;

		return Scaffold(
			body: Container(
				decoration: const BoxDecoration(
					gradient: LinearGradient(
						colors: [
							Color(0xFF94C3DD),
							Color(0xFF23245D),
							Color(0xFF7FAAD2),
							Color(0xFF1C114D),
							Color(0xFFF4F1EA),
						],
						begin: Alignment.topLeft,
						end: Alignment.bottomRight,
					),
				),
				child: LayoutBuilder(
					builder: (context, constraints) {
						if (constraints.maxWidth > 800) {
							// Web Layout
							return Row(
								children: [
									Expanded(
										flex: 2,
										child: Center(
											child: Container(
												color: secondaryColor.withOpacity(0.5),
												child: const Padding(
													padding: EdgeInsets.all(20.0),
													child: Column(
														mainAxisAlignment: MainAxisAlignment.center,
														children: [
															SignInScreen(),
														],
													),
												),
											),
										),
									),
									Expanded(
										flex: 3,
										child: CustomImageView(
										imagePath: 	'assets/images/background.webp',
											fit: BoxFit.cover,
											height: 2000,
										),
									),
								],
							);
						} else {
							// Mobile Layout
							return SizedBox(
								width: constraints.maxWidth,
								height: constraints.maxHeight,
								child: const Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										Column(
											mainAxisAlignment: MainAxisAlignment.center,
											children: [
												SignInScreen(
												),
											],
										),
									],
								),
							);
						}
					},
				),
			),
		);
	}
}
