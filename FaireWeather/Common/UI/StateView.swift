//
//  StateView.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 21/01/2023.
//

import UIKit

class StateView: UIView {
	private(set) var state: State
	private var tryAgainCompletion: (() -> Void)?

	private lazy var loaderView: UIActivityIndicatorView = {
		let loaderView = UIActivityIndicatorView(style: .large)
		loaderView.startAnimating()
		loaderView.isHidden = true
		return loaderView
	}()

	private lazy var contentStack: UIStackView = {
		let stackView = UIStackView().viewCodable()
		stackView.axis = .vertical
		stackView.spacing = 16
		return stackView
	}()

	private var titleLabel: UILabel = {
		let label = UILabel()
		label.font = .preferredFont(forTextStyle: .headline)
		label.numberOfLines = 0
		label.textAlignment = .center
		label.isHidden = true
		return label
	}()

	private lazy var tryAgainButton: UIButton = {
		let button = UIButton(primaryAction: UIAction { [weak self] _ in self?.tryAgainCompletion?() })
		button.setTitle("Tentar novamente", for: .normal)
		button.isHidden = true
		return button
	}()

	init(_ state: State) {
		self.state = state
		super.init(frame: .zero)

		addSubviews()
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateState(_ state: State) {
		self.state = state

		switch state {
		case let .error(title, completion):
			titleLabel.text = title
			loaderView.isHidden = true
			[titleLabel, tryAgainButton].forEach { $0.isHidden = false }
			tryAgainCompletion = completion

		case .loading:
			loaderView.isHidden = false
			[titleLabel, tryAgainButton].forEach { $0.isHidden = true }

		case let .empty(title):
			titleLabel.text = title
			titleLabel.isHidden = false
			[loaderView, tryAgainButton].forEach { $0.isHidden = true }

		case .success: break
		}

		// TODO: DO I need this?
		// self.layoutIfNeeded()
	}

	private func addSubviews() {
		[loaderView, titleLabel, tryAgainButton].forEach(contentStack.addArrangedSubview)
		addSubview(contentStack)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			contentStack.centerYAnchor.constraint(equalTo: centerYAnchor),
			contentStack.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor, constant: 20),
			contentStack.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -20),
		])
	}
}

// MARK: - State
extension StateView {
	enum State {
		case loading
		case error(title: String, tryAgainCompletion: (() -> Void))
		case empty(title: String)
		case success
	}
}
