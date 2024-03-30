import 'package:clean_architecture/config/app_icons.dart';
import 'package:clean_architecture/core/error/enum/client/client_exception_type.dart';
import 'package:clean_architecture/core/error/model/client_failure.dart';
import 'package:flutter/material.dart';

enum WeatherConditionType {
  // Thunderstorms
  thunderstormWithLightRain(200, AppIcons.stormyWeatherIcon),
  thunderstormWithRain(201, AppIcons.stormyWeatherIcon),
  thunderstormWithHeavyRain(202, AppIcons.stormyWeatherIcon),
  heavyThunderstorm(230, AppIcons.stormyWeatherIcon),
  raggedThunderstorm(231, AppIcons.stormyWeatherIcon),
  thunderstormWithLightDrizzle(232, AppIcons.stormyWeatherIcon),
  thunderstormWithHeavyDrizzle(233, AppIcons.stormyWeatherIcon),
  thunderstormWithHail(234, AppIcons.stormyWeatherIcon),

  // Drizzle
  lightIntensityDrizzle(300, AppIcons.drizzleWeatherIcon),
  drizzle(301, AppIcons.drizzleWeatherIcon),
  heavyIntensityDrizzle(302, AppIcons.drizzleWeatherIcon),
  lightIntensityDrizzleRain(303, AppIcons.drizzleWeatherIcon),
  drizzleRain(304, AppIcons.drizzleWeatherIcon),
  heavyIntensityDrizzleRain(305, AppIcons.drizzleWeatherIcon),
  freezingDrizzle(306, AppIcons.drizzleWeatherIcon),
  lightIntensityFrozenDrizzle(307, AppIcons.drizzleWeatherIcon),
  heavyIntensityFrozenDrizzle(308, AppIcons.drizzleWeatherIcon),

  // Rain
  showerRain(400, AppIcons.rainyWeatherIcon),
  lightRain(401, AppIcons.rainyWeatherIcon),
  moderateRain(402, AppIcons.rainyWeatherIcon),
  heavyIntensityRain(403, AppIcons.rainyWeatherIcon),
  veryHeavyRain(404, AppIcons.rainyWeatherIcon),
  extremeHeavyRain(405, AppIcons.rainyWeatherIcon),
  freezingRain(406, AppIcons.rainyWeatherIcon),
  lightIntensityFrozenRain(407, AppIcons.rainyWeatherIcon),
  heavyIntensityFrozenRain(408, AppIcons.rainyWeatherIcon),
  lightIntensityShowerRain(409, AppIcons.rainyWeatherIcon),
  heavyIntensityShowerRain(410, AppIcons.rainyWeatherIcon),

  // Snow
  snow(500, AppIcons.snowyWeatherIcon),
  lightSnow(501, AppIcons.snowyWeatherIcon),
  snowMist(502, AppIcons.snowyWeatherIcon),
  heavySnow(503, AppIcons.snowyWeatherIcon),
  snowGraupel(504, AppIcons.snowyWeatherIcon),
  lightShowerSnow(505, AppIcons.snowyWeatherIcon),
  heavyShowerSnow(506, AppIcons.snowyWeatherIcon),
  rainAndSnow(511, AppIcons.snowyWeatherIcon),
  lightRainAndSnow(512, AppIcons.snowyWeatherIcon),
  heavyRainAndSnow(513, AppIcons.snowyWeatherIcon),

  // Freezing Rain
  freezingRainLightIntensity(600, AppIcons.freezingWeatherIcon),
  freezingRainModerateIntensity(601, AppIcons.freezingWeatherIcon),
  freezingRainHeavyIntensity(602, AppIcons.freezingWeatherIcon),
  freezingRainMixedWithSnowLightIntensity(611, AppIcons.freezingWeatherIcon),
  freezingRainMixedWithSnowModerateIntensity(612, AppIcons.freezingWeatherIcon),
  freezingRainMixedWithSnowHeavyIntensity(613, AppIcons.freezingWeatherIcon),

  // Atmospheric
  mist(701, AppIcons.foggyWeatherIcon),
  smoke(711, AppIcons.foggyWeatherIcon),
  volcanicAsh(715, AppIcons.volcanicWeatherIcon),
  squalls(761, AppIcons.stormyWeatherIcon),
  tornado(781, AppIcons.stormyWeatherIcon),
  tropicalStorm(790, AppIcons.stormyWeatherIcon),
  hurricane(791, AppIcons.stormyWeatherIcon),

  // Extreme Weather
  cold(900, AppIcons.snowyWeatherIcon),
  hot(901, AppIcons.sunnyWeatherIcon),
  equinox(902, AppIcons.sunnyWeatherIcon),
  tornadoWarning(903, AppIcons.warningIcon),
  hurricaneWarning(904, AppIcons.warningIcon),
  severeThunderstormWarning(905, AppIcons.warningIcon),
  winterStormWarning(906, AppIcons.warningIcon),
  heavySnowWarning(907, AppIcons.warningIcon),
  iceStormWarning(908, AppIcons.warningIcon),
  mixedRainAndSnowWarning(909, AppIcons.warningIcon),
  flashFloodWarning(910, AppIcons.warningIcon),
  thunderstormWarning(911, AppIcons.warningIcon),
  specialWeatherStatements(912, AppIcons.warningIcon),

  // Clear and Cloudy
  clearSky(800, AppIcons.sunnyWeatherIcon),
  fewClouds(801, AppIcons.sunnyWeatherIcon),
  scatteredClouds(802, AppIcons.cloudyWeatherIcon),
  brokenClouds(803, AppIcons.cloudyWeatherIcon),
  overcastClouds(804, AppIcons.cloudyWeatherIcon);

  final int weatherConditionCode;

  final IconData weatherIcon;

  const WeatherConditionType(this.weatherConditionCode, this.weatherIcon);

  /// Creates a [WeatherConditionType] from [weatherConditionCode].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  static WeatherConditionType? getWeatherConditionByCode({required int? weatherConditionCode}) {
    try {
      return WeatherConditionType.values.firstWhere((condition) => condition.weatherConditionCode == weatherConditionCode);
    } catch (ex) {
      throw ClientFailure.createAndLog(
        stackTrace: StackTrace.current,
        exception: ex,
        clientExceptionType: ClientExceptionType.enumNotFoundError,
      );
    }
  }
}
