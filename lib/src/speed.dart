import 'atmo.dart';
import 'speed_conversion.dart';

import 'convert.dart';
import 'enums.dart';

/// Speed properties and conversion class
///
/// Defines a speed point with a speed [value] and [type]. The unit of the speed
/// is set with [unitSpeed] and defaults to knots.
class Speed {
  final double value;
  final SpeedType type;
  final SpeedUnit unitSpeed;

  double _speedInKnots = 0;

  /// Speed class
  ///
  /// Defines a speed [value] and [type], where [type] is one of four options:
  /// Equivalent (EAS), Calibrated (CAS), True (TAS) airspeeds, or Mach.
  ///
  /// The default speed input unit it knots, but other units such as ft/s, m/s,
  /// mph or km/h can be set using [unitSpeed]. A Mach input ignores the unit
  /// setting.
  ///
  /// **NOTE:** When converting a Speed condition to other speeds using the
  /// Speed class methods, the output speed unit (if not a Mach output) is the
  /// same unit at the input speed is defined in. If a Mach input is set and
  /// no [unitSpeed] is defined, output speeds are in knots.
  Speed(
      {required this.value,
      required this.type,
      this.unitSpeed = SpeedUnit.kts}) {
    // Ensure speed input is in knots, as knots is the internally used unit
    _speedInKnots = _convertSpeedToKnots(value, unitSpeed);
  }

  @override
  String toString() => "$value $type $unitSpeed";

  /// Convert the speed to Calibrated Airspeed at a defined Atmo point
  /// [atAtmoPoint]. The converted speed unit is the same as the input
  /// speed unit.
  double toCAS(Atmo atAtmoPoint) {
    double resultInKnots;
    switch (type) {
      case SpeedType.cas:
        return value;
      case SpeedType.eas:
        resultInKnots =
            speedKEASToKCAS(_speedInKnots, atAtmoPoint.getHpInFeet());
        break;
      case SpeedType.tas:
        resultInKnots = speedKTASToKCAS(_speedInKnots,
            atAtmoPoint.getHpInFeet(), _getDeltaISAInCelsius(atAtmoPoint));
        break;
      case SpeedType.mach:
        resultInKnots = speedMachToKCAS(value, atAtmoPoint.getHpInFeet());
        break;
    }

    // Return output speed in same unit as input speed was provided
    return _convertSpeedResultToInputUnit(resultInKnots, unitSpeed);
  }

  /// Convert the speed to Equivalent Airspeed at a defined Atmo point
  /// [atAtmoPoint]. The converted speed unit is the same as the input
  /// speed unit.
  double toEAS(Atmo atAtmoPoint) {
    double resultInKnots;
    switch (type) {
      case SpeedType.cas:
        resultInKnots =
            speedKCASToKEAS(_speedInKnots, atAtmoPoint.getHpInFeet());
        break;
      case SpeedType.eas:
        return value;
      case SpeedType.tas:
        resultInKnots = speedKTASToKEAS(_speedInKnots,
            atAtmoPoint.getHpInFeet(), _getDeltaISAInCelsius(atAtmoPoint));
        break;
      case SpeedType.mach:
        resultInKnots = speedMachToKEAS(value, atAtmoPoint.getHpInFeet());
        break;
    }

    // Return output speed in same unit as input speed was provided.
    return _convertSpeedResultToInputUnit(resultInKnots, unitSpeed);
  }

  /// Convert the speed to True Airspeed at a defined Atmo point [atAtmoPoint].
  /// The converted speed unit is the same as the input speed unit.
  double toTAS(Atmo atAtmoPoint) {
    double resultInKnots;
    switch (type) {
      case SpeedType.cas:
        resultInKnots = speedKCASToKTAS(_speedInKnots,
            atAtmoPoint.getHpInFeet(), _getDeltaISAInCelsius(atAtmoPoint));
        break;
      case SpeedType.eas:
        resultInKnots = speedKEASToKTAS(_speedInKnots,
            atAtmoPoint.getHpInFeet(), _getDeltaISAInCelsius(atAtmoPoint));
        break;
      case SpeedType.tas:
        return value;
      case SpeedType.mach:
        resultInKnots = speedMachToKTAS(value, atAtmoPoint.getHpInFeet(),
            _getDeltaISAInCelsius(atAtmoPoint));
        break;
    }

    // Return output speed in same unit as input speed was provided.
    return _convertSpeedResultToInputUnit(resultInKnots, unitSpeed);
  }

  /// Convert the speed to Mach at a defined Atmo point [atAtmoPoint].
  double toMach(Atmo atAtmoPoint) {
    switch (type) {
      case SpeedType.cas:
        return speedKCASToMach(_speedInKnots, atAtmoPoint.getHpInFeet());
      case SpeedType.eas:
        return speedKEASToMach(_speedInKnots, atAtmoPoint.getHpInFeet());
      case SpeedType.tas:
        return speedKTASToMach(_speedInKnots, atAtmoPoint.getHpInFeet(),
            _getDeltaISAInCelsius(atAtmoPoint));
      case SpeedType.mach:
        return value;
    }
  }

  /// Covert Speed object to another unit as defined in [toUnit].
  /// NOTE: method must be performed on the Speed object
  /// Example takes CAS from 148.7 knots to ft/sec:
  /// Speed(value: 148.7, type: SpeedType.cas).convertSpeed(SpeedUnit.fps);
  double convertSpeed(SpeedUnit fromUnit, SpeedUnit toUnit) =>
      _convertSpeedResultToInputUnit(
          _convertSpeedToKnots(value, fromUnit), toUnit);
}

/// Extension method to directly convert a double speed value from one
/// unit to another unit
extension ConvertSpeed on double {
  double convertSpeed(SpeedUnit fromUnit, SpeedUnit toUnit) =>
      _convertSpeedResultToInputUnit(
          _convertSpeedToKnots(this, fromUnit), toUnit);
}

// Convert input speed from whatever unit input to knots
double _convertSpeedToKnots(double value, SpeedUnit unitSpeed) {
  switch (unitSpeed) {
    case SpeedUnit.kts:
      return value;
    case SpeedUnit.fps:
      return value / Convert.knotsToFeetPerSecond;
    case SpeedUnit.mph:
      return value / Convert.knotsToStatuteMilesPerHour;
    case SpeedUnit.mps:
      return value / Convert.knotsToMetersPerSecond;
    case SpeedUnit.kmh:
      return value / Convert.knotsToKilometersPerHour;
  }
}

// Convert result speed from knots to input speed unit used
double _convertSpeedResultToInputUnit(
    double speedInKnots, SpeedUnit inputSpeedUnit) {
  // Return output speed in same unit as input speed was provided
  switch (inputSpeedUnit) {
    case SpeedUnit.kts:
      return speedInKnots;
    case SpeedUnit.fps:
      return speedInKnots * Convert.knotsToFeetPerSecond;
    case SpeedUnit.mph:
      return speedInKnots * Convert.knotsToStatuteMilesPerHour;
    case SpeedUnit.mps:
      return speedInKnots * Convert.knotsToMetersPerSecond;
    case SpeedUnit.kmh:
      return speedInKnots * Convert.knotsToKilometersPerHour;
    default:
      return speedInKnots;
  }
}

// Private method to get delta ISA in Celsius, regardless of delta ISA unit
// provided.
double _getDeltaISAInCelsius(Atmo atmoPoint) =>
    (atmoPoint.unitTemperature == TemperatureUnit.C) ||
            (atmoPoint.unitTemperature == TemperatureUnit.K)
        ? atmoPoint.getDeltaISA()
        : atmoPoint.getDeltaISA() / 1.8;
