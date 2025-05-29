import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studyplanner/models/course_model.dart';
import 'package:studyplanner/widgets/custom_button_widget.dart';
import 'package:studyplanner/widgets/custom_input_widget.dart';

class AddNewNotePage extends StatefulWidget {
  final Course course;
  const AddNewNotePage({super.key, required this.course});

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _sectionController = TextEditingController();

  final TextEditingController _referencesController = TextEditingController();

  //image picker
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  //method to pick image from gallery
  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _selectedImage = image;
    });
  }
  //Form validations

  //submit form
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      print(_titleController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Note For Your Course',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),

              //description
              const Text(
                'Fill in the details below to add a new note. And start managing your study planner.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputWidget(
                      controller: _titleController,
                      labelText: "note Title",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter a title";
                        }
                        return null;
                      },
                    ),
                    CustomInputWidget(
                      controller: _descriptionController,
                      labelText: "Note Description",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter a description";
                        }
                        return null;
                      },
                    ),
                    CustomInputWidget(
                      controller: _sectionController,
                      labelText: "Note Section",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter a note section";
                        }
                        return null;
                      },
                    ),
                    CustomInputWidget(
                      controller: _referencesController,
                      labelText: "Note Reference",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter a note reference book";
                        }
                        return null;
                      },
                    ),
                    const Divider(),
                    const Text(
                      'Upload Note Image , for better understanding and quick revision',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    CustomButtonWidget(
                      buttonText: "Upload Image",
                      onTapFunction: _pickImage,
                    ),
                    const SizedBox(height: 20),
                    _selectedImage != null
                        ? Column(
                            children: [
                              Text("Selected Image:"),
                              Image.file(
                                File(_selectedImage!.path),
                                width: double.infinity,
                                height: 200,
                              ),
                            ],
                          )
                        : const Text("No image selected"),
                    // Button to upload image
                    const SizedBox(height: 20),
                    CustomButtonWidget(
                      buttonText: "Submit Note",
                      onTapFunction: () => _submitForm(context),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
