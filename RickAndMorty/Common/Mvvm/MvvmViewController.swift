//
//  MvvmViewController.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import UIKit
import Combine

protocol MvvmController: AnyObject {
    associatedtype ViewModel
    associatedtype UIViewController
    var cancellables: Set<AnyCancellable> { get set }
    var viewModel: ViewModel! { get }
}

class MvvmViewController<TViewModel: ViewModel>: UIViewController, MvvmController {
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    private var _viewModel: TViewModel?
    
    var viewModelProvider: () -> TViewModel? = {
        (UIApplication.shared.delegate as? AppDelegate)?.diContainer.resolve(TViewModel.self)
    }
    var viewModel: TViewModel! { _viewModel }
    
    typealias ViewModel = TViewModel
    typealias UIViewController = MvvmViewController<TViewModel>
    
    private lazy var activityView: ActivityView = ActivityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        _viewModel = viewModelProvider()
    }
    
    private func setupViews() {
        UIApplication.shared.keyWindow?.addSubview(activityView)
        activityView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setState(_ isLoading: Bool) {
        if isLoading {
            view.bringSubviewToFront(activityView)
            view.isUserInteractionEnabled = false
        } else {
            view.isUserInteractionEnabled = true
        }
        activityView.setState(isLoading)
    }
    
    func bindViewModel() {
        bind(viewModel.title, to: self)
        
        bind(viewModel.hideKeyboardCommand) { [weak self] in
            self?.view.endEditing(true)
        }
        
        bind(viewModel.activityState) { [weak self] in
            self?.setState($0)
        }
        
        bindAlerts()
    }
    
    fileprivate func bindAlerts() {
        bind(viewModel.showConfirmAlertControllerCommand) { [weak self] args in
            let alert = UIAlertController(title: args.title, message: args.message, preferredStyle: .alert)
            let OKAlertAction = UIAlertAction(
                    title: args.okButtonTitle,
                    style: .default
            ) { _ in
                args.okAction()
            }

            if let custom = args.customButtonTitle {
                let customAlertAction = UIAlertAction(title: custom, style: .default) { _ in
                    args.customAction()
                }
                alert.addAction(customAlertAction)
            }

            alert.addAction(OKAlertAction)

            self?.present(alert, animated: true, completion: nil)
        }
    }
}
