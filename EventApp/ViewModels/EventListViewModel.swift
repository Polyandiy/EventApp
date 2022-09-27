//
//  EventListViewModel.swift
//  EventApp
//
//  Created by Поляндий on 26.09.2022.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    
    var coordinator: EventListCoordinator?
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
}
