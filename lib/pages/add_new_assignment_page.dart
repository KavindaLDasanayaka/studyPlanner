import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:studyplanner/models/assignment_model.dart';
import 'package:studyplanner/models/course_model.dart';
import 'package:studyplanner/router/route_names.dart';
import 'package:studyplanner/services/assignment_service.dart';
import 'package:studyplanner/utils/util_functions.dart';
import 'package:studyplanner/widgets/custom_button_widget.dart';
import 'package:studyplanner/widgets/custom_input_widget.dart';

class AddNewAssignmentPage extends StatelessWidget {
  final Course course;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _assignmentNameController =
      TextEditingController();
  final TextEditingController _assignmentDescriptionController =
      TextEditingController();
  final TextEditingController _assignmentDurationController =
      TextEditingController();

  final ValueNotifier<DateTime> _selectDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );
  final ValueNotifier<TimeOfDay> _selectTime = ValueNotifier<TimeOfDay>(
    TimeOfDay.now(),
  );

  //intialize value notifiers
  AddNewAssignmentPage({super.key, required this.course}) {
    _selectDate.value = DateTime.now();
    _selectTime.value = TimeOfDay.now();
  }

  //date picker
  Future<void> _selectDateMethod(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectDate.value,
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != _selectDate.value) {
      _selectDate.value = picked;
    }
  }

  //time picker
  Future<void> _selectTimeMethod(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectTime.value,
    );
    if (picked != null && picked != _selectTime.value) {
      _selectTime.value = picked;
    }
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final Assignment assignment = Assignment(
          id: "",
          name: _assignmentNameController.text,
          description: _assignmentDescriptionController.text,
          duration: _assignmentDurationController.text,
          dueDate: _selectDate.value,
          dueTime: _selectTime.value,
        );
        AssignmentService().createAssignment(course.id, assignment);
        showSnackBar(
          context: context,
          message: "Assignment created Successfully",
        );
        await Future.delayed(Duration(seconds: 2));
        (context).goNamed(RouteNames.mainPage);
      } catch (err) {
        print("add new assignment failed: $err");
        showSnackBar(context: context, message: "Failed to add assignmrnt!");
      }
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
                  'Add New Assignment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),

                //description
                const Text(
                  'Fill in the details below to add a new assignment. And start managing your study planner.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
                CustomInputWidget(
                  controller: _assignmentNameController,
                  labelText: 'Assignment Name',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the assignment name';
                    }
                    return null;
                  },
                ),
                CustomInputWidget(
                  controller: _assignmentDescriptionController,
                  labelText: 'Assignment Description',
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter the assignment description';
                    }
                    return null;
                  },
                ),
                CustomInputWidget(
                  controller: _assignmentDurationController,
                  labelText: "Duration (e.g., 1 hour)",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter duration";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const Divider(),
                const Text(
                  'Due Date and Time',
                  style: TextStyle(fontSize: 16, color: Colors.white60),
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<DateTime>(
                  valueListenable: _selectDate,
                  builder: (context, date, child) {
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Date : ${date.toLocal().toString().split(" ")[0]}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _selectDateMethod(context),
                          icon: Icon(Icons.calendar_today),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 5),
                ValueListenableBuilder(
                  valueListenable: _selectTime,
                  builder: (context, time, child) {
                    return Row(
                      children: [
                        Expanded(child: Text("Time : ${time.format(context)}")),
                        IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () => _selectTimeMethod(context),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                CustomButtonWidget(
                  buttonText: 'Add Assignment',
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
