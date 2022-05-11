import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';

import 'package:walak/core/theme/theme.dart';
import 'package:walak/modules/profile/ui/profile_page.dart';

class MainPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MainPage());
  }

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentTab = 0;

  Widget getPage(int index) {
    switch (index) {
      case 2:
        return const ProfilePage();
      default:
        return Center(
          child: Text('Page $index'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(currentTab),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        unselectedItemColor: WColors.secondaryVariant,
        currentIndex: currentTab,
        onTap: (index) {
          setState(() {
            currentTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.wallet),
            label: 'MLC 24hs',
          ),
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.dollar_alt),
            label: 'Pagos',
          ),
          BottomNavigationBarItem(
            icon: Icon(UniconsLine.user_circle),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
