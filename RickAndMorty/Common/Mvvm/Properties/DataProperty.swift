//
//  DataProperty.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

final class DataProperty<T> {
    fileprivate let relay: CurrentValueSubject<T, Never>

    init(_ defaultValue: T) {
        relay = CurrentValueSubject(defaultValue)
    }

    var value: T {
        get { relay.value }
        set { relay.send(newValue) }
    }
}

extension DataProperty {
    func subscribe(to action: @escaping (T) -> Void) -> AnyCancellable {
        relay
            .receive(on: DispatchQueue.main)
            .sink { value in
                action(value)
            }
    }

    func subscribe(on scheduler: ImmediateScheduler) -> AnyPublisher<T, Never> {
        relay
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }
}

extension MvvmController {
    func bind<T>(_ property: DataProperty<T>, to action: @escaping (T) -> Void) {
        property.relay
            .receive(on: DispatchQueue.main)
            .sink { value in
                action(value)
            }
            .store(in: &cancellables)
    }
}
