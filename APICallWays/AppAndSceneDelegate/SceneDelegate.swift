//
//  SceneDelegate.swift
//  APICallWays
//
//  Created by M1 on 30.11.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let service = EClosureService()
        let viewModel = EClosureViewModel(dataService: service)
        let viewController = EClosureView(viewModel: viewModel)
        // let service = CombineService()
        // let viewModel = CombineViewModel(combineService: service)
        // let viewController = CombineView(viewModel: viewModel)
        // let service = AsyncAwaitService()
        // let viewModel = AsyncAwaitViewModel(asyncAwaitService: service)
        // let viewController = AsyncAwaitView(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    
    
}
