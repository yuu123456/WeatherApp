//
//  SceneDelegate.swift
//  WeatherApp
//

//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    // UINavigationController型の変数宣言
    var navigationController: UINavigationController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }

        // UINavigationControllerの生成（これがないと、プッシュ遷移できない）
        let viewController: UIViewController = SplashViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        self.window = UIWindow(windowScene: scene as! UIWindowScene)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()

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

}
