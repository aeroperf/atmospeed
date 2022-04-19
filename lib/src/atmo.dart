import 'dart:math';

import 'package:atmospeed/src/constants.dart';
import 'package:atmospeed/src/enums.dart';
import 'package:atmospeed/src/ratio.dart';
import 'package:atmospeed/src/temperature.dart';

import 'convert.dart';

/// Atmospheric point class
///
/// Defines a point in the atmosphere for a known pressure altitude [hp] and
/// temperature condition [temperature].
class Atmo {
  /// Pressure altitude for this atmosphere point; unit defaults to feet and
  /// can be set with [unitAltitude].
  final double hp;

  /// Temperature value for this atmosphere point; defaults to a delta ISA
  /// temperature deviation from standard atmosphere, but can be set to and
  /// outside air temperature (OAT) by setting [temperatureIsDeltaISA] to
  /// `true`. Default unit is Celsius, but can be set with [unitTemperature].
  final double temperature;

  /// Boolean to set if [temperature] input is delta ISA (when set to `true`,
  /// default) or OAT (when set to `false`).
  final bool temperatureIsDeltaISA;

  /// Pressure altitude unit; defaults to feet if not specified.
  final LengthUnit unitAltitude;

  /// Temperature input unit; defaults to Celsius if not specified.
  final TemperatureUnit unitTemperature;

  double _dISA = 0;
  double _hp = 0;

  /// Atmospheric point constructor
  ///
  /// Defines a point in the atmosphere for a known pressure altitude [hp] and
  /// temperature condition [temperature]. [temperature] **defaults to delta
  /// ISA temperature**, not Outside Air Temperature (OAT).
  ///
  /// Set [temperatureIsDeltaISA] to `false` if OAT input is desired.
  /// [temperatureIsDeltaISA] defaults to `true` and a delta ISA [temperature]
  /// input.
  ///
  /// Default units for [hp] and [temperature] are feet and Celsius,
  /// respectively, but can be changed to any [LengthUnit] with the name
  /// parameter [unitAltitude], or to any [TemperatureUnit] with the named
  /// parameter [unitTemperature].
  ///
  Atmo(
      {required this.hp,
      required this.temperature,
      this.temperatureIsDeltaISA = true,
      this.unitAltitude = LengthUnit.ft,
      this.unitTemperature = TemperatureUnit.C}) {
    // Ensure hp input is below stratopause and use value in feet for class
    // methods.
    _hp = Convert.lengthToFeet(hp, unitAltitude);
    if (_hp > heightStratopauseFt) {
      throw RangeError('Altitude is above stratopause');
    }

    // Calculate delta ISA as we use that internally with class methods.
    _dISA = temperatureIsDeltaISA
        ? temperature
        : Temperature().deltaIsa(hp, temperature,
            unitAltitude: unitAltitude, unitTemperature: unitTemperature);
  }

  @override
  String toString() =>
      """Hp: $hp $unitAltitude Temperature: $temperature $unitTemperature 
      Is Delta ISA: $temperatureIsDeltaISA""";

  /// Get temperature ratio Theta for this atmosphere point.
  double getTheta() => Ratio().theta(hp,
      deltaISA: _dISA,
      unitAltitude: unitAltitude,
      unitTemperature: unitTemperature);

  /// Get pressure ratio Delta for this atmosphere point.
  double getDelta() => Ratio().delta(hp, unitAltitude: unitAltitude);

  /// Get density ratio Sigma for this atmosphere point.
  double getSigma() => Ratio().sigma(hp,
      deltaISA: _dISA,
      unitAltitude: unitAltitude,
      unitTemperature: unitTemperature);

  /// Get outside air temperature for this atmosphere point; unit is same as
  /// Atmo point input unit.
  double getOAT() => Temperature().oat(hp, _dISA,
      unitAltitude: unitAltitude, unitTemperature: unitTemperature);

  /// Get delta ISA value for this atmosphere point; unit is same as Atmo point
  /// input unit.
  double getDeltaISA() => _dISA;

  /// Get ISA temperature for this atmosphere point; unit is same as Atmo point
  /// input unit.
  double getISA() => Temperature()
      .isa(hp, unitAltitude: unitAltitude, unitTemperature: unitTemperature);

  /// Get pressure altitude in feet.
  double getHpInFeet() => _hp;

  /// Get speed of sound as this atmosphere point; unit defaults to knots, but
  /// can be changed using [unitSpeedOutput].
  double getSpeedOfSound({SpeedUnit unitSpeedOutput = SpeedUnit.kts}) =>
      _speedOfSound(hp, _dISA,
          unitSpeedOutput: unitSpeedOutput,
          unitAltitude: unitAltitude,
          unitTemperature: unitTemperature);
}

/// Calculates speed of sound for a pressure altitude and delta ISA in knots.
///
/// [hp] is the pressure altitude at which to calculate speed of sound for,
/// defaults to feet.
///
/// [deltaISA] is the temperature deviation from standard at hp for which to
/// calculate speed of sound for, defaults to Celsius.
///
/// [unitSpeedOutput] is the desired unit to return the speed of sound in;
/// defaults to knots, and other options include ft/s, m/s, km/h, and mph.
///
/// [unitAltitude] is the input altitude unit; defaults to feet.
///
/// [unitTemperature] is the input temperature unit; defaults to Celsius.
double _speedOfSound(double hp, double deltaISA,
    {SpeedUnit unitSpeedOutput = SpeedUnit.kts,
    LengthUnit unitAltitude = LengthUnit.ft,
    TemperatureUnit unitTemperature = TemperatureUnit.C}) {
  double speedSLStdDay;
  switch (unitSpeedOutput) {
    case SpeedUnit.kts:
      speedSLStdDay = speedOfSoundSlStdDayKnots;
      break;
    case SpeedUnit.fps:
      speedSLStdDay = speedOfSoundSlStdDayFeetPerSecond;
      break;
    case SpeedUnit.mph:
      speedSLStdDay = speedOfSoundSlStdDayStatuteMilesPerHour;
      break;
    case SpeedUnit.mps:
      speedSLStdDay = speedOfSoundSlStdDayMetersPerSecond;
      break;
    case SpeedUnit.kmh:
      speedSLStdDay = speedOfSoundSlStdDayKilometersPerHour;
      break;
  }
  return speedSLStdDay *
      sqrt(Ratio().theta(hp,
          deltaISA: deltaISA,
          unitAltitude: unitAltitude,
          unitTemperature: unitTemperature));
}
