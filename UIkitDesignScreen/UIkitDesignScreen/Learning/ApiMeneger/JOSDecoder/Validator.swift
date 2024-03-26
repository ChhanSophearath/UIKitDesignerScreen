//
//  Validator.swift
//  UIkitDesignScreen
//
//  Created by Rath! on 30/1/24.
//

import Foundation


class Validator {
    static func validateModel<T: Codable>(model: T, data: Data, fun: String, response: (T)->()) {
        do {
            let json = try JSONDecoder().decode(T.self, from: data)
            response(json)
        } catch let DecodingError.typeMismatch(type, context) {
            print(type)
            AlertMessage.shared.showAlert(message: context.showError(functionName: fun))
        } catch {
            print("error: ", error)
            AlertMessage.shared.showAlert(message: error.localizedDescription)
        }
    }
}
