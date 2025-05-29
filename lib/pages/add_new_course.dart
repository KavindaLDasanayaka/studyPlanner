import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studyplanner/models/course_model.dart';
import 'package:studyplanner/router/route_names.dart';
import 'package:studyplanner/router/router.dart';
import 'package:studyplanner/services/course_service.dart';
import 'package:studyplanner/widgets/custom_button_widget.dart';
import 'package:studyplanner/widgets/custom_input_widget.dart';

class AddNewCourse extends StatelessWidget {
  AddNewCourse({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _courseNameController = TextEditingController();

  final TextEditingController _courseDescriptionController =
      TextEditingController();

  final TextEditingController _courseDurationController =
      TextEditingController();

  final TextEditingController _courseScheduleController =
      TextEditingController();

  final TextEditingController _courseInstructorController =
      TextEditingController();
  @override
  void dispose() {
    _courseNameController.dispose();
    _courseDescriptionController.dispose();
    _courseDurationController.dispose();
    _courseInstructorController.dispose();
    _courseScheduleController.dispose();
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    final Course course = Course(
      id: "",
      name: _courseNameController.text,
      description: _courseDescriptionController.text,
      duration: _courseDurationController.text,
      schedule: _courseScheduleController.text,
      instructor: _courseInstructorController.text,
    );

    try {
      await CourseService().addCourse(course);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Course Added Successfully")));

      _courseNameController.clear();
      _courseDescriptionController.clear();
      _courseDurationController.clear();
      _courseInstructorController.clear();
      _courseScheduleController.clear();

      GoRouter.of(context).goNamed(RouteNames.mainPage);
    } catch (err) {
      print("Error ui : $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Course',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),

                //description
                const Text(
                  'Fill in the details below to add a new course.And start managing your study planner.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
                CustomInputWidget(
                  controller: _courseNameController,
                  labelText: "Course Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a course name";
                    }
                    return null;
                  },
                ),

                CustomInputWidget(
                  controller: _courseDescriptionController,
                  labelText: "Course Description",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter a Description";
                    }
                    return null;
                  },
                ),
                CustomInputWidget(
                  controller: _courseDurationController,
                  labelText: 'Course Duration',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course duration';
                    }
                    return null;
                  },
                ),
                CustomInputWidget(
                  controller: _courseScheduleController,
                  labelText: 'Course Schedule',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course schedule';
                    }
                    return null;
                  },
                ),
                CustomInputWidget(
                  controller: _courseInstructorController,
                  labelText: 'Course Instructor',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the course instructor';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomButtonWidget(
                  buttonText: "Add Course",
                  onTapFunction: () => _submitForm(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
