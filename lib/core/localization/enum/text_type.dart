enum TextType {
  weather('WEATHER'),
  currentWeather('CURRENT_WEATHER'),
  details('DETAILS'),
  weatherDetails('WEATHER_DETAILS'),
  refresh('REFRESH'),
  settings('SETTINGS'),
  location('LOCATION'),
  temperature('TEMPERATURE'),
  temperatureFeelsLike('TEMPERATURE_FEELS_LIKE'),
  temperatureMin('TEMPERATURE_MIN'),
  temperatureMax('TEMPERATURE_MAX'),
  wind('WIND'),
  pressure('PRESSURE'),
  humidity('HUMIDITY'),
  seaLevelPressure('SEA_LEVEL_PRESSURE'),
  groundLevelPressure('GROUND_LEVEL_PRESSURE'),
  profileSettings('PROFILE_SETTINGS'),
  profileSettingsTip('PROFILE_SETTINGS_TIP'),
  locationSettings('LOCATION_SETTINGS'),
  locationSettingsTip('LOCATION_SETTINGS_TIP'),
  about('ABOUT'),
  aboutTip('ABOUT_TIP'),
  menu('MENU'),
  options('OPTIONS'),
  celsius('CELSIUS'),
  percentage('PERCENTAGE'),
  windSpeedMagnitude('WIND_SPEED_MAGNITUDE'),
  pressureMagnitude('PRESSURE_MAGNITUDE');

  final String name;

  const TextType(this.name);
}
