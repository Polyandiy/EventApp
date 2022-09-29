//
//  EventCellViewModel.swift
//  EventApp
//
//  Created by Поляндий on 27.09.2022.
//

import Foundation
import UIKit
import CoreData

struct EventCellViewModel {
    
    let date = Date()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    static let imageCache = NSCache<NSString, UIImage>()
    private var cacheKey: String {
        event.objectID.description
    }
    var onSelect: (NSManagedObjectID) -> Void = { _ in }
    
    private let event: Event
    
    init(_ event: Event) {
        self.event = event
    }
    
    var dateText: String? {
        guard let eventDate = event.date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: eventDate)
    }
    var eventName: String? {
        event.name
    }
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event.date,
              let timeRemaningParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else {return nil}
        return TimeRemainingViewModel(timeRemainingParts: timeRemaningParts, mode: .cell)
    }
    
    func loadImage(completion: @escaping(UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = self.event.image, let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func didSelect() {
        onSelect(event.objectID)
    }
}

