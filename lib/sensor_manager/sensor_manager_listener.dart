import 'dart:ffi';

typedef LightSensorLevel = void Function(Float);

class SensorManagerEventsListener {
  LightSensorLevel? lightSensorLevel;

  SensorManagerEventsListener({
    this.lightSensorLevel,
  });
}
