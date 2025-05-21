class EventDateModel {
  final int id;
  final DateTime dateTime;

  EventDateModel({
    required this.id,
    required this.dateTime,
  });

  factory EventDateModel.fromJson(Map<String, dynamic> json) {
    final iri = json['@id'] as String;
    final id = int.parse(iri.split('/').last);

    return EventDateModel(
      id: id,
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}



