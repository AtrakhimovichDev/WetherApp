//
//  SceneDelegate.swift
//  WetherApp
//
//  Created by Andrei Atrakhimovich on 29.07.21.
//

import UIKit
import Alamofire

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        let rootVC = createViewController()
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

    private func createViewController() -> UIViewController {
        var rootVC = UIViewController()
        if NetworkManager.checkNetworkConnection() {
            rootVC = ViewControllerFactory.viewController(for: .mainWether)
        } else {
            rootVC = ViewControllerFactory.viewController(for: .errorNetworkConnection)
        }
        return rootVC
    }
}
