


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:search_project/river_pod_paged_list_view2.dart';

import 'main.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'riverPodPagedListView2',
          builder: (BuildContext context, GoRouterState state) {
            return const RiverPodPagedListView2();
          },
        ),
      ],
    ),
  ],
);