//
//  Weather.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 20/01/2023.
//

import Foundation

struct Weather: Codable, Equatable {
	let title: String
	let consolidatedWeather: [Info]

	enum CodingKeys: String, CodingKey {
		case title
		case consolidatedWeather = "consolidated_weather"
	}
}

extension Weather {
	struct Info: Codable, Equatable {
		let stateName: String
		let stateAbbreviation: String
		let temperature: Float
		let minimumTemperature: Float
		let maximumTemperature: Float

		enum CodingKeys: String, CodingKey {
			case stateName = "weather_state_name"
			case stateAbbreviation = "weather_state_abbr"
			case temperature = "the_temp"
			case minimumTemperature = "min_temp"
			case maximumTemperature = "max_temp"
		}
	}
}

