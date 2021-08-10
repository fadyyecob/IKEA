//
//  SceneDelegate.swift
//  IKEA
//
//  Created by Fady Yecob on 09/08/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private let appRepository = AppRepository()
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        self.window = makeWindow(windowScene: windowScene)
    }
    
    private func makeWindow(windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        
        let tabBarViewModel = TabBarViewModel(appRepository: appRepository)
        window.rootViewController = TabBarController(viewModel: tabBarViewModel)
        window.makeKeyAndVisible()
        return window
    }
}

