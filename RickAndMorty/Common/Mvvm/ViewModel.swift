//
//  ViewModel.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

class SUIViewModel: ObservableObject {
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
}

class ViewModel {
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    let activityState = DataProperty<Bool>(false)
    let title = TextProperty()
    
    let hideKeyboardCommand = Command()
    let showConfirmAlertControllerCommand = TCommand<(
        title: String,
        message: String,
        okButtonTitle: String,
        customButtonTitle: String?,
        okAction: () -> Void,
        customAction: () -> Void
    )>()
    
    func showConfirmAlert(title: String = "",
                          message: String,
                          okButtonTitle: String = "Ok",
                          customButtonTitle: String? = nil,
                          okAction: @escaping () -> Void = {},
                          customAction: @escaping () -> Void = {}) {
        showConfirmAlertControllerCommand.call((title,
                                                message,
                                                okButtonTitle,
                                                customButtonTitle,
                                                okAction,
                                                customAction))
    }
}
