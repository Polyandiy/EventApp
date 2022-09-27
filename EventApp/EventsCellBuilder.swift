//
//  EventsCellBuilder.swift
//  EventApp
//
//  Created by Поляндий on 27.09.2022.
//

import Foundation
import UIKit

struct EventsCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType, oneCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewModel {
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(title: "Name", subtitle: "", pkacehplder: "Add a name", type: .text,
                                              onCellUpdate: oneCellUpdate)
        case .date:
            return TitleSubtitleCellViewModel(title: "Date", subtitle: "", pkacehplder: "Select a date ", type: .date,
                                              onCellUpdate: oneCellUpdate)
        case .image:
            return  TitleSubtitleCellViewModel(title: "Background", subtitle: "", pkacehplder: "", type: .image,
                                               onCellUpdate: oneCellUpdate)
        }
    }
}
