import 'dart:math';

import 'enums.dart';
import 'constants.dart';
import 'temperature.dart';
import 'convert.dart';

/// Ratio class - calculates atmospheric ratio properties.
class Ratio {
  /// Calculates temperature ratio theta from altitude input and optional delta
  /// ISA.
  ///
  /// [hp] is the pressure altitude at which to calculate theta, defaults to
  /// feet.
  ///
  /// [unitAltitude] is an optional altitude unit input (defaults to feet) for
  /// the input altitude; other options included are meters, nautical mile,
  /// statute mile, kilometer.
  ///
  /// [deltaISA] is the temperature deviation from standard; optional,
  /// defaults to ISA+0.
  ///
  /// [unitTemperature] is an optional temperature unit input for the returned
  /// OAT temperature; defaults to Celsius, other options include Kelvin,
  /// Fahrenheit, and Rankine
  double theta(double hp,
      {LengthUnit unitAltitude = LengthUnit.ft,
      double deltaISA = 0,
      TemperatureUnit unitTemperature = TemperatureUnit.C}) {
    var asTemp = Temperature();

    // Ensure altitude is in feet
    hp = Convert.lengthToFeet(hp, unitAltitude);

    if (hp <= heightStratopauseFt) {
      switch (unitTemperature) {
        case TemperatureUnit.C:
          return (asTemp.oat(hp, deltaISA) + zeroCInKelvin) /
              tempSlStdDayKelvin;
        case TemperatureUnit.F:
          return (asTemp.oat(hp, deltaISA, unitTemperature: unitTemperature) +
                  zeroCInRankine) /
              tempSlStdDayRankine;
        case TemperatureUnit.K:
          return asTemp.oat(hp, deltaISA, unitTemperature: unitTemperature) /
              tempSlStdDayKelvin;
        case TemperatureUnit.R:
          return asTemp.oat(hp, deltaISA, unitTemperature: unitTemperature) /
              tempSlStdDayRankine;
      }
    } else {
      throw RangeError('Altitude is above stratopause');
    }
  }

  /// Calculates pressure ratio delta from altitude input
  ///
  /// [hp] is the pressure altitude at which to calculate delta, defaults to
  /// feet.
  ///
  /// [unitAltitude] is an optional altitude unit input (defaults to feet) for
  /// the input altitude; other options included are meters, nautical mile,
  /// statute mile, kilometer.
  double delta(double hp, {LengthUnit unitAltitude = LengthUnit.ft}) {
    // Ensure altitude is in feet
    hp = Convert.lengthToFeet(hp, unitAltitude);

    if (hp <= heightTropopauseFt) {
      return pow(theta(hp), troposphereDeltaExponent)
          .toDouble(); // Calculate delta using theta at ISA
    } else if (hp <= heightStratopauseFt) {
      return deltaAtTropopause *
          pow(e, ((heightTropopauseFt - hp) / tropopauseConstantUSUnit));
    } else {
      throw RangeError('Altitude is above stratopause');
    }
  }

  /// Calculates density ratio sigma from altitude input and optional delta ISA
  ///
  /// [hp] is the pressure altitude at which to calculate sigma, defaults to
  /// feet.
  ///
  /// [unitAltitude] is an optional altitude unit input (defaults to feet) for
  /// the input altitude; other options included are meters, nautical mile,
  /// statute mile, kilometer
  ///
  /// [deltaISA] is the temperature deviation from standard; optional, defaults
  /// to ISA+0.
  ///
  /// [unitTemperature] is an optional temperature unit input for the returned
  /// OAT temperature; defaults to Celsius, other options include Kelvin,
  /// Fahrenheit, and Rankine
  double sigma(double hp,
          {LengthUnit unitAltitude = LengthUnit.ft,
          double deltaISA = 0,
          TemperatureUnit unitTemperature = TemperatureUnit.C}) =>
      delta(hp, unitAltitude: unitAltitude) /
      theta(hp,
          deltaISA: deltaISA,
          unitAltitude: unitAltitude,
          unitTemperature: unitTemperature);
}
