//
//  EventCellViewModel.swift
//  EventApp
//
//  Created by Поляндий on 27.09.2022.
//

import Foundation
import UIKit

struct EventCellViewModel {
    let date = Date()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    private static let imageCache = NSCache<NSString, UIImage>()
    private var cacheKey: String {
        event.objectID.description
    }
    
    private let event: Event
    
    init(_ event: Event) {
        self.event = event
    }
    
    var timeReainingString: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
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
}

