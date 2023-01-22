//
//  WeatherController.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 20/01/2023.
//

import UIKit

class WeatherViewController: UIViewController {
	private var presenter: WeatherPresenter
	private var weatherView = WeatherView()

	init(presenter: WeatherPresenter = .init()) {
		self.presenter = presenter

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("Use init(presenter:) instead")
	}

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()

		view = weatherView
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		presenter.delegate = self
		navigationController?.navigationBar.prefersLargeTitles = true

		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTouched))
		weatherView.addGestureRecognizer(tapGesture)

		Task { await presenter.performAction(.fetchWeather(cityCode: .torontoCode)) }
	}

	@objc
	private func viewTouched() {
		Task { await presenter.performAction(.seeOtherDay) }
	}
}

// MARK: - WeatherViewDelegate
extension WeatherViewController: WeatherViewDelegate {
	func performUpdate(_ update: WeatherPresenter.Update) {
		switch update {
		case .setLoadingState:
			setState(.loading)

		case .setEmptyState:
			setState(.empty(title: "The weather is unnavailable for now!"))

		case .setErrorState:
			setState(
				.error(
					title: "Sorry!\nSomething went wrong",
					tryAgainCompletion: { [weak self] in
						Task { await self?.presenter.performAction(.fetchWeather(cityCode: .torontoCode)) }
					}
				)
			)

		case let .setWeather(title, info, imageUrl):
			self.title = title
			setState(.success)
			weatherView.setup(info, imageUrl: imageUrl)
		}
	}
}

// MARK: - Helpers
private extension String {
	static let torontoCode: Self = "4418"
}
