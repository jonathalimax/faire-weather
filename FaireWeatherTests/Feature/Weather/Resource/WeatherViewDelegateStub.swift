//
//  WeatherViewDelegateStub.swift
//  FaireWeatherTests
//
//  Created by Jonatha Lima on 21/01/2023.
//

@testable import FaireWeather

class WeatherViewDelegateStub: WeatherViewDelegate {
	var log = [WeatherPresenter.Update]()

	func performUpdate(_ update: WeatherPresenter.Update) {
		log.append(update)
	}
}
