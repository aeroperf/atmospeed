import 'package:atmospeed/atmospeed.dart';

// Example calculations

// ignore_for_file: avoid_print
void main() {
  // Example 1: Create atmospheric point condition for 18455 ft and +13C
  // delta ISA and calculate atmospheric properties
  Atmo atmo1 = Atmo(hp: 18455, temperature: 13);
  print('Example 1');
  print('Condition: ${atmo1.toString()}');
  print('Delta: ${atmo1.getDelta()}');
  print('Theta: ${atmo1.getTheta()}');
  print('Sigma: ${atmo1.getSigma()}');
  print('OAT: ${atmo1.getOAT()} ${atmo1.unitTemperature}\n');

  // Example 2: For the previously defined atmospheric point condition, set a
  // calibrated airspeed of 255.6 knots and calculate KTAS, KEAS and Mach
  Speed kcas = Speed(value: 255.6, type: SpeedType.cas);
  print('Example 2');
  print('Condition: ${kcas.toString()}');
  print('KEAS: ${kcas.toEAS(atmo1)}');
  print('KTAS: ${kcas.toTAS(atmo1)}');
  print('Mach: ${kcas.toMach(atmo1)}\n');

  // Example 3: Same as example 1, but with different units than default and
  // using OAT input
  Atmo atmo2 = Atmo(
      hp: 11249,
      unitAltitude: LengthUnit.m,
      temperature: -57.8,
      temperatureIsDeltaISA: false,
      unitTemperature: TemperatureUnit.F);
  print('Example 3');
  print('Condition: ${atmo2.toString()}');
  print('Delta: ${atmo2.getDelta()}');
  print('Theta: ${atmo2.getTheta()}');
  print('Sigma: ${atmo2.getSigma()}');
  print('Delta ISA: ${atmo2.getDeltaISA()} ${atmo2.unitTemperature}\n');

// Example 4: For atmo2 set in example 3, set EAS to 299.4 m/s input and
// calculate CAS and TAS output (note: in m/s), as well as Mach
  Speed eas =
      Speed(value: 299.4, type: SpeedType.eas, unitSpeed: SpeedUnit.mps);
  print('Example 4');
  print('Condition: ${eas.toString()}');
  print('CAS in m/s: ${eas.toCAS(atmo2)}');
  print('TAS in m/s: ${eas.toTAS(atmo2)}');
  print('Mach: ${eas.toMach(atmo2)}\n');

  // Example 5: Convert Speed object TAS from m/s to knots
  Speed tasMps = Speed(
      value: eas.toTAS(atmo2), type: SpeedType.tas, unitSpeed: SpeedUnit.mps);
  print('Example 5');
  print('TAS in m/s: $tasMps');
  print('TAS in knots: ${tasMps.convertSpeed(SpeedUnit.mps, SpeedUnit.kts)}\n');

  // Example 6: Convert any double directly - convert 174.6 km/h into ft/sec
  print('Example 6');
  print(
      '174.6 km/h is ${174.6.convertSpeed(SpeedUnit.kmh, SpeedUnit.fps)} ft/sec\n');

  // Example 7: Calculate pressure altitude from airport elevation and altimeter setting
  print('Example 7');
  print('''Airport 3456 ft at 29.73 inHg is at pressure altitude 
      ${Altitude.pressureAltitude(airportElevation: 3456, airportAltimeter: 29.73)} ft''');
}
