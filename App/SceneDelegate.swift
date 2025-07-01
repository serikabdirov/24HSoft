//
//  SceneDelegate.swift
//  Test_24HSoft
//
//  Created by Серик Абдиров on 01.07.2025.
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

        let window = UIWindow(windowScene: windowScene)
        let rootVC = PhotoListFactory().build()
        let navVC = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navVC
        self.window = window
        window.makeKeyAndVisible()
    }
}
