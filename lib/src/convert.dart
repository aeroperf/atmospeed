import 'enums.dart';

// Conversion class
class Convert {
  // Unit conversion constants
  // Length conversions
  static const double metersPerFoot = 0.3048;
  static const double metersPerNauticalMile = 1852.0;
  static const double metersPerStatuteMile = 1609.344;
  static const double metersPerKilometer = 1000.0;
  static const double kilometersPerNauticalMile =
      metersPerNauticalMile / metersPerKilometer;
  static const double kilometersPerStatuteMile =
      metersPerStatuteMile / metersPerKilometer;
  static const double feetPerStatuteMile = 5280.0;
  static const double feetPerNauticalMile = 6076.11549;
  static const double statuteMilesPerNauticalMile = 1.15078;

  // Speed conversions
  static const double knotsToFeetPerSecond = 1.6878;
  static const double knotsToMetersPerSecond = 0.51444;
  static const double knotsToKilometersPerHour = 1.8520;
  static const double knotsToStatuteMilesPerHour = 1.1508;

  // Convert length to Feet
  static double lengthToFeet(double value, LengthUnit fromUnit) {
    switch (fromUnit) {
      case LengthUnit.ft:
        return value;
      case LengthUnit.m:
        return value / metersPerFoot;
      case LengthUnit.km:
        return value * 1000.0 / metersPerFoot;
      case LengthUnit.sm:
        return value * feetPerStatuteMile;
      case LengthUnit.nm:
        return value * feetPerNauticalMile;
    }
  }

  // Convert length from one unit to another
  static double length(double value, LengthUnit fromUnit, LengthUnit toUnit) {
    var lengthInFeet = lengthToFeet(value, fromUnit);

    switch (toUnit) {
      case LengthUnit.ft:
        return lengthInFeet;
      case LengthUnit.m:
        return lengthInFeet * metersPerFoot;
      case LengthUnit.km:
        return lengthInFeet * metersPerFoot / 1000.0;
      case LengthUnit.sm:
        return lengthInFeet / feetPerStatuteMile;
      case LengthUnit.nm:
        return lengthInFeet / feetPerNauticalMile;
    }
  }

  // Convert a speed in knots to another unit
  static double fromKnotsToUnit(double speedInKnots, SpeedUnit toUnit) {
    switch (toUnit) {
      case SpeedUnit.kts:
        return speedInKnots;
      case SpeedUnit.fps:
        return speedInKnots * knotsToFeetPerSecond;
      case SpeedUnit.mph:
        return speedInKnots * knotsToStatuteMilesPerHour;
      case SpeedUnit.mps:
        return speedInKnots * knotsToMetersPerSecond;
      case SpeedUnit.kmh:
        return speedInKnots * knotsToKilometersPerHour;
    }
  }
}
