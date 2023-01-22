//
//  Weater+Mock.swift
//  FaireWeatherTests
//
//  Created by Jonatha Lima on 21/01/2023.
//

@testable import FaireWeather

extension Weather {
	static var mock: Self {
		.init(title: "São Paulo", consolidatedWeather: .mock)
	}

	static var empty: Self {
		.init(title: "", consolidatedWeather: [])
	}

	static var json: String {
		"""

		"""
	}
}

extension [Weather.Info] {
	static var mock: Self {
		[
			.init(stateName: "Light Rain", stateAbbreviation: "lr", temperature: 18, minimumTemperature: 12, maximumTemperature: 20),
			.init(stateName: "Showers", stateAbbreviation: "s", temperature: 12, minimumTemperature: 8, maximumTemperature: 28),
		]
	}
}
