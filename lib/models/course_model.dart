class Course {
  final String id;
  final String name;
  final String description;
  final String duration;
  final String schedule;
  final String instructor;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.schedule,
    required this.instructor,
  });

  //from json
  factory Course.fromJson(Map<String, dynamic> json, String id) {
    return Course(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      duration: json["duration"] ?? "",
      schedule: json["schedule"] ?? "",
      instructor: json["instructor"] ?? "",
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "duration": duration,
      "schedule": schedule,
      "instructor": instructor,
    };
  }
}
