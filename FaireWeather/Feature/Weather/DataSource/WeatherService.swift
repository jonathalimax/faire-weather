//
//  WeatherService.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 20/01/2023.
//

import Alamofire

struct WeatherService {
	let fetchInfo: (_ cityCode: String) async throws -> Weather
}

extension WeatherService {
	static func live(session: Session = .default) -> Self {
		.init(
			fetchInfo: { cityCode in
				return try await session.request(Endpoint.weather(city: cityCode).url)
					.serializingDecodable(Weather.self).value
			}
		)
	}
}
