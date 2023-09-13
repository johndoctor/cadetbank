import 'package:cadetbank/src/core/widgets/cadet_bank_app_bar.dart';
import 'package:cadetbank/src/core/widgets/info_table.dart';
import 'package:cadetbank/src/features/app/app_state.dart';
import 'package:cadetbank/src/features/profile/widgets/create_username_prompt.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CadetBankAppBar.pushStyle(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Selector<AppState, bool>(
            selector: (context, appState) => appState.user?.username != null,
            builder: (context, isUsernameAvailable, _) {
              return Column(
                children: [
                  if (!isUsernameAvailable)
                    const CreateUsernamePrompt(),
                  const SizedBox(height: 16),
                  InfoTable(
                    tableData: <String, String>{
                      "Email": context.watch<AppState>().user?.email ?? "N/A",
                      "Account Type": context.watch<AppState>().user?.accountType ?? "N/A",
                      "Phone number": context.watch<AppState>().user?.phone ?? "N/A",
                      if (isUsernameAvailable)
                        "Username": context.watch<AppState>().user!.username!
                    }
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
