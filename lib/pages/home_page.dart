/*
 * Created by Archer on 2022/12/10.
 * Copyright © 2022 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:levir/levir.dart';
import 'package:shrine_platform/viewmodels/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with ViewModelProviderStateMixin<HomePage, HomePageViewModel> {
  @override
  HomePageViewModel createViewModel() => HomePageViewModel();

  int _navigationIndex = 0;

  void _rebuild(int index) {
    setState(() {
      _navigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}

extension on _HomePageState {
  Widget _build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 227, 241),
      body: SafeArea(
        child: AdaptiveLayout(
          internalAnimations: false,
          primaryNavigation: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.standard: SlotLayout.from(
                key: const Key('primaryNavigation'),
                builder: (_) {
                  return AdaptiveScaffold.standardNavigationRail(
                    onDestinationSelected: _rebuild,
                    selectedIndex: _navigationIndex,
                    leading: const _MediumHeader(),
                    backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                    destinations: destinations(),
                  );
                },
              ),
              Breakpoints.large: SlotLayout.from(
                key: const Key('Large primaryNavigation'),
                builder: (_) => AdaptiveScaffold.standardNavigationRail(
                  extended: true,
                  leading: const _LargeHeader(),
                  onDestinationSelected: _rebuild,
                  selectedIndex: _navigationIndex,
                  destinations: destinations(),
                ),
              ),
            },
          ),
          body: SlotLayout(
            config: <Breakpoint, SlotLayoutConfig?>{
              Breakpoints.standard: SlotLayout.from(
                key: const Key('body'),
                inAnimation: null,
                outAnimation: null,
                builder: (_) => Container(
                  color:
                      _navigationIndex > 0 ? Colors.orange : Colors.lightBlue,
                ),
              ),
            },
          ),
        ),
      ),
    );
  }

  List<NavigationRailDestination> destinations() {
    return <NavigationDestination>[
      const NavigationDestination(
        label: '商品发布',
        icon: Icon(Icons.inbox),
      ),
      const NavigationDestination(
        label: '订单管理',
        icon: Icon(Icons.article_outlined),
      )
    ].map((_) {
      return AdaptiveScaffold.toRailDestination(_);
    }).toList();
  }
}

class _MediumHeader extends StatelessWidget {
  const _MediumHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 254, 215, 227),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      width: 50,
      height: 50,
      child: const Icon(Icons.edit_outlined),
    );
  }
}

class _LargeHeader extends StatelessWidget {
  const _LargeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      const SizedBox(height: 10),
      Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 225, 231),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        width: 200,
        height: 50,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 20),
            Text('Shrine'),
          ],
        ),
      )
    ]);
  }
}
