//
//  UIView + Extensions.swift
//  EventApp
//
//  Created by Поляндий on 27.09.2022.
//

import Foundation
import UIKit

enum Edge {
    case top
    case bottom
    case left
    case right
}

extension UIView {
    func pinToSuperviewEdges( _ edges: [Edge] = [.top, .bottom, .right, .left], constant: CGFloat = 0) {
        
        guard let superview = superview else { return }
        edges.forEach {
            switch $0 {
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor ).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            }
        }
    }
}
