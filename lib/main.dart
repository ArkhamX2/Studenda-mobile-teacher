import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studenda_mobile/core/common/presentation/bloc/common_bloc.dart';
import 'package:studenda_mobile/feature/auth/presentation/pages/main_auth_widget.dart';
import 'package:studenda_mobile/feature/group_selection/presentation/bloc/main_group_selection_bloc/main_group_selection_bloc.dart';
import 'package:studenda_mobile/feature/group_selection/presentation/pages/guest_group_selector.dart';
import 'package:studenda_mobile/feature/home/presentation/widgets/home_screen_widget.dart';
import 'package:studenda_mobile/feature/journal/presentation/widgets/journal_main_screen_widget.dart';
import 'package:studenda_mobile/feature/navigation/presentation/widgets/main_navigator_widget.dart';
import 'package:studenda_mobile/feature/notification/presentation/widgets/notification_screen_widget.dart';
import 'package:studenda_mobile/feature/schedule/presentation/pages/schedule_screen_widget.dart';
import 'package:studenda_mobile/injection_container.dart' as di;
import 'package:studenda_mobile/injection_container.dart';

void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupSelectorBloc>(
          create: (context) => sl<GroupSelectorBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CommonBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Studenda',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 101, 59, 159),
          ),
          fontFamily: 'Inter',
        ),
        home: const MainNavigatorWidget(),
        routes: {
          '/auth': (context) => const MainAuthPage(),
          '/main_nav': (context) => const MainNavigatorWidget(),
          '/home': (context) => const HomeScreenWidget(),
          '/schedule': (context) => const ScheduleScreenWidget(),
          '/journal': (context) => const JournalMainScreenWidget(),
          '/notification': (context) => const NotificationScreenWidget(),
          '/group_selection': (context) => const GuestGroupSelectorPage(),
        },
        initialRoute: '/group_selection',
      ),
    );
  }
}
