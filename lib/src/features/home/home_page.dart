import 'package:cadetbank/src/core/styling/colors.dart';
import 'package:cadetbank/src/core/widgets/cadet_bank_app_bar.dart';
import 'package:cadetbank/src/core/widgets/cadet_tab_bar.dart';
import 'package:cadetbank/src/features/app/app_state.dart';
import 'package:cadetbank/src/features/home/widgets/user_avatar_app_bar_leading.dart';
import 'package:cadetbank/src/features/home/widgets/username_app_bar_leading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final List<String> products;

  const HomePage({super.key}) 
    : products = const ["Saving", "Wallet", "Loans", "Invest", "Credit"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CadetBankAppBar.custom(
        leading: Selector<AppState, String?>(
          selector: (context, appState) => appState.user?.username,
          builder: (context, username, _) => username != null
            ? UsernameAppBarLeading(username: username)
            : const UserAvatarAppBarLeading()
        ),
      ),
      body: SafeArea(
        child: CadetTabBar(
          itemCount: products.length,
          tabBarTextBuilder: (ctx, idx) => products[idx],
          tabBarViewBuilder: (ctx, idx) => RefreshIndicator(
            color: CustomColors.pink,
            onRefresh: () async {
              // Do something here later
            },
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemBuilder: (ctx, _idx) => const Text("Under construction"),
                  separatorBuilder: (ctx, _) => const SizedBox(height: 16),
                  itemCount: 1
                );
              }
            ),
          )
        ),
      ),
    );
  }
}
