// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:routemaster/routemaster.dart';

import '../core/utils/utils/responsive.dart';
import '../presentation/side_menu/side_menu.dart';



class PageScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final String? searchQuery;

  const PageScaffold({
    super.key,
    required this.title,
    required this.body,
    this.searchQuery,
  });

  @override
  _PageScaffoldState createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  final TextEditingController _searchController = TextEditingController();
  String _version = 'Loading...';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _updateSearchQuery();
    _getVersion();
  }

  @override
  void didUpdateWidget(covariant PageScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateSearchQuery();
  }

  void _updateSearchQuery() {
    if (widget.searchQuery != null) {
      _searchController.text = widget.searchQuery!;
    }
  }

  Future<void> _getVersion() async {
    try {
      final PackageInfo info = await PackageInfo.fromPlatform();
      setState(() {
        _version = info.version;
      });
    } catch (e) {
      setState(() {
        _version = 'Failed to load version';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Routemaster.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = !(kIsWeb && Responsive.isDesktop(context));

      return Scaffold(
        drawer: isMobile
            ? const Drawer(
          child: SideMenu(inDrawer: true),
        )
            : null,
        appBar: AppBar(
          elevation: 3,
          scrolledUnderElevation: 0,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          automaticallyImplyLeading: isMobile,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Version:$_version',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'LamaSans',
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (!isMobile)
                    const Expanded(
                      flex: 2,
                      child: SideMenu(inDrawer: false),
                    ),
                  Expanded(
                    flex: 8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: widget.body,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class NavigationLink extends StatelessWidget {
  final String title;
  final String path;
  final bool? inDrawer;

  const NavigationLink({
    super.key,
    required this.title,
    required this.path,
    required this.inDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final currentPath = RouteData.of(context).fullPath;
    final isCurrent = currentPath == path;

    return Container(
      color: isCurrent ? Theme.of(context).highlightColor : Colors.transparent,
      child: ListTile(
        onTap: isCurrent
            ? null
            : () {
          if (inDrawer == true) {
            Navigator.pop(context);
          }
          Routemaster.of(context).push(path);
        },
        title: Text(
          title,
          style: TextStyle(
            color: isCurrent
                ? Theme.of(context).textTheme.bodyLarge?.color
                : Theme.of(context).textTheme.bodyMedium?.color,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
