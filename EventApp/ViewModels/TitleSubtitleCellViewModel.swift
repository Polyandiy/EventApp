//
//  TitleSubtitleCellViewModel.swift
//  EventApp
//
//  Created by Поляндий on 26.09.2022.
//

import Foundation
import UIKit

final class TitleSubtitleCellViewModel {
    let title: String
    private(set) var subtitle: String
    let placeholder: String
    
    init(title: String, subtitle: String, pkacehplder: String) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = pkacehplder
    }
}
