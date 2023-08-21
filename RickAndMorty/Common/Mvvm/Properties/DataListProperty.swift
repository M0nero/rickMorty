//
//  DataListProperty.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

final class DataListProperty<T> {
    fileprivate let subject = CurrentValueSubject<[T], Never>([])

    init(_ defaultValue: [T]) {
        value = defaultValue
    }

    var value: [T] {
        get { subject.value }
        set { subject.send(newValue) }
    }
}

extension DataListProperty {
    func subscribe(to action: @escaping ([T]) -> Void) -> AnyCancellable {
        subject
            .receive(on: DispatchQueue.main)
            .sink { value in
                action(value)
            }
    }

    func subscribe(on scheduler: ImmediateScheduler) -> AnyPublisher<[T], Never> {
        subject
            .receive(on: scheduler)
            .eraseToAnyPublisher()
    }
}

extension MvvmController {
    func bind<T>(_ property: DataListProperty<T>, to action: @escaping ([T]) -> Void) {
        property.subject
            .receive(on: DispatchQueue.main)
            .sink { value in
                action(value)
            }
            .store(in: &cancellables)
    }
}
