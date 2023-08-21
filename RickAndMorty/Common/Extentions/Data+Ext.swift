//
//  Data+Ext.swift
//  RickAndMorty
//
//  Created by Damir Akbarov on 21.08.2023.
//

import Foundation

extension Data {
    func prettyPrintedJSONString() -> String {
        guard let json = try? JSONSerialization.jsonObject(with: self,
                                                           options: .mutableContainers),
              let jsonData = try? JSONSerialization.data(withJSONObject: json,
                                                         options: .prettyPrinted) else { return "" }
        return String(decoding: jsonData, as: UTF8.self)
    }
}
