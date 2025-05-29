import 'package:go_router/go_router.dart';
import 'package:studyplanner/models/course_model.dart';
import 'package:studyplanner/pages/add_new_assignment_page.dart';
import 'package:studyplanner/pages/add_new_course.dart';
import 'package:studyplanner/pages/add_new_note.dart';
import 'package:studyplanner/pages/error_page.dart';
import 'package:studyplanner/pages/main_page.dart';
import 'package:studyplanner/pages/single_course_page.dart';
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
      GoRoute(
        path: "/singleCoursePage",
        name: RouteNames.singleCoursePage,
        builder: (context, state) {
          final Course course = state.extra as Course;
          return SingleCoursePage(course: course);
        },
      ),
      GoRoute(
        path: "/addNewAssignment",
        name: RouteNames.addNewAssignment,
        builder: (context, state) {
          final Course course = state.extra as Course;
          return AddNewAssignmentPage(course: course);
        },
      ),
      GoRoute(
        path: "/addNewNote",
        name: RouteNames.addNewNote,
        builder: (context, state) {
          final Course course = state.extra as Course;
          return AddNewNotePage(course: course);
        },
      ),
    ],
  );
}
