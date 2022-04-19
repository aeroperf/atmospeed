// Copyright (c) 2022, by AeroPerf LLC. All rights reserved. Use of this source
// code is governed by an MIT license that can be found in the LICENSE.md file.

/// Atmospeed library
///
/// Atmospeed is a utility library for anyone who needs to perform the
/// following:
/// * Define an atmospheric point in terms of altitude and temperature and
///   calculate atmospheric properties at that point for a standard or
///   non-standard atmosphere
/// * Define a speed condition as equivalent, calibrated, true airspeed or
///   Mach, and convert that speed to one of the other three at a given
///   atmospheric point condition.
///
/// This library uses methodologies, constants and equiations as defined by the
/// 1976 US Standard Atmosphere (NASA-TM-X-74335), which are identical to the
/// ICAO and International Standard Atmosphere definitions through 51 km.
/// This library limits calculations to an altitude of 20km (65617 ft) and is
/// intended for atmospheric flight calculations below the stratopause.
///
/// This library supports calculation of standard as well as non-standard
/// atmosphere conditions with a non-zero temperature deviation from standard.
/// Note that the default temperature input is for a delta ISA temperature
/// deviation and not ambient, or outside air temperature. OAT, however is
/// supported by setting a boolean when defining an Atmo point condition, as
/// outlined in the class documentation.
///
library atmospeed;

export 'src/atmo.dart';
export 'src/speed.dart';
export 'src/altitude.dart';
export 'src/enums.dart';
