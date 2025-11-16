import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/collections/presentation/pages/add_collection_page.dart';
import '../../features/collections/presentation/pages/detail_page.dart';
import '../../features/collections/presentation/pages/collectible_detail_page.dart';
import '../../features/collections/presentation/pages/home_page.dart';
import '../../features/collections/presentation/widgets/collections_drawer.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../shell/app_shell_scope.dart';
import 'routes.dart';
import '../../features/collections/domain/entities/collection_models.dart';

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: AppRoute.homePath,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.homePath,
                name: AppRoute.home,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.calendarPath,
                name: AppRoute.calendar,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CalendarPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.profilePath,
                name: AppRoute.profile,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfilePage(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.createCollectionPath,
        name: AppRoute.createCollection,
        builder: (context, state) {
          final extra = state.extra;
          return AddCollectionPage(
            initialCollection:
                extra is CollectionEntity ? extra : null,
          );
        },
      ),
      GoRoute(
        path: AppRoute.detailPath,
        name: AppRoute.detail,
        builder: (context, state) {
          final rawId = state.pathParameters['id'] ?? '0';
          final id = int.tryParse(rawId) ?? 0;
          return CollectionDetailPage(collectionId: id);
        },
      ),
      GoRoute(
        path: AppRoute.collectibleDetailPath,
        name: AppRoute.collectibleDetail,
        builder: (context, state) {
          final rawId = state.pathParameters['id'] ?? '0';
          final id = int.tryParse(rawId) ?? 0;
          return CollectibleDetailPage(collectibleId: id);
        },
      ),
    ],
  );
}

/// Shell 层：负责底部导航与内容切换
class AppShell extends StatelessWidget {
  AppShell({super.key, required this.navigationShell})
      : _scaffoldKey = GlobalKey<ScaffoldState>();

  final StatefulNavigationShell navigationShell;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShellScope(
      openDrawer: () => _scaffoldKey.currentState?.openDrawer(),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const CollectionsDrawer(),
        body: navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: '日历',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '我的',
            ),
          ],
        ),
      ),
    );
  }
}
