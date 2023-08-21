//
//  Completion+Ext.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 22.08.2023.
//

import Combine

extension Subscribers.Completion {
    func error() throws -> Failure {
        if case let .failure(error) = self {
            return error
        }
        throw ErrorFunctionThrowsError.error
    }
    
    private enum ErrorFunctionThrowsError: Error { case error }
}
