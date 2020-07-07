//
//  HomeCoordinator.swift
//  GCAddonsExamplesPlayground
//
//  Created by Guy Cohen on 06/07/2020.
//  Copyright © 2020 GCAddons. All rights reserved.
//

import Foundation
import GCAddonsCollection
import UIKit

class HomeCoordinator: GCCoordinatorChild {
    
    let navigation: UINavigationController
    var homeViewController: HomeViewController?
    
    required init(_ navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let homeViewModel = HomeViewModel()
        homeViewController = HomeViewController(viewModel: homeViewModel)
        self.navigation.pushViewController(homeViewController!, animated: true)
    }
    
    
}
