import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyplanner/models/assignment_model.dart';

class AssignmentService {
  final CollectionReference _courseCollection = FirebaseFirestore.instance
      .collection("courses");

  //create a new assignment in toa course
  Future<void> createAssignment(String courseId, Assignment assignment) async {
    try {
      final Map<String, dynamic> data = assignment.toJson();

      //assignment collection reference
      final CollectionReference _assignmentCollection = _courseCollection
          .doc(courseId)
          .collection("assignments");

      DocumentReference docref = await _assignmentCollection.add(data);

      await docref.update({"id": docref.id});
      print("Assignment saved");
    } catch (err) {
      print("Create Assignment error: $err");
    }
  }
}
