//
//  SceneDelegate.swift
//  Photo Redactor
//
//  Created by Артур on 12.08.2024.
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
        self.window = UIWindow(windowScene: windowScene)
        let rootVC = MainBuilder.build()
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }
}

