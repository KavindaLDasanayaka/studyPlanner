import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studyplanner/constants/colors.dart';
import 'package:studyplanner/models/course_model.dart';
import 'package:studyplanner/router/route_names.dart';
import 'package:studyplanner/services/course_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Study Planner",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(primaryColor),
                      ),
                      onPressed: () {
                        (context).pushNamed(RouteNames.addNewCourse);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.white),
                          Text(
                            "Add Course",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Your study planner helps you to keep track of your study progress and manage your time effectively.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
                // StreamBuilder to show list of courses
                const Text(
                  'Courses',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Your running subjects',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 10),
                StreamBuilder(
                  stream: CourseService().getTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Error Getting Courses",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text("No Courses Added Yet!"));
                    } else {
                      final List<Course> courses = snapshot.data!;
                      return ListView.builder(
                        itemCount: courses.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Course course = courses[index];
                          return Card(
                            color: lightGreen,

                            child: ListTile(
                              title: Text(
                                course.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                course.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
