//
//  PinVerificationManager.swift
//  tv-shows
//
//  Created by Felipe Melo on 06/07/22.
//

import Combine
import LocalAuthentication

final class LocalAuthenticationManager: ObservableObject {
    let reason = "Log in with Face ID to use the App"
    let context = LAContext()
    
    func authenticate() -> Future<Bool, Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            self.context.evaluatePolicy(
                .deviceOwnerAuthentication,
                localizedReason: self.reason
            ) { success, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(success))
                }
            }
        }
    }
}
