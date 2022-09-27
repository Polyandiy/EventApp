//
//  EventCellViewModel.swift
//  EventApp
//
//  Created by Поляндий on 27.09.2022.
//

import Foundation
import UIKit

struct EventCellViewModel {
    var yearText: String {
        "1 year"
    }
    var monthText: String {
        "2 months"
    }
    var weekText: String {
        "3 weeks"
    }
    var dayText: String {
        "4 days"
    }
    var dateText: String {
        "31.12.2022"
    }
    var eventName: String {
        "New Year"
    }
    var backgroundImage: UIImage {
        #imageLiteral(resourceName: "new year")
    }
}

