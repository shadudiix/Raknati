//
//  Coordinator.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController! { get set }
    var childCoordinators: [Coordinator]! { get set }
    func configureRootViewController()
}
