//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var onFinish: Closure { get }
    var childCoordinators: [Coordinator] { get }
    var initialViewController: UIViewController? { get }
    
    func start()
}
