//
//  WeatherPresenterSpec.swift
//  FaireWeatherTests
//
//  Created by Jonatha Lima on 21/01/2023.
//

import Quick
import Nimble
import Foundation

@testable import FaireWeather

class WeatherPresenterSpec: QuickSpec {
	override func spec() {
		describe("weather presenter") {
			var sut: WeatherPresenter!
			var serviceMock: WeatherService!
			var viewDelegateStub: WeatherViewDelegateStub!

			beforeEach {
				serviceMock = .init(fetchInfo: { _ in .mock })
				viewDelegateStub = .init()
				self.setSut(&sut, service: serviceMock, delegateStub: viewDelegateStub)
			}

			afterEach {
				serviceMock = nil
				viewDelegateStub = nil
				sut = nil
			}

			context("fetch weather") {
				context("when fetched successfully") {
					it("should set the weather data") {
						await sut.performAction(.fetchWeather(cityCode: "1234"))
						expect(viewDelegateStub.log).to(equal([.setLoadingState, .setFirstWeather]))
					}
				}

				context("when fetched without the weather information") {
					beforeEach {
						serviceMock = .init(fetchInfo: { _ in .empty })
						viewDelegateStub = .init()
						self.setSut(&sut, service: serviceMock, delegateStub: viewDelegateStub)
					}

					it("should set the empty state") {
						await sut.performAction(.fetchWeather(cityCode: "1234"))
						expect(viewDelegateStub.log).to(equal([.setLoadingState, .setEmptyState]))
					}
				}

				context("when failure fetching") {
					beforeEach {
						serviceMock = .init(fetchInfo: { _ in throw NSError() })
						viewDelegateStub = .init()
						self.setSut(&sut, service: serviceMock, delegateStub: viewDelegateStub)
					}

					it("should set the error state") {
						await sut.performAction(.fetchWeather(cityCode: "1234"))
						expect(viewDelegateStub.log).to(equal([.setLoadingState, .setErrorState]))
					}
				}
			}

			context("see other day") {
				context("when anothers information is requested") {
					beforeEach {
						await sut.performAction(.fetchWeather(cityCode: "1234"))
						viewDelegateStub.log.removeAll()
					}

					it("should set the new weather day information") {
						await sut.performAction(.seeOtherDay)
						await sut.performAction(.seeOtherDay)
						expect(viewDelegateStub.log).to(equal([.setSecondWeather, .setFirstWeather]))
					}
				}
			}
		}
	}

	func setSut(
		_ sut: inout WeatherPresenter?,
		service: WeatherService,
		delegateStub: WeatherViewDelegateStub
	) {
		sut = WeatherPresenter(service: service)
		sut?.delegate = delegateStub
	}
}

extension WeatherPresenter.Update {
	static var setFirstWeather: Self {
		.setWeather(
			title: "São Paulo",
			info: .init(
				stateName: "Light Rain",
				stateAbbreviation: "lr",
				temperature: 18,
				minimumTemperature: 12,
				maximumTemperature: 20
			)
		)
	}

	static var setSecondWeather: Self {
		.setWeather(
			title: "São Paulo",
			info: .init(
				stateName: "Showers",
				stateAbbreviation: "s",
				temperature: 12,
				minimumTemperature: 8,
				maximumTemperature: 28
			)
		)
	}
}
