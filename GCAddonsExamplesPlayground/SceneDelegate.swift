//
//  SceneDelegate.swift
//  GCAddonsExamplesPlayground
//
//  Created by Guy Cohen on 19/06/2020.
//  Copyright © 2020 GCAddons. All rights reserved.
//

import UIKit
import GCAddonsCollection

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var app: GCApplicationCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        app = GCApplicationCoordinator(window, firstSubCoordinator: HomeCoordinator.self)
        app?.start()
    }

}

