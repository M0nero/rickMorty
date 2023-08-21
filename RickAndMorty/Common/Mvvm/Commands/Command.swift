//
//  Command.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation
import Combine

final class Command {
    fileprivate let subject = PassthroughSubject<Void, Never>()

    func call() { subject.send(()) }
}

extension MvvmController {
    func bind(_ command: Command, to action: @escaping () -> Void) {
        command.subject
            .receive(on: DispatchQueue.main)
            .sink { _ in action() }
            .store(in: &cancellables)
    }
}
