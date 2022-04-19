/// Defines possible length and height units
enum LengthUnit {
  /// Feet
  ft,

  /// Meters
  m,

  /// Kilometers
  km,

  /// Statute Miles
  sm,

  /// Nautical Miles
  nm
}

/// Defines possible atmospheric pressure units
enum PressureUnit {
  /// Hectopascal (or millibar)
  hPa,

  /// Inches mercury
  inHg
}

/// Defines possible speed units
enum SpeedUnit {
  /// Knots
  kts,

  /// Feet/second
  fps,

  /// Statute miles/hour
  mph,

  /// Meters/second
  mps,

  /// Kilometers/hour
  kmh
}

/// Defines possible temperature units
enum TemperatureUnit {
  /// Celsius
  C,

  /// Fahrenheit
  F,

  /// Kelvin
  K,

  /// Rankine
  R
}

/// Defines possible weight units
enum WeightUnit {
  /// Pounds
  lbs,

  /// Kilograms
  kg
}

/// Defines possible speed types
enum SpeedType {
  /// Calibrated airspeed
  cas,

  /// Equivalent airspeed
  eas,

  /// True airspeed
  tas,

  /// Mach
  mach
}
