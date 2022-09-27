//
//  EventListViewModel.swift
//  EventApp
//
//  Created by Поляндий on 26.09.2022.
//

import Foundation

final class EventListViewModel {
    
    let title = "Events"
    enum Cell {
        case event(EventCellViewModel)
    }
    
    var coordinator: EventListCoordinator?
    private(set) var cells: [Cell] = []
    var onUpdate = {}
    
    func viewDidLoad() {
        cells = [.event(EventCellViewModel()), .event(EventCellViewModel())]
        onUpdate()
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
}
