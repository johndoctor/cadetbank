import 'package:cadetbank/src/core/styling/colors.dart';
import 'package:cadetbank/src/core/widgets/cadet_bank_app_bar.dart';
import 'package:cadetbank/src/core/widgets/loading_overlay.dart';
import 'package:cadetbank/src/features/app/app_state.dart';
import 'package:cadetbank/src/features/login/login_provider.dart';
import 'package:cadetbank/src/network/users/models/user_details.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

/*
- reading and listening to a value (https://pub.dev/packages/provider#reading-a-value)
  - context.watch<T>(), which makes the widget listen to changes on T
    - Provider.of(context, listen: true)
  - context.read<T>(), which returns T without listening to it
    - Provider.of(context, listen: false)
  - context.select<T, R>(R cb(T value)), which allows a widget to listen to only a small part of T.
- Compare between context.select and context.watch and Consumer
- Selector
*/

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
        create: (context) => LoginProvider()..validate(),
        builder: (context, _) {
          return LoadingOverlay(
            isLoading: context.watch<LoginProvider>().isLoading,
            // isLoading: Provider.of<LoginProvider>(context, listen: true).isLoading,
            child: Scaffold(
              appBar: CadetBankAppBar.empty(),
              body: KeyboardDismissOnTap(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(48),
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Log in",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                            onChanged:
                                context.read<LoginProvider>().onEmailChanged,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: "Enter your email",
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.w600),
                            onChanged:
                                context.read<LoginProvider>().onPasswordChanged,
                            decoration: const InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                            ),
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium!,
                              children: [
                                const TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                    text: "Register now",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color:
                                                CustomColors.primaryGreenColor,
                                            fontWeight: FontWeight.w600),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                "/register/email");
                                      })
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: context.watch<LoginProvider>().canProceed
                                ? () async {
                                    // Dismiss keyboard
                                    FocusScope.of(context).unfocus();

                                    // // Call log in API
                                    // final res = await context
                                    //   .read<LoginProvider>()
                                    //   .login();

                                    // if (res != null) {
                                    //   // update current user
                                    //   context.read<AppState>().updateCurrentUser(UserDetails.mock());

                                    //   // Push to home screen
                                    //   Navigator.of(context).pushReplacementNamed("/home");
                                    // }

                                    // Mock log in for now
                                    context
                                        .read<AppState>()
                                        .updateCurrentUser(UserDetails.mock());

                                    // Push to home screen
                                    Navigator.of(context)
                                        .pushReplacementNamed("/home");
                                  }
                                : null,
                            child: const Text("Log in"),
                          ),
                          Text(context.watch<LoginProvider>().error ?? "")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
