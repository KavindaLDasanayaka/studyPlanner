import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyplanner/models/course_model.dart';

class CourseService {
  final CollectionReference _courseCollection = FirebaseFirestore.instance
      .collection("courses");

  //method to store courses
  Future<void> addCourse(Course course) async {
    try {
      final Map<String, dynamic> data = course.toJson();

      await _courseCollection.add(data);
    } catch (err) {
      print("Adding course error: $err");
    }
  }

  //get courses
  Stream<List<Course>> getTasks() {
    return _courseCollection.snapshots().map(
      (snapshot) => snapshot.docs
          .map(
            (doc) =>
                Course.fromJson(doc.data() as Map<String, dynamic>, doc.id),
          )
          .toList(),
    );
  }
}
