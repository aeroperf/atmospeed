<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A Dart library to perform standard and non-standard atmosphere property calculations and speed conversions. Based on the [1976 US Standard Atmosphere](https://en.wikipedia.org/wiki/U.S._Standard_Atmosphere) (NASA-TM-X-74335) methodologies and valid through 20 km (stratopause) for 
atmospheric flight calculations (identical to ICAO and [International Standard Atmosphere](https://en.wikipedia.org/wiki/International_Standard_Atmosphere) definitions through 20 km). 

## Features

* Define an atmospheric point in terms of pressure altitude and temperature (either as delta ISA or OAT) and for that point:
  * Calculate pressure, temperature and density ratios
  * Calculate speed of sound
  * Calculate Outside Air Temperature (OAT), standard temperature (ISA) or deviation form standard (delta ISA)
* Define a speed point condition in terms of speed value and speed type (EAS, CAS, TAS or Mach) and for that point:
  * Convert to the other speed types at a defined atmospheric point
  * Convert between different speed units
* Calculate pressure altitude from airport elevation and altimeter setting
* Units default to feet (altitude), Celsius (temperature) and knots (speed), but Atmospeed offers unit choice flexibility

## Getting started

No prerequisites, simply add Atmospeed to the `pubspec.yaml` file:
```yaml
dependencies:
  atmospeed: ^1.0.0    
```

## Usage

1. Define one or more `Atmo` point condition:
```dart
// 18455 ft pressure alt, ISA+13C temperature
Atmo atmo = Atmo(hp: 18455, temperature: 13); 

// 11249 m pressure alt, -51.5 OATC temperature
Atmo atmo1 = Atmo(hp: 11249, unitAltitude: LengthUnit.m, temperature: -51.5, temperatureIsDeltaISA: false); 
   ```

2. Calculate atmospheric properties on the atmo conditions:
```dart
atmo.getDelta(); // δ = 0.4901
atmo.getTheta(); // θ = 0.9182
atmo1.getSigma(); // σ = 0.2792
atmo1.getDeltaISA(); // ISA+5C
```

3. Or, define a `Speed` point and convert to another speed type for an `Atmo` point condition:
```dart
// Define CAS as 255.6 knots
Speed kcas = Speed(value: 255.6, type: SpeedType.cas);

// Calculate EAS, TAS and Mach at atmo point
kcas.toEAS(atmo); // 251.1 KEAS
kcas.toTAS(atmo); // 343.7 KTAS
kcas.toMach(atmo); // Mach 0.5422
```
4. Additional convenience methods exist:
```dart
// Convert a Speed object's speed to another unit; example knots to mph conversion
var mph_cas = kcas.convertSpeed(SpeedUnit.kts, SpeedUnit.mph);

// Or convert any double value between any two speed units
174.6.convertSpeed(SpeedUnit.kmh, SpeedUnit.fps); // 159.1 ft/sec

// Calculate pressure altitude form airport elevation and altimer setting
Altitude.pressureAltitude(airportElevation: 3456, airportAltimeter: 29.73); // 3632.2 ft

```

See additional examples in the `/example` folder. 


## Library Limitation

This library limits calculations to an altitude of 20km (65617 ft) and is intended for atmospheric flight calculations below the stratopause.
