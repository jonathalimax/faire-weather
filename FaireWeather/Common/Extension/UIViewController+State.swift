//
//  UIViewController+State.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 21/01/2023.
//

import UIKit

extension UIViewController {
	private var currentStateView: StateView? {
		view.subviews.compactMap { $0 as? StateView }.first
	}

	func setState(_ state: StateView.State) {
		let stateView = currentStateView ?? StateView(state)

		if currentStateView == nil {
			stateView.viewCodable()
			view.addSubview(stateView)

			NSLayoutConstraint.activate([
				stateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				stateView.topAnchor.constraint(equalTo: view.topAnchor),
				stateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				stateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			])
		}

		switch state {
		case .loading, .error, .empty:
			stateView.updateState(state)
		case .success:
			stateView.removeFromSuperview()
		}
	}
}
