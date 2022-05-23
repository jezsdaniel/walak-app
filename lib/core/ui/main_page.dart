import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../modules/mlc24/ui/mlc24_page.dart';
import '../theme/theme.dart';
import '../../modules/payments/ui/payments_page.dart';
import '../../modules/profile/ui/profile_page.dart';
import '../../modules/source/bloc/source_bloc.dart';

class MainPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MainPage());
  }

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    context.read<SourceBloc>().add(SourceEventGetBalance());
    context.read<SourceBloc>().add(SourceEventGetPaymentMethods());
    timer = Timer.periodic(const Duration(minutes: 2), (_) {
      context.read<SourceBloc>().add(SourceEventGetBalance());
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int currentTab = 0;

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return const MLC24Page();
      case 1:
        return const PaymentsPage();
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
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: currentTab,
        onDestinationSelected: (index) {
          setState(() {
            currentTab = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(UniconsLine.wallet),
            label: 'MLC 24hs',
          ),
          NavigationDestination(
            icon: Icon(UniconsLine.dollar_alt),
            label: 'Pagos',
          ),
          NavigationDestination(
            icon: Icon(UniconsLine.user_circle),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
