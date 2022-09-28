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
        EventCellViewModel.imageCache.removeAllObjects()
        let events = coreDataManager.fetchEvents()
        cells = events.map {
            var eventCellViewModel  = EventCellViewModel($0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            return .event(eventCellViewModel)
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
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}
