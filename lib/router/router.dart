import 'package:go_router/go_router.dart';
import 'package:studyplanner/pages/add_new_course.dart';
import 'package:studyplanner/pages/error_page.dart';
import 'package:studyplanner/pages/main_page.dart';
import 'package:studyplanner/router/route_names.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
        path: "/",
        name: RouteNames.mainPage,
        builder: (context, state) {
          return MainPage();
        },
      ),
      GoRoute(
        path: "/addNewCourse",
        name: RouteNames.addNewCourse,
        builder: (context, state) {
          return AddNewCourse();
        },
      ),
    ],
  );
}
