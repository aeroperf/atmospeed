import 'enums.dart';
import 'constants.dart';
import 'convert.dart';

/// Standard atmosphere methods for temperature calculations
class Temperature {
  /// Calculates ISA temperature for a pressure altitude.
  ///
  /// [hp] is the pressure altitude at which to calculate
  /// ISA temperature, defaults to feet.
  ///
  /// [unitAltitude] is an optional altitude unit input (defaults to feet) for
  /// the input altitude; other options included are meters, nautical mile,
  /// statute mile, kilometer.
  ///
  /// [unitTemperature] is an optional temperature unit input (defaults to
  /// Celcius) for the returned ISA temperature; other options include Kelvin,
  /// Fahrenheit, and Rankine
  double isa(double hp,
      {LengthUnit unitAltitude = LengthUnit.ft,
      TemperatureUnit unitTemperature = TemperatureUnit.C}) {
    // Ensure altitude is in feet
    hp = Convert.lengthToFeet(hp, unitAltitude);

    if (hp <= heightTropopauseFt) {
      switch (unitTemperature) {
        case TemperatureUnit.C:
          return tempSlStdDayCelsius - lapseRateCPerFt * hp;
        case TemperatureUnit.F:
          return tempSlStdDayFahrenheit - lapseRateFPerFt * hp;
        case TemperatureUnit.K:
          return tempSlStdDayKelvin - lapseRateCPerFt * hp;
        case TemperatureUnit.R:
          return tempSlStdDayRankine - lapseRateFPerFt * hp;
      }
    } else if (hp <= heightStratopauseFt) {
      switch (unitTemperature) {
        case TemperatureUnit.C:
          return tempStratosphereCelsius;
        case TemperatureUnit.F:
          return tempStratosphereFahrenheit;
        case TemperatureUnit.K:
          return tempStratosphereCelsius + zeroCInKelvin;
        case TemperatureUnit.R:
          return tempStratosphereFahrenheit + zeroCInRankine;
      }
    } else {
      throw RangeError('Altitude is above stratopause');
    }
  }

  /// Calculates Outside Air Temperature for a pressure altitude and a deviation
  /// from standard temperature.
  ///
  /// [hp] is the pressure altitude at which to calculate OAT, defaults to feet.
  ///
  /// [unitAltitude] is an optional altitude unit input (defaults to feet) for
  /// the input altitude; other options included are meters, nautical mile,
  /// statute mile, kilometer.
  ///
  /// [deltaISA] is the temperature deviation from standard.
  ///
  /// [unitTemperature] is an optional temperature unit input for the returned
  /// OAT temperature; defaults to Celsius, other options include Kelvin,
  /// Fahrenheit, and Rankine.
  double oat(double hp, double deltaISA,
          {LengthUnit unitAltitude = LengthUnit.ft,
          TemperatureUnit unitTemperature = TemperatureUnit.C}) =>
      isa(hp, unitAltitude: unitAltitude, unitTemperature: unitTemperature) +
      deltaISA;

  /// Calculates temperature deviation from standard temperature
  /// for a pressure altitude and outside air temperature.
  ///
  /// [hp] is the pressure altitude at which to calculate the temperature
  /// deviation, defaults to feet.
  ///
  /// [unitAltitude] is an optional altitude unit input (defaults to feet) for
  /// the input altitude; other options included are meter, nautical mile,
  /// statute mile, kilometer.
  ///
  /// [oat] is the outside air temperature.
  ///
  /// [unitTemperature] is an optional temperature unit input for the returned
  /// delta ISA temperature; defaults to Celsius, other options include Kelvin,
  /// Fahrenheit, and Rankine
  double deltaIsa(double hp, double oat,
          {LengthUnit unitAltitude = LengthUnit.ft,
          TemperatureUnit unitTemperature = TemperatureUnit.C}) =>
      oat -
      isa(hp, unitAltitude: unitAltitude, unitTemperature: unitTemperature);
}
