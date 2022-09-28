//
//  EventDetailViewController.swift
//  EventApp
//
//  Created by Поляндий on 28.09.2022.
//

import Foundation
import UIKit


class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var timeRemainingStackView: TimeRemainingStackView! {
        didSet {
            timeRemainingStackView.setup()
        }
    }
    @IBOutlet weak var viewImage: UIImageView!
    
    var viewModel: EventDetailViewModel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] in
            guard let self = self, let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else {return}
            self.viewImage.image = self.viewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        viewModel.viewDidLoad()
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "pencil.circle.fill"), style: .plain, target: viewModel, action: #selector(viewModel.editButtonTapped))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
        
}
