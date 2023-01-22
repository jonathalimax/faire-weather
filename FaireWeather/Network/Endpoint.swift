//
//  FaireAPI.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 20/01/2023.
//

import Foundation

enum Endpoint {
	case weather(city: String)
	case weatherImage(name: String)
}

extension Endpoint {
	private var baseURL: URL {
		guard
			let baseString = Bundle.main.infoDictionary?["BASE_URL"] as? String,
			let url = URL(string: baseString)
		else {
			fatalError("Missing base url in the project")
		}

		return url
	}

	private var path: String {
		switch self {
		case let .weather(city): return "\(city).json"
		case let .weatherImage(name): return "icons/\(name).png"
		}
	}

	var url: URL { baseURL.appending(component: path) }
}
