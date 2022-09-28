//
//  EventDedailCoordinator.swift
//  EventApp
//
//  Created by Поляндий on 28.09.2022.
//

import Foundation
import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID
    var parentCoordinator: EventListCoordinator?
    var onUpdateEvent = {}
    
    init(eventID: NSManagedObjectID, navigationController: UINavigationController) {
        self.eventID = eventID
        self.navigationController = navigationController
    }
    
    func start() {
        let detailViewController: EventDetailViewController = .instantiate()
        let eventDetailViewModel = EventDetailViewModel(eventID: eventID)
        eventDetailViewModel.coordinator = self
        onUpdateEvent = {
            eventDetailViewModel.reload()
            self.parentCoordinator?.onUpdateEvent()
        }
        detailViewController.viewModel = eventDetailViewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func onEditEvent(event: Event) {
        let editEventCoordinator = EditEventCoordinator(event: event, navigationController: navigationController)
        editEventCoordinator.parentCoordinator = self
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool
            in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}

