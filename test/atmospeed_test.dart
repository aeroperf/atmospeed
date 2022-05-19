import 'package:atmospeed/src/speed_conversion.dart';
import 'package:test/test.dart';
import 'package:atmospeed/atmospeed.dart';

void main() {
  test('Calculate ISA for altitude', () {
    // In troposphere test, calculated in ISAC
    expect(Atmo(hp: 24555.0, temperature: 0).getISA(), closeTo(-33.65, 0.02));
    // In stratosphere test, calculated in ISAF
    expect(
        Atmo(hp: 43555.0, temperature: 0, unitTemperature: TemperatureUnit.F)
            .getISA(),
        -69.7);
    // In troposphere test in meters altitude, calculated in ISAC
    expect(
        Atmo(hp: 7484.4, temperature: 0, unitAltitude: LengthUnit.m).getISA(),
        closeTo(-33.65, 0.02));
    // In stratosphere test, calculated in ISAF
    expect(
        Atmo(hp: 43555.0, temperature: 0, unitTemperature: TemperatureUnit.F)
            .getISA(),
        -69.7);
    // In stratosphere test in NM altitude, calculated in ISAF
    expect(
        Atmo(
                hp: 7.168,
                temperature: 0,
                unitAltitude: LengthUnit.nm,
                unitTemperature: TemperatureUnit.F)
            .getISA(),
        -69.7);
  });

  test('Calculate OAT from DISA for altitude', () {
    // In troposphere test, in C
    expect(
        Atmo(hp: 31000.0, temperature: 6.0).getOAT(), closeTo(-40.425, 0.01));
    // In troposphere test, in meters, in K
    expect(
        Atmo(
                hp: 9448.8,
                temperature: 6,
                unitAltitude: LengthUnit.m,
                unitTemperature: TemperatureUnit.K)
            .getOAT(),
        closeTo(232.725, 0.01));
    // In stratosphere test, in C
    expect(Atmo(hp: 41000.0, temperature: 6.0).getOAT(), closeTo(-50.5, 0.01));
    // In troposphere test, in F
    expect(
        Atmo(
                hp: 31000.0,
                temperature: -10.8,
                unitTemperature: TemperatureUnit.F)
            .getOAT(),
        closeTo(-62.36, 0.01));
    // In stratosphere test, in F
    expect(
        Atmo(hp: 41000.0, temperature: 10.8, unitTemperature: TemperatureUnit.F)
            .getOAT(),
        closeTo(-58.9, 0.01));
    // In stratosphere test in statute mile altitude, in F
    expect(
        Atmo(
                hp: 7.765,
                temperature: 10.8,
                unitAltitude: LengthUnit.sm,
                unitTemperature: TemperatureUnit.F)
            .getOAT(),
        closeTo(-58.9, 0.01));
  });

  test('Calculate DISA from OAT for altitude', () {
    // In troposphere test, in C
    expect(
        Atmo(hp: 31000.0, temperature: -40.42, temperatureIsDeltaISA: false)
            .getDeltaISA(),
        closeTo(6.0, 0.01));
    // In stratosphere test, in C
    expect(
        Atmo(hp: 41000.0, temperature: -50.5, temperatureIsDeltaISA: false)
            .getDeltaISA(),
        closeTo(6.0, 0.01));
    // In troposphere test, in F
    expect(
        Atmo(
                hp: 31000.0,
                temperature: -62.36,
                temperatureIsDeltaISA: false,
                unitTemperature: TemperatureUnit.F)
            .getDeltaISA(),
        closeTo(-10.8, 0.01));
    // In troposphere test in km altitude, in F
    expect(
        Atmo(
                hp: 9.4488,
                temperature: -62.36,
                temperatureIsDeltaISA: false,
                unitAltitude: LengthUnit.km,
                unitTemperature: TemperatureUnit.F)
            .getDeltaISA(),
        closeTo(-10.8, 0.01));
    // In stratosphere test, in F
    expect(
        Atmo(
                hp: 41000.0,
                temperature: -58.9,
                temperatureIsDeltaISA: false,
                unitTemperature: TemperatureUnit.F)
            .getDeltaISA(),
        closeTo(10.8, 0.01));
    // In stratosphere test, in nautical mile, in K
    expect(
        Atmo(
                hp: 6.74773,
                temperature: 222.65,
                temperatureIsDeltaISA: false,
                unitTemperature: TemperatureUnit.K,
                unitAltitude: LengthUnit.nm)
            .getDeltaISA(),
        closeTo(6.0, 0.01));
  });

  test('Calculate Theta for altitude with ISA input', () {
    // In troposphere test, ISA test, in C
    expect(
        Atmo(hp: 31000.0, temperature: 0).getTheta(), closeTo(0.7869, 0.0001));
    // In troposphere test, ISA test, in F
    expect(
        Atmo(hp: 31000.0, temperature: 0, unitTemperature: TemperatureUnit.F)
            .getTheta(),
        closeTo(0.7869, 0.0001));
    // In troposphere test, ISA test, in K
    expect(
        Atmo(hp: 31000.0, temperature: 0, unitTemperature: TemperatureUnit.K)
            .getTheta(),
        closeTo(0.7869, 0.0001));
    // In troposphere test, ISA test, in R
    expect(
        Atmo(hp: 31000.0, temperature: 0, unitTemperature: TemperatureUnit.R)
            .getTheta(),
        closeTo(0.7869, 0.0001));
    // In stratospere test, ISA test, in C
    expect(
        Atmo(hp: 45000.0, temperature: 0).getTheta(), closeTo(0.7519, 0.0001));
    // In stratospere test, ISA test, in R
    expect(
        Atmo(hp: 45000.0, temperature: 0, unitTemperature: TemperatureUnit.R)
            .getTheta(),
        closeTo(0.7519, 0.0001));
    // In troposphere test, in meters, ISA test, in F
    expect(
        Atmo(
                hp: 9448.8,
                temperature: 0,
                unitAltitude: LengthUnit.m,
                unitTemperature: TemperatureUnit.F)
            .getTheta(),
        closeTo(0.7869, 0.0001));
  });

  test('Calculate Theta for altitude with delta ISA input', () {
    // In troposphere test, ISA+20C test, in C
    expect(Atmo(hp: 31000.0, temperature: 20.0).getTheta(),
        closeTo(0.8563, 0.0001));
    // In troposphere test, in meters, ISA+20C test, in C
    expect(
        Atmo(hp: 9448.8, temperature: 20.0, unitAltitude: LengthUnit.m)
            .getTheta(),
        closeTo(0.8563, 0.0001));
    // In troposphere test, ISA+20F test, in F
    expect(
        Atmo(hp: 31000.0, temperature: 20.0, unitTemperature: TemperatureUnit.F)
            .getTheta(),
        closeTo(0.8254, 0.0001));
    // In troposphere test, ISA+20K test, in K
    expect(
        Atmo(hp: 31000.0, temperature: 20.0, unitTemperature: TemperatureUnit.K)
            .getTheta(),
        closeTo(0.8563, 0.0001));
    // In troposphere test, ISA+20R test, in R
    expect(
        Atmo(hp: 31000.0, temperature: 36.0, unitTemperature: TemperatureUnit.R)
            .getTheta(),
        closeTo(0.8563, 0.0001));
    // In stratospere test, ISA+20C test, in C
    expect(
        Atmo(hp: 45000.0, temperature: 20.0, unitTemperature: TemperatureUnit.C)
            .getTheta(),
        closeTo(0.8213, 0.0001));
    // In stratospere test, ISA+20R test, in R
    expect(
        Atmo(hp: 45000.0, temperature: 20.0, unitTemperature: TemperatureUnit.R)
            .getTheta(),
        closeTo(0.7905, 0.0001));
  });

  test('Calculate pressure ratio delta', () {
    // In troposphere, in ft
    expect(
        Atmo(hp: 15000.0, temperature: 0).getDelta(), closeTo(0.5643, 0.0001));
    // In troposphere, in statute mile
    expect(
        Atmo(hp: 5.456, temperature: 0, unitAltitude: LengthUnit.sm).getDelta(),
        closeTo(0.3134, 0.0001));
    // In stratosphere, in m
    expect(
        Atmo(hp: 11782.0, temperature: 0, unitAltitude: LengthUnit.m)
            .getDelta(),
        closeTo(0.1974, 0.0001));
    // In stratosphere, in ft
    expect(
        Atmo(hp: 43333.0, temperature: 0).getDelta(), closeTo(0.1577, 0.0001));
  });

  test('Calculate density ratio sigma', () {
    // In troposphere, in ft
    expect(
        Atmo(hp: 15000.0, temperature: 0).getSigma(), closeTo(0.6292, 0.0001));
    // In troposphere, in statute mile
    expect(
        Atmo(hp: 5.456, temperature: 0, unitAltitude: LengthUnit.sm).getSigma(),
        closeTo(0.3909, 0.0001));
    // In stratosphere, in m
    expect(
        Atmo(hp: 11782.0, temperature: 0, unitAltitude: LengthUnit.m)
            .getSigma(),
        closeTo(0.2626, 0.0001));
    // In stratosphere, in ft
    expect(
        Atmo(hp: 43333.0, temperature: 0).getSigma(), closeTo(0.2097, 0.0001));
    // In troposphere, in ft, ISA+14C
    expect(Atmo(hp: 15000.0, temperature: 14.0).getSigma(),
        closeTo(0.5969, 0.0001));
    // In stratosphere, in m, ISA-32F
    expect(
        Atmo(
                hp: 11782.0,
                temperature: -32.0,
                unitTemperature: TemperatureUnit.F,
                unitAltitude: LengthUnit.m)
            .getSigma(),
        closeTo(0.2861, 0.0001));
  });

  test('Throws exception with altitude above stratopause', () {
    expect(() => Atmo(hp: 65618.0, temperature: 0), throwsRangeError);
  });

  test('Calculate pressure altitude from altimeter nd elevation', () {
    // In ft and inHg
    expect(
        Altitude.pressureAltitude(
            airportElevation: 1000.0, airportAltimeter: 29.40),
        closeTo(1484.0, 0.5));
    // In ft and hPa
    expect(
        Altitude.pressureAltitude(
            airportElevation: 5555.0,
            airportAltimeter: 981.0,
            unitAltimeter: PressureUnit.hPa),
        closeTo(6447.0, 0.5));
    // In m and inHg
    expect(
        Altitude.pressureAltitude(
            airportElevation: 1708.0,
            airportAltimeter: 30.47,
            unitElevation: LengthUnit.m),
        closeTo(1554.0, 0.5));
    // In m and hpa
    expect(
        Altitude.pressureAltitude(
            airportElevation: 3795.0,
            airportAltimeter: 1044.0,
            unitElevation: LengthUnit.m,
            unitAltimeter: PressureUnit.hPa),
        closeTo(3542.0, 0.5));
    // In km and hpa
    expect(
        Altitude.pressureAltitude(
            airportElevation: 2.345,
            airportAltimeter: 982,
            unitElevation: LengthUnit.km,
            unitAltimeter: PressureUnit.hPa),
        closeTo(2.608, 0.5));
    // In NM and hpa
    expect(
        Altitude.pressureAltitude(
            airportElevation: 2.049,
            airportAltimeter: 1044.0,
            unitElevation: LengthUnit.nm,
            unitAltimeter: PressureUnit.hPa),
        closeTo(1.913, 0.001));
    // In statute miles and hpa
    expect(
        Altitude.pressureAltitude(
            airportElevation: 2.358,
            airportAltimeter: 1044.0,
            unitElevation: LengthUnit.sm,
            unitAltimeter: PressureUnit.hPa),
        closeTo(2.201, 0.001));
  });

  test('Calculate speed of sound', () {
    // In ft and Celsius input, knots output, troposphere
    expect(Atmo(hp: 13456.0, temperature: 28.6).getSpeedOfSound(),
        closeTo(663.7, 0.1));
    // In ft and Celsius input, knots output, stratosphere
    expect(Atmo(hp: 43456.0, temperature: -13.7).getSpeedOfSound(),
        closeTo(555.1, 0.1));
    // In meters and Fahrenheit input, knots output, troposphere
    expect(
        Atmo(
                hp: 5555.0,
                temperature: 13.7,
                unitAltitude: LengthUnit.m,
                unitTemperature: TemperatureUnit.F)
            .getSpeedOfSound(),
        closeTo(627.9, 0.1));
    // In ft and Celsius input, knots output, stratosphere
    expect(
        Atmo(
                hp: 13777,
                temperature: -33.7,
                unitAltitude: LengthUnit.m,
                unitTemperature: TemperatureUnit.F)
            .getSpeedOfSound(),
        closeTo(548.2, 0.1));
    // In ft and Celsius input, ft/s output, troposphere
    expect(
        Atmo(hp: 13456.0, temperature: 28.6)
            .getSpeedOfSound(unitSpeedOutput: SpeedUnit.fps),
        closeTo(1120.2, 0.1));
    // In ft and Celsius input, mph output, troposphere
    expect(
        Atmo(hp: 13456.0, temperature: 28.6)
            .getSpeedOfSound(unitSpeedOutput: SpeedUnit.mph),
        closeTo(763.8, 0.1));
    // In ft and Celsius input, m/s output, troposphere
    expect(
        Atmo(hp: 13456.0, temperature: 28.6)
            .getSpeedOfSound(unitSpeedOutput: SpeedUnit.mps),
        closeTo(341.4, 0.1));
    // In ft and Celsius input, km/h output, troposphere
    expect(
        Atmo(hp: 13456.0, temperature: 28.6)
            .getSpeedOfSound(unitSpeedOutput: SpeedUnit.kmh),
        closeTo(1229.2, 0.1));
  });

  test('Calculate Atmo class', () {
    // In troposphere test, ISA+20C test, in C
    Atmo atmo = Atmo(hp: 31000, temperature: 20, temperatureIsDeltaISA: true);
    expect(atmo.getTheta(), closeTo(0.8563, 0.0001));
    expect(atmo.getDelta(), closeTo(0.2837, 0.0001));
    expect(atmo.getSigma(), closeTo(0.3313, 0.0001));
    expect(atmo.getOAT(), closeTo(-26.42, 0.01));
    expect(atmo.getDeltaISA(), closeTo(20, 0.01));
    expect(atmo.getISA(), closeTo(-46.42, 0.01));
    expect(atmo.getSpeedOfSound(unitSpeedOutput: SpeedUnit.kmh),
        closeTo(1133.6, 0.1));
    // In troposphere test, -17C OAT test, in C
    Atmo atmo1 =
        Atmo(hp: 31000, temperature: -17, temperatureIsDeltaISA: false);
    expect(atmo1.getTheta(), closeTo(0.8890, 0.0001));
    expect(atmo1.getDelta(), closeTo(0.2837, 0.0001));
    expect(atmo1.getSigma(), closeTo(0.3191, 0.0001));
    expect(atmo1.getOAT(), closeTo(-17, 0.01));
    expect(atmo1.getDeltaISA(), closeTo(29.42, 0.01));
    expect(atmo1.getISA(), closeTo(-46.42, 0.01));
    expect(atmo1.getSpeedOfSound(unitSpeedOutput: SpeedUnit.fps),
        closeTo(1052.6, 0.1));
    // In stratosphere test, -17F delta ISA test
    Atmo atmo2 = Atmo(
        hp: 43333,
        temperature: -17,
        temperatureIsDeltaISA: true,
        unitTemperature: TemperatureUnit.F);
    expect(atmo2.getTheta(), closeTo(0.7191, 0.0001));
    expect(atmo2.getDelta(), closeTo(0.1577, 0.0001));
    expect(atmo2.getSigma(), closeTo(0.2193, 0.0001));
    expect(atmo2.getOAT(), closeTo(-86.7, 0.1));
    expect(atmo2.getDeltaISA(), closeTo(-17, 0.01));
    expect(atmo2.getISA(), closeTo(-69.7, 0.1));
    expect(atmo2.getSpeedOfSound(unitSpeedOutput: SpeedUnit.mph),
        closeTo(645.5, 0.1));
  });

  test('Convert KCAS to other speeds', () {
    // KCAS -> KEAS, troposphere
    expect(speedKCASToKEAS(287.3, 26788), closeTo(276.2, 0.1));
    // KCAS -> KTAS, troposphere
    expect(speedKCASToKTAS(287.3, 26788, 0), closeTo(426.0, 0.1));
    // KCAS -> Mach, troposphere
    expect(speedKCASToMach(287.3, 26788), closeTo(0.7130, 0.001));
  });

  test('Convert KEAS to other speeds', () {
    // KEAS -> KCAS, troposphere
    expect(speedKEASToKCAS(219.4, 38405), closeTo(231.3, 0.1));
    expect(speedKEASToKCAS(519.4, 38405), closeTo(656.0, 0.1));
    // KEAS -> KTAS, troposphere
    expect(speedKEASToKTAS(133.7, 13678, 0), closeTo(165.0, 0.1));
    // KEAS -> Mach, troposphere
    expect(speedKEASToMach(333.3, 30538), closeTo(0.9361, 0.001));
  });

  test('Convert KTAS to other speeds', () {
    // KTAS -> KEAS, troposphere
    expect(speedKTASToKEAS(389.4, 17408, 0), closeTo(296.9, 0.1));
    // KTAS -> KTAS, troposphere
    expect(speedKTASToKCAS(507.5, 43777, 0), closeTo(248.6, 0.1));
    // KTAS -> Mach, troposphere
    expect(speedKTASToMach(287.3, 7564, 0), closeTo(0.4461, 0.001));
  });

  test('Convert Mach to other speeds', () {
    // Mach -> KEAS, troposphere
    expect(speedMachToKEAS(0.4706, 4862), closeTo(284.7, 0.1));
    // Mach -> KTAS, troposphere
    expect(speedMachToKTAS(0.9127, 39422, 0), closeTo(523.5, 0.1));
    // Mach -> KCAS, troposphere
    expect(speedMachToKCAS(0.74, 21755), closeTo(331.6, 0.1));
  });

  test('Speed class conversion to CAS', () {
    // EAS -> CAS in knots unit and at ISA
    expect(
        Speed(value: 219.4, type: SpeedType.eas)
            .toCAS(Atmo(hp: 38405, temperature: 0)),
        closeTo(231.3, 0.1));
    // EAS -> CAS in m/s unit and at ISA
    expect(
        Speed(value: 112.87, type: SpeedType.eas, unitSpeed: SpeedUnit.mps)
            .toCAS(Atmo(hp: 38405, temperature: 0)),
        closeTo(119.0, 0.1));
    // TAS -> CAS in ft/s unit and at ISA+15C
    expect(
        Speed(value: 719.7, type: SpeedType.tas, unitSpeed: SpeedUnit.fps)
            .toCAS(Atmo(hp: 33485, temperature: 15)),
        closeTo(417.5, 0.1));
    // TAS -> CAS in ft/s unit and at ISA-13F
    expect(
        Speed(value: 719.7, type: SpeedType.tas, unitSpeed: SpeedUnit.fps)
            .toCAS(Atmo(
                hp: 5777,
                temperature: -13,
                unitAltitude: LengthUnit.m,
                unitTemperature: TemperatureUnit.F)),
        closeTo(558.8, 0.1));
    // Mach -> CAS
    expect(
        Speed(value: 0.4916, type: SpeedType.mach)
            .toCAS(Atmo(hp: 1.67, temperature: 0, unitAltitude: LengthUnit.nm)),
        closeTo(271.4, 0.1));
  });

  test('Speed class conversion to EAS', () {
    // CAS -> EAS in knots unit and at ISA
    expect(
        Speed(value: 148.7, type: SpeedType.cas)
            .toEAS(Atmo(hp: 6944, temperature: 0)),
        closeTo(148.4, 0.1));
    // CAS -> EAS in km/h unit and at ISA
    expect(
        Speed(value: 528.4, type: SpeedType.cas, unitSpeed: SpeedUnit.kmh)
            .toEAS(Atmo(hp: 37844, temperature: 0)),
        closeTo(491.3, 0.1));
    // TAS -> EAS in knots and at ISA-24C
    expect(
        Speed(value: 285.3, type: SpeedType.tas)
            .toEAS(Atmo(hp: 37844, temperature: -24)),
        closeTo(158.1, 0.1));
    // TAS -> EAS in ft/s unit and at ISA+33F
    expect(
        Speed(value: 337.6, type: SpeedType.tas, unitSpeed: SpeedUnit.fps)
            .toEAS(Atmo(
                hp: 16543,
                temperature: 33,
                unitTemperature: TemperatureUnit.F)),
        closeTo(252.2, 0.1));
    // Mach -> EAS
    expect(
        Speed(value: 0.6385, type: SpeedType.mach).toEAS(
            Atmo(hp: 10075.5, temperature: 0, unitAltitude: LengthUnit.m)),
        closeTo(214.5, 0.1));
  });

  test('Speed class conversion to TAS', () {
    // CAS -> TAS in knots unit and at ISA
    expect(
        Speed(value: 148.7, type: SpeedType.cas)
            .toTAS(Atmo(hp: 6944, temperature: 0)),
        closeTo(164.7, 0.1));
    // CAS -> TAS in mph unit and at ISA+17C
    expect(
        Speed(value: 281.7, type: SpeedType.cas, unitSpeed: SpeedUnit.mph)
            .toTAS(Atmo(hp: 37844, temperature: 17)),
        closeTo(529.2, 0.1));
    // EAS -> TAS in knots and at ISA-24F
    expect(
        Speed(value: 285.3, type: SpeedType.eas).toTAS(Atmo(
            hp: 23030, temperature: -24, unitTemperature: TemperatureUnit.F)),
        closeTo(400.2, 0.1));
    // EAS -> TAS in m/s unit and at ISA+33C
    expect(
        Speed(value: 90, type: SpeedType.eas, unitSpeed: SpeedUnit.mps)
            .toTAS(Atmo(hp: 16543, temperature: 33)),
        closeTo(123.6, 0.1));
    // Mach -> TAS in ISA+11F
    expect(
        Speed(value: 0.8474, type: SpeedType.mach)
            .toTAS(Atmo(hp: 47854, temperature: 11)),
        closeTo(498.2, 0.1));
    // TAS -> TAS
    expect(
        Speed(value: 333.0, type: SpeedType.tas, unitSpeed: SpeedUnit.mph)
            .toTAS(Atmo(
                hp: 8888.0,
                temperature: 33,
                unitAltitude: LengthUnit.m,
                unitTemperature: TemperatureUnit.F,
                temperatureIsDeltaISA: true)),
        closeTo(333.0, 0.1));
  });

  test('Speed class conversion to Mach', () {
    // CAS -> Mach in knots unit and at ISA
    expect(
        Speed(value: 148.7, type: SpeedType.cas)
            .toMach(Atmo(hp: 6944, temperature: 0)),
        closeTo(0.2552, 0.0001));
    // CAS -> Mach in mph unit
    expect(
        Speed(value: 281.7, type: SpeedType.cas, unitSpeed: SpeedUnit.mph)
            .toMach(Atmo(hp: 37844, temperature: 0)),
        closeTo(0.7721, 0.0001));
    // EAS -> Mach in knots and at ISA-24F
    expect(
        Speed(value: 285.3, type: SpeedType.eas)
            .toMach(Atmo(hp: 23030, temperature: 0)),
        closeTo(0.6785, 0.0001));
    // TAS -> Mach in m/s unit and at ISA+33C
    expect(
        Speed(value: 387.4, type: SpeedType.tas, unitSpeed: SpeedUnit.mps)
            .toMach(Atmo(hp: 38495, temperature: -23)),
        closeTo(1.389, 0.001));
    // TAS -> Mach in ISA+11F
    expect(
        Speed(value: 513.4, type: SpeedType.tas).toMach(Atmo(
            hp: 39000, temperature: 21, unitTemperature: TemperatureUnit.F)),
        closeTo(0.8719, 0.0001));
  });

  test('Speed unit conversion on Speed object', () {
    // Knots to ft/sec
    expect(
        Speed(value: 148.7, type: SpeedType.cas)
            .convertSpeed(SpeedUnit.kts, SpeedUnit.fps),
        closeTo(251.0, 0.1));
    // ft/sec to m/s
    expect(
        Speed(value: 148.7, type: SpeedType.cas, unitSpeed: SpeedUnit.fps)
            .convertSpeed(SpeedUnit.fps, SpeedUnit.mps),
        closeTo(45.3, 0.1));
    // km/h to mph
    expect(
        Speed(value: 148.7, type: SpeedType.cas, unitSpeed: SpeedUnit.kmh)
            .convertSpeed(SpeedUnit.kmh, SpeedUnit.mph),
        closeTo(92.4, 0.1));
  });

  test('Speed unit conversion on a double speed value', () {
    // Knots to ft/sec
    double speedKnots = 147.8;
    expect(speedKnots.convertSpeed(SpeedUnit.kts, SpeedUnit.fps),
        closeTo(249.5, 0.1));
  });
}
