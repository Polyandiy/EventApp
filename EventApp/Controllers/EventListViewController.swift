//
//  EventListViewController.swift
//  EventApp
//
//  Created by Поляндий on 26.09.2022.
//

import UIKit

class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
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
        
        tableView.dataSource = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
    }
    
    @objc private func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cell(at: indexPath) {
        case .event(let eventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            cell.update(with: eventCellViewModel)
            return cell
        }
    }
}
