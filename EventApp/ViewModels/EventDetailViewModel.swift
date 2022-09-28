//
//  EventDetailViewModel.swift
//  EventApp
//
//  Created by Поляндий on 28.09.2022.
//

import Foundation
import UIKit
import CoreData

final class EventDetailViewModel {
    
    private var eventID: NSManagedObjectID
    private let coreDataManager: CoreDataManager
    private var event: Event?
    private let date = Date()
    var coordinator: EventDetailCoordinator?
    var onUpdate = {}
    
    var image: UIImage? {
        guard let imageData = event?.image else { return nil }
        return UIImage(data: imageData)
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event?.date,
              let timeRemaningParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else {return nil}
        return TimeRemainingViewModel(timeRemainingParts: timeRemaningParts, mode: .detail)
    }
    
    init(eventID: NSManagedObjectID, coreDataMnager: CoreDataManager = .shared) {
        self.eventID = eventID
        self.coreDataManager = coreDataMnager
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func reload() {
        event = coreDataManager.getEvent(eventID)
        onUpdate()
    }
    
    @objc func editButtonTapped() {
        guard let event = event else { return }
        coordinator?.onEditEvent(event: event)
    }
}
