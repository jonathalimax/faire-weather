//
//  SceneDelegate.swift
//  FaireWeather
//
//  Created by Jonatha Lima on 20/01/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let weatherViewController = WeatherViewController()
		let rootController = UINavigationController(rootViewController: weatherViewController)

		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = rootController
		window?.backgroundColor = .white
		window?.makeKeyAndVisible()
	}
}
