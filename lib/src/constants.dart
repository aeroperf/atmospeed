/// Atmospheric constants

/// 11000 m by definition, 36089.24 ft
const double heightTropopauseFt = 11000 / 0.3048;

/// 20000 m by definition, 65617 ft
const double heightStratopauseFt = 20000 / 0.3048;

/// Troposphere standard dry air temperature lapse rate in C/ft, 0.0019812 C/ft
const double lapseRateCPerFt = 0.0019812;

/// Troposphere standard dry air temperature lapse rate in F/ft, 0.00356616 F/ft
const double lapseRateFPerFt = 0.00356616;

/// Sea level standard day temperature in Celsius, 15C
const double tempSlStdDayCelsius = 15.0;

/// Sea level standard day temperature in Fahrenheit, 59F
const double tempSlStdDayFahrenheit = 59.0;

/// Sea level standard day temperature in Kelvin, 288.15K
const double tempSlStdDayKelvin = 288.15;

/// Sea level standard day temperature in Rankine, 518.67R
const double tempSlStdDayRankine = 518.67;

/// Temperature in Stratosphere in Celsius, -56.5 deg C
const double tempStratosphereCelsius = -56.5;

/// Temperature in Stratosphere in Fahrenheit, -69.7 deg F
const double tempStratosphereFahrenheit = -69.7;

/// Water freezing temperature (0C) in Kelvin. 273.15K
const double zeroCInKelvin = 273.15;

/// Water freezing temperature (0C) in Rankine. 459.67R
const double zeroCInRankine = 459.67;

/// Constant at Tropopause to use with US units (hp in feet)
/// R * Ttrop / g0 = 1716.5617 * (459.67 - 69.7) / 32.17405 = 20805.7
const double tropopauseConstantUSUnit = 20805.7;

/// Exponent used in conjunction with delta calculation in troposphere, 5.25588
const double troposphereDeltaExponent = 5.25588;

/// Delta value at tropopause height
const double deltaAtTropopause = 0.22336;

/// Sea level standard pressure in inches Hg, 29.922 inHg
const double pressureSlStdDayInchesHg = 29.92;

/// Sea level standard pressure in hPa (or millibars) 1013.25 hPa
const double pressureSlStdDayHectoPascal = 1013.25;

/// Pressure calculation constant, 145442.15 ft
const double pressureCalcConstant = 145442.15;

/// Pressure calclation exponent, 0.190263
const double pressureCalcExponent = 0.190263;

/// Speed of sound at sea level and standard day in knots, 661.4786 knots
const double speedOfSoundSlStdDayKnots = 661.4786;

/// Speed of sound at sea level and standard day in ft/sec, 1116.45 ft/s
const double speedOfSoundSlStdDayFeetPerSecond = 1116.45;

/// Speed of sound at sea level and standard day in m/s, 340.29 m/s
const double speedOfSoundSlStdDayMetersPerSecond = 340.29;

/// Speed of sound at sea level and standard day in km/h, 1225.044 km/h
const double speedOfSoundSlStdDayKilometersPerHour =
    3.6 * speedOfSoundSlStdDayMetersPerSecond;

/// Speed of sound at sea level and standard day in mph, 761.2 mph
const double speedOfSoundSlStdDayStatuteMilesPerHour = 761.2;

/// Speed calculation constant,
/// equals (((2*gamma*P0/((gamma-1)*rho0)))^0.5)/1.6878 = 1479.1
const double speedCalcConstant = 1479.1;
