class Question {
  String id;
  String name;
  String description;
  String systemId;
  String criterionId;
  String subCriterionId;

  Question({
    required this.id,
    required this.name,
    required this.description,
    required this.systemId,
    required this.criterionId,
    required this.subCriterionId,
  });

  Question.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      name = map['name'],
      description = map['description'],
      systemId = map['systemId'],
      criterionId = map['criterionId'],
      subCriterionId = map['subCriterionId'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'systemId': systemId,
      'criterionId': criterionId,
      'subCriterionId': subCriterionId,
    };
  }
}
