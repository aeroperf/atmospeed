import 'dart:math';

import 'convert.dart';
import 'enums.dart';
import 'constants.dart';

/// Altitude class for altitiude specific calculations
class Altitude {
  /// Calculate pressure altitude from airport elevation and QNH (airport
  /// altimeter).
  ///
  /// [airportElevation] is the airport's elevation. Defaults to feet if no
  /// length unit is provided.
  ///
  /// [airportAltimeter] is the airport's altimer setting (QNH). Defaults to
  /// inches Mercury (inHg) if no pressure unit is provided.
  ///
  static double pressureAltitude(
      {required double airportElevation,
      required double airportAltimeter,
      LengthUnit unitElevation = LengthUnit.ft,
      PressureUnit unitAltimeter = PressureUnit.inHg}) {
    // Ensure altitude is in feet (we will do internal calculation in feet).
    airportElevation = Convert.lengthToFeet(airportElevation, unitElevation);

    // Get standard SL pressure based on desired pressure unit, calculate
    // pressure altitude hp.
    var pressureSLStd = (unitAltimeter == PressureUnit.inHg)
        ? pressureSlStdDayInchesHg
        : pressureSlStdDayHectoPascal;
    var hp = airportElevation +
        pressureCalcConstant *
            (1 - pow((airportAltimeter / pressureSLStd), pressureCalcExponent));

    // If non-feet unit was requested, convert hp (currently in feet) back to
    // same unit elevation was provided in.
    return (unitElevation == LengthUnit.ft)
        ? hp
        : Convert.length(hp, LengthUnit.ft, unitElevation);
  }
}
