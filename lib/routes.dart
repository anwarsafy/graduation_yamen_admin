

import 'package:flutter/material.dart';
import 'package:graduation_yamen_afmin/presentation/parents/view/parent_screen.dart';
import 'package:graduation_yamen_afmin/presentation/students/view/student_screen.dart';
import 'package:graduation_yamen_afmin/presentation/teacher/view/teacher_screen.dart';
import 'package:routemaster/routemaster.dart';

import 'controllers/main_screen_scaffold.dart';


checkAuthority() {
  return getRoutesAdmin();
}

getRoutesAdmin() {
  Map<String, RouteSettings Function(RouteData)> adminRoutes = {

    '/students': (route) =>    const NoAnimationPage(
        child: PageScaffold(
            body: StudentListScreen(),
            title: "Users")),
    '/teachers': (route) =>    const NoAnimationPage(
        child: PageScaffold(
            body: TeacherListScreen(),
            title: "Teachers")),
    '/parents': (route) =>    const NoAnimationPage(
        child: PageScaffold(
            body: ParentListScreen(),
            title: "Parents")),







  };
  return adminRoutes;
}

class NoAnimationPage<T> extends TransitionPage<T> {
  const NoAnimationPage({required super.child})
      : super(
    pushTransition: PageTransition.none,
    popTransition: PageTransition.none,
  );
}
