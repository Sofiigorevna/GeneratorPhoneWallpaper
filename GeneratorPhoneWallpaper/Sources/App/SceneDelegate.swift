//
//  SceneDelegate.swift
//  GeneratorPhoneWallpaper
//
//  Created by 1234 on 25.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: windowScene)
            let viewController = GeneratorViewController()
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }
}

