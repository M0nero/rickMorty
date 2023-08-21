//
//  TextProperty.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Combine
import UIKit

final class TextProperty {
    fileprivate let relay: CurrentValueSubject<String?, Never>

    init() {
        relay = CurrentValueSubject<String?, Never>(nil)
    }

    init(_ defaultValue: String) {
        relay = CurrentValueSubject<String?, Never>(defaultValue)
    }

    var value: String {
        get { relay.value ?? "" }
        set { relay.send(newValue) }
    }
}

extension TextProperty {
    func subscribe(to action: @escaping (String) -> Void) -> AnyCancellable {
        relay
            .receive(on: DispatchQueue.main)
            .compactMap { $0 } // Filter out nil values
            .sink { value in
                action(value)
            }
    }
}

extension MvvmController {
    func bind(_ property: TextProperty, to viewController: UIKit.UIViewController) {
        property.relay
            .receive(on: DispatchQueue.main)
            .sink { [weak viewController] value in
                viewController?.navigationItem.title = value
            }
            .store(in: &cancellables)
    }
}
