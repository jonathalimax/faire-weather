//
//  WeatherPresenter.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 21/01/2023.
//

import Foundation

protocol WeatherViewDelegate: AnyObject {
	@MainActor func performUpdate(_ update: WeatherPresenter.Update)
}

class WeatherPresenter {
	weak var delegate: WeatherViewDelegate?
	private var service: WeatherService
	private var weather: Weather?
	private var selectedWeatherInfo: Weather.Info?

	init(service: WeatherService = .live()) {
		self.service = service
	}

	func performAction(_ action: Action) async {
		switch action {
		case let .fetchWeather(cityCode):
			do {
				await delegate?.performUpdate(.setLoadingState)

				let weather = try await service.fetchInfo(cityCode)
				self.weather = weather

				guard let weatherInfo = weather.consolidatedWeather.first else {
					await delegate?.performUpdate(.setEmptyState)
					return
				}

				selectedWeatherInfo = weatherInfo

				await delegate?.performUpdate(
					.setWeather(title: weather.title, info: weatherInfo, imageUrl: weatherInfo.imageUrl)
				)
			} catch {
				await delegate?.performUpdate(.setErrorState)
			}

		case .seeOtherDay:
			guard
				let weather,
				let selectedWeatherInfo,
				let nextWeatherInfo = weather.consolidatedWeather.element(after: selectedWeatherInfo)
			else { return }

			self.selectedWeatherInfo = nextWeatherInfo

			await delegate?.performUpdate(
				.setWeather(title: weather.title, info: nextWeatherInfo, imageUrl: nextWeatherInfo.imageUrl)
			)
		}
	}
}

extension WeatherPresenter {
	// MARK: - Action
	enum Action {
		case fetchWeather(cityCode: String)
		case seeOtherDay
	}

	// MARK: - Update
	enum Update: Equatable {
		case setLoadingState
		case setEmptyState
		case setErrorState
		case setWeather(title: String, info: Weather.Info, imageUrl: URL)
	}
}

// MARK: - Helper
private extension [Weather.Info] {
	func element(after current: Element) -> Element? {
		guard let currentIndex = firstIndex(of: current) else { return nil }
		let nextIndex = currentIndex == endIndex - 1 ? .zero : currentIndex + 1

		return indices.contains(nextIndex) ? self[nextIndex] : nil
	}
}

private extension Weather.Info {
	var imageUrl: URL { Endpoint.weatherImage(name: stateAbbreviation).url }
}
