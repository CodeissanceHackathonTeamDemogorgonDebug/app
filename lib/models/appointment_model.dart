class Appointment {
  final String patientuid;
  final String doctoruid;
  final DateTime date;
  final bool isAccepted;
  final DateTime? time;
  final String? fcmToken;
  final String appointmentType;
  Appointment(
      {required this.patientuid,
      required this.doctoruid,
      required this.date,
      required this.isAccepted,
        required this.appointmentType,
      this.time,
      this.fcmToken});
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      patientuid: map['patientuid'] ?? '',
      doctoruid: map['doctoruid'] ?? '',
      date: map['date'].toDate(),
      isAccepted: map['isAccepted'] ?? false,
      fcmToken: map['fcmToken'],
      time: map['time']?.toDate(),
      appointmentType: map['appointmentType'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'patientuid': patientuid,
      'doctoruid': doctoruid,
      'date': date,
      'isAccepted': isAccepted,
      'fcmToken': fcmToken,
      'time': time,
      'appointmentType': appointmentType,
    };
  }
}