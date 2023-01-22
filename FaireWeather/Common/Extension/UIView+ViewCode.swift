//
//  UIView+ViewCode.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 21/01/2023.
//

import UIKit

extension UIView {
	@discardableResult
	func viewCodable() -> Self {
		translatesAutoresizingMaskIntoConstraints = false
		return self
	}
}
