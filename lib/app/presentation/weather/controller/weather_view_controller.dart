import 'package:clean_architecture/app/domain/weather/model/all_weather_info_dto.dart';
import 'package:clean_architecture/app/domain/weather/model/weather_request_dto.dart';
import 'package:clean_architecture/core/animation/constants/animation_constants.dart';
import 'package:clean_architecture/config/app_config.dart';
import 'package:clean_architecture/app/domain/weather/usecase/get_all_weather_info_usecase.dart';
import 'package:clean_architecture/core/error/model/failure.dart';
import 'package:clean_architecture/core/loading/provider/loading_provider.dart';
import 'package:clean_architecture/core/log/extension/log_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherViewState {
  final AllWeatherInfoDTO? allWeatherInfoDTO;

  const WeatherViewState({required this.allWeatherInfoDTO});

  /// Creates a copy of this class.
  WeatherViewState copyWith({AllWeatherInfoDTO? allWeatherInfoDTO}) {
    return WeatherViewState(
      allWeatherInfoDTO: allWeatherInfoDTO ?? this.allWeatherInfoDTO,
    );
  }
}

class WeatherViewController extends StateNotifier<WeatherViewState> {
  final GetAllWeatherInfoUsecase _getAllWeatherInfoUsecase;

  WeatherViewController({
    required GetAllWeatherInfoUsecase getAllWeatherInfoUsecase,
  })  : _getAllWeatherInfoUsecase = getAllWeatherInfoUsecase,
        super(const WeatherViewState(allWeatherInfoDTO: null));

  /// Getter for [allWeatherInfoDTO].
  AllWeatherInfoDTO? get allWeatherInfoDTO => state.allWeatherInfoDTO;

  /// Setter for [allWeatherInfoDTO].
  set allWeatherInfoDTO(AllWeatherInfoDTO? allWeatherInfoDTO) => state = state.copyWith(allWeatherInfoDTO: allWeatherInfoDTO);

  /// Resets the state.
  void resetState() => state = const WeatherViewState(allWeatherInfoDTO: null);

  /// Fetches weather information.
  Future<void> fetchAllWeatherInfo({required WidgetRef? ref}) async {
    final loadingController = ref?.read(LoadingProvider.loadingControllerProvider.notifier);
    const WeatherRequestDTO weatherRequestDTO = WeatherRequestDTO(
      latitude: 41.015137,
      longitude: 28.979530,
      languageCode: 'tr',
      units: 'metric',
      apiKey: AppConfig.apiKey,
    );

    try {
      loadingController?.isLoading = true;
      final AllWeatherInfoDTO? allWeatherInfoDTO = await _getAllWeatherInfoUsecase.execute(weatherRequestDTO: weatherRequestDTO);
      state = state.copyWith(allWeatherInfoDTO: allWeatherInfoDTO);
    } on Failure catch (failure) {
      state = state.copyWith(allWeatherInfoDTO: null);
      StackTrace.current.printErrorMessageByFailure(failure: failure);
    } finally {
      await Future.delayed(const Duration(milliseconds: AnimationConstants.loadingAnimationExtraDelayDurationMS));
      loadingController?.isLoading = false;
    }
  }
}
