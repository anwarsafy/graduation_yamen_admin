import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routemaster/routemaster.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../auth/blocs/authentication_bloc/authentication_bloc.dart';




class SideMenu extends StatefulWidget {
  const SideMenu({super.key, this.inDrawer});

  final bool? inDrawer;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> with AutomaticKeepAliveClientMixin {
  late Map<String, bool> expandedTiles;

  @override
  void initState() {
    super.initState();
    expandedTiles = {
      'Articles': false,
      'Job': false,
      'News': false,
      'Store': false,
      'Multimedia': false,
      'Journals': false,
      'settings': false,
      'popup': false,
    };
  }

  void _initializeExpandedState() {
    final fullPath = RouteData.of(context).fullPath.split("/");
    setState(() {
      expandedTiles['Articles'] = fullPath.contains("Articles");
      expandedTiles['Job'] = fullPath.contains("Job");
      expandedTiles['News'] = fullPath.contains("News");
      expandedTiles['Store'] = fullPath.contains("Store");
      expandedTiles['Multimedia'] = fullPath.contains("Multimedia");
      expandedTiles['Journals'] = fullPath.contains("Journals");
      expandedTiles['settings'] = fullPath.contains("settings");
      expandedTiles['popup'] = fullPath.contains("popup");
      expandedTiles['Services'] = fullPath.contains("Services");
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeExpandedState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Material(
      elevation: 1,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildUserEmailTile(isDarkMode),
            Divider(color: Theme.of(context).dividerColor),
            ..._buildNavigationLinks(isDarkMode),
            Divider(color: Theme.of(context).dividerColor),
            _buildLogoutTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserEmailTile(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 40,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white : Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '${FirebaseAuth.instance.currentUser?.email}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isDarkMode ? Colors.black : Colors.white,fontFamily: 'LamaSans'
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNavigationLinks(bool isDarkMode) {
    return [

      NavigationLink(
        title: 'Student'.tr(),
        path: '/students',
        inDrawer: widget.inDrawer,
      ),
      NavigationLink(
        title: 'Teacher'.tr(),
        path: '/teachers',
        inDrawer: widget.inDrawer,
      ),
      NavigationLink(
        title: 'Parents'.tr(),
        path: '/parents',
        inDrawer: widget.inDrawer,
      ),
      NavigationLink(
        title: 'Attendance'.tr(),
        path: '/attendance',
        inDrawer: widget.inDrawer,
      ),
      NavigationLink(
        title: 'Notes'.tr(),
        path: '/notes',
        inDrawer: widget.inDrawer,
      ),
      NavigationLink(
        title: 'Tasks'.tr(),
        path: '/tasks',
        inDrawer: widget.inDrawer,
      ),

    ];
  }





  Widget _buildLogoutTile() {
    return DrawerListTile(
      title: 'Log Out'.tr(),
      svgSrc: "assets/icons/logout.png",
      press: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Log Out'.tr(),style: const TextStyle(
                  fontFamily: 'LamaSans'
              ),),
              content: const Text('Are you sure you want to log out?',
                style: TextStyle(
                  fontFamily: 'LamaSans'
              ),),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'.tr(),style: const TextStyle(
                    fontFamily: 'LamaSans'
                  ),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('yes'.tr(),style: const TextStyle(
                    fontFamily: 'LamaSans'
                  ),),
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
                    Navigator.of(context).pop();

                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    required this.title,
    required this.svgSrc,
    required this.press,
  });

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        svgSrc,
        height: 16,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
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
          if (kDebugMode) {
            debugPrint("=====> $currentPath");
          }
          Routemaster.of(context).push(path);
        },
        title: Text(
          title,
          style: TextStyle(
            color: isCurrent ? Theme.of(context).textTheme.bodyLarge!.color : Theme.of(context).textTheme.bodyMedium!.color,
            fontSize: 14,
            fontFamily: 'LamaSans'
          ),
        ),
      ),
    );
  }
}

