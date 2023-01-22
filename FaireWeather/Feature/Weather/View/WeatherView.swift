//
//  WeatherView.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 21/01/2023.
//

import Kingfisher
import UIKit

class WeatherView: UIView {
	private var contentStackView: UIStackView = {
		let stackView = UIStackView().viewCodable()
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.alignment = .center
		return stackView
	}()

	// MARK: Current temperature
	private var temperatureStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 12
		return stackView
	}()

	private var illustration: UIImageView = {
		let imageView = UIImageView().viewCodable()
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()

	private var temperatureLabel: UILabel = {
		let label = UILabel()
		label.font = UIFontMetrics(forTextStyle: .largeTitle)
			.scaledFont(for: .systemFont(ofSize: 74, weight: .regular))
		return label
	}()

	private var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = UIFontMetrics(forTextStyle: .headline)
			.scaledFont(for: .systemFont(ofSize: 18, weight: .regular))
		return label
	}()

	// MARK: Temperature variation
	private var variationStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 8
		return stackView
	}()

	private var lowerTemperatureLabel: UILabel = {
		let label = UILabel()
		label.font = UIFontMetrics(forTextStyle: .headline)
			.scaledFont(for: .systemFont(ofSize: 26, weight: .medium))
		return label
	}()

	private var highestTemperatureLabel: UILabel = {
		let label = UILabel()
		label.font = UIFontMetrics(forTextStyle: .headline)
			.scaledFont(for: .systemFont(ofSize: 26, weight: .medium))
		return label
	}()

	init() {
		super.init(frame: .zero)

		addViews()
		setupConstraints()
	}

	required init?(coder: NSCoder) { fatalError("use init() instead") }

	private func addViews() {
		[illustration, temperatureLabel].forEach(temperatureStackView.addArrangedSubview)
		[lowerTemperatureLabel, highestTemperatureLabel].forEach(variationStackView.addArrangedSubview)
		[temperatureStackView, descriptionLabel, variationStackView].forEach(contentStackView.addArrangedSubview)

		addSubview(contentStackView)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			contentStackView.centerXAnchor.constraint(equalTo: centerXAnchor),

			illustration.widthAnchor.constraint(equalToConstant: 80),
			illustration.heightAnchor.constraint(equalToConstant: 80),
		])
	}

	func setup(_ info: Weather.Info, imageUrl: URL) {
		temperatureLabel.text = String(format: "%.0f°", info.temperature)
		descriptionLabel.text = info.stateName
		lowerTemperatureLabel.text = String(format: "L: %.0f°", info.minimumTemperature)
		highestTemperatureLabel.text = String(format: "H: %.0f°", info.maximumTemperature)

		illustration.kf.indicatorType = .activity
		illustration.kf.setImage(with: imageUrl)
	}
}
