//
//  AddEventViewModel.swift
//  EventApp
//
//  Created by Поляндий on 26.09.2022.
//

import Foundation
import UIKit

final class AddEventViewModel {
    
    let title = "Add"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    var coordinator: AddEventCoordinator?
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundCellViewModel: TitleSubtitleCellViewModel?
    
    private let cellBuilder: EventsCellBuilder
    private let coreDateManager: CoreDataManager
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        return formatter
    }()
    
    init(cellBuilder: EventsCellBuilder, coreDateManager: CoreDataManager = CoreDataManager.shared) {
        self.cellBuilder = cellBuilder
        self.coreDateManager = coreDateManager
    }
    
    func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    //MARK: - functions
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row ]
    }
    
    func tappedDone() {
        guard let name = nameCellViewModel?.subtitle,
                let dateString = dateCellViewModel?.subtitle,
              let image = backgroundCellViewModel?.image,
                let date = dateFormatter.date(from: dateString) else { return }
        coreDateManager.saveEvent(name: name, date: date, image: image)
        coordinator?.didFinishSaveEvent()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelect(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else { return }
            coordinator?.showImagePiker(completion: { image in
                titleSubtitleCellViewModel.update(image)
            })
        }
    }
}

private extension AddEventViewModel {
    func setupCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        backgroundCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self] in
            self?.onUpdate()
        }
        
        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundCellViewModel = backgroundCellViewModel else { return }
        
        cells = [
            .titleSubtitle( nameCellViewModel ),
            .titleSubtitle( dateCellViewModel ),
            .titleSubtitle( backgroundCellViewModel )
        ]
    }
}
