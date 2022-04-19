import 'dart:math';

import 'constants.dart';
import 'ratio.dart';

// A collection of functions to convert between speeds. Since these functions
// are not direct publicly callable, require pressure altitude unit is feet
// and required delta ISA unit is Celsius

// Calculate common term for the other conversions from KCAS
double _commonKCASTerm(double kcas, double hpInFeet) {
  double delta = Ratio().delta(hpInFeet);
  double term1 = 1 + 0.2 * pow((kcas / speedOfSoundSlStdDayKnots), 2);
  double term2 = pow(term1, 3.5) - 1;
  double term3 = 1 / delta * term2 + 1;
  return pow(term3, 1 / 3.5) - 1;
}

// Convert from KCAS

/// Convert KCAS to KEAS
/// Speed [kcas] in knots and pressure altitude [hpInFeet] in feet
/// Returns KEAS in knots
double speedKCASToKEAS(double kcas, double hpInFeet) {
  double delta = Ratio().delta(hpInFeet);
  return speedCalcConstant * sqrt(delta * _commonKCASTerm(kcas, hpInFeet));
}

/// Convert KCAS to Mach
/// Speed [kcas] in knots and pressure altitude [hpInFeet] in feet
/// Returns Mach
double speedKCASToMach(double kcas, double hpInFeet) =>
    sqrt(5 * _commonKCASTerm(kcas, hpInFeet));

/// Convert KCAS to KEAS
/// Speed [kcas] in knots and pressure altitude [hpInFeet] in feet, delta ISA
/// [deltaISAInC] in Celsius
/// Returns KTAS in knots
double speedKCASToKTAS(double kcas, double hpInFeet, double deltaISAInC) =>
    speedCalcConstant *
    sqrt(Ratio().theta(hpInFeet, deltaISA: deltaISAInC) *
        _commonKCASTerm(kcas, hpInFeet));

// Convert from KEAS

/// Convert KEAS to KCAS
/// Speed [keas] in knots and pressure altitude [hpInFeet] in feet
/// Returns KCAS in knots
double speedKEASToKCAS(double keas, double hpInFeet) {
  double delta = Ratio().delta(hpInFeet);
  double term1 = 1 + (1 / delta) * pow((keas / speedCalcConstant), 2);
  double term2 = pow(term1, 3.5) - 1;
  double term3 = delta * term2 + 1;
  return speedCalcConstant * sqrt(pow(term3, 1 / 3.5) - 1);
}

/// Convert KEAS to Mach
/// Speed [keas] in knots and pressure altitude [hpInFeet] in feet
/// Returns Mach
double speedKEASToMach(double keas, double hpInFeet) =>
    keas / speedOfSoundSlStdDayKnots * sqrt(1 / Ratio().delta(hpInFeet));

/// Convert KEAS to KTAS
/// Speed [keas] in knots and pressure altitude [hpInFeet] in feet, delta ISA
/// [deltaISAInC] in Celsius
/// Returns KTAS in knots
double speedKEASToKTAS(double keas, double hpInFeet, double deltaISAInC) =>
    keas / sqrt(Ratio().sigma(hpInFeet, deltaISA: deltaISAInC));

// Convert from KTAS

/// Convert KTAS to KCAS
/// Speed [ktas] in knots and pressure altitude [hpInFeet] in feet, delta ISA
/// [deltaISAInC] in Celsius
/// Returns KCAS in knots
double speedKTASToKCAS(double ktas, double hpInFeet, double deltaISAInC) {
  double term1 = 1 +
      1 /
          Ratio().theta(hpInFeet, deltaISA: deltaISAInC) *
          pow((ktas / speedCalcConstant), 2);
  double term2 = pow(term1, 3.5) - 1;
  double term3 = Ratio().delta(hpInFeet) * term2 + 1;
  return speedCalcConstant * sqrt(pow(term3, 1 / 3.5) - 1);
}

/// Convert KTAS to KEAS
/// Speed [ktas] in knots and pressure altitude [hpInFeet] in feet, delta ISA
/// [deltaISAInC] in Celsius
/// Returns KEAS in knots
double speedKTASToKEAS(double ktas, double hpInFeet, double deltaISAInC) =>
    ktas * sqrt(Ratio().sigma(hpInFeet, deltaISA: deltaISAInC));

/// Convert KTAS to Mach
/// Speed [ktas] in knots and pressure altitude [hpInFeet] in feet, delta ISA
/// [deltaISAInC] in Celsius
/// Returns Mach
double speedKTASToMach(double ktas, double hpInFeet, double deltaISAInC) =>
    ktas /
    (speedOfSoundSlStdDayKnots *
        sqrt(Ratio().theta(hpInFeet, deltaISA: deltaISAInC)));

// Convert from Mach

/// Convert Mach to KCAS
/// Speed [mach] in knots and pressure altitude [hpInFeet] in feet, delta ISA
/// [deltaISAInC] in Celsius
/// Returns KCAS in knots
double speedMachToKCAS(double mach, double hpInFeet) {
  double term1 = pow(0.2 * mach * mach + 1, 3.5) - 1;
  double term2 = Ratio().delta(hpInFeet) * term1 + 1;
  double term3 = pow(term2, 1 / 3.5) - 1;
  return speedCalcConstant * sqrt(term3);
}

/// Convert Mach to KEAS
/// Speed [mach] in knots and pressure altitude [hpInFeet] in feet
/// Returns KEAS in knots
double speedMachToKEAS(double mach, double hpInFeet) =>
    speedOfSoundSlStdDayKnots * mach * sqrt(Ratio().delta(hpInFeet));

/// Convert Mach to KTAS
/// Speed [mach] in knots and pressure altitude [hpInFeet] in feet, delta ISA
/// [deltaISAInC] in Celsius
/// Returns KTAS in knots
double speedMachToKTAS(double mach, double hpInFeet, double deltaISAInC) =>
    speedOfSoundSlStdDayKnots *
    mach *
    sqrt(Ratio().theta(hpInFeet, deltaISA: deltaISAInC));
