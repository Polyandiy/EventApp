//
//  AppCoordinator.swift
//  EventApp
//
//  Created by Поляндий on 26.09.2022.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get }
    
    func start()
}


final class AppCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        let eventListCoordinator = EventListCoordinator(navigationController: navigationController)
        childCoordinators.append(eventListCoordinator)
        eventListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
