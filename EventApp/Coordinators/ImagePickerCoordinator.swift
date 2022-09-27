//
//  ImagePickerCoordinator.swift
//  EventApp
//
//  Created by Поляндий on 27.09.2022.
//

import Foundation
import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    var parentCoordinator: AddEventCoordinator?
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigationController.present(imagePickerController, animated: true, completion: nil)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            parentCoordinator?.didFinishPicking(image)
        }
        parentCoordinator?.childDidFinish(self)
    }
}
