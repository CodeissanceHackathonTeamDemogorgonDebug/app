// Step Count Stream Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';

final stepCountProvider = StreamProvider<StepCount>((ref) {
  return Pedometer.stepCountStream;
});

final pedestrianStatusProvider = StreamProvider<PedestrianStatus>((ref) {
  return Pedometer.pedestrianStatusStream;
});