//
//  EventListViewController.swift
//  EventApp
//
//  Created by Поляндий on 26.09.2022.
//

import UIKit

class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
    
    lazy var barButtonItem: UIBarButtonItem = {
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let button = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedAddEventButton))
        button.tintColor = UIColor(red: 0/255, green: 39/255, blue: 255/255, alpha: 0.6)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = barButtonItem
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }

}
