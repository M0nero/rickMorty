//
//  TCommand.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

final class TCommand<T> {
    fileprivate let subject = PassthroughSubject<T, Never>()

    func call(_ value: T) { subject.send(value) }
}

extension MvvmController {
    func bind<T>(_ command: TCommand<T>, to action: @escaping (T) -> Void) {
        command.subject
            .receive(on: DispatchQueue.main)
            .sink { value in
                action(value)
            }
            .store(in: &cancellables)
    }
}
