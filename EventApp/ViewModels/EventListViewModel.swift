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
    
    private var coreDataManager = CoreDataManager()
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
        let events = coreDataManager.fetchEvents()
        cells = events.map {
            .event(EventCellViewModel($0))
        }
        
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
