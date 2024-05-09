//
//  SentryImpl.swift
//  iosApp
//
//  Created by objex on 09/05/2024.
//

import Foundation
import Sentry
import shared

class SentryImplIos:SentryShared {
    
    static let instance = SentryImplIos()
    
    func captureException(e: KotlinException) {
        SentrySDK.capture(exception: convertKotlinExceptionToNSException(e))
    }
    
    func captureMessage(message:String){
        SentrySDK.capture(message: message)
    }
}

/// Converts a KotlinException to an NSException.
/// - Parameter kotlinException: The KotlinException instance captured from Kotlin Multiplatform code.
/// - Returns: An NSException that represents the same error.
private func convertKotlinExceptionToNSException(_ kotlinException: KotlinException) -> NSException {
    let message = kotlinException.message ?? "An unknown error occurred"

    // Create userInfo dictionary to include any additional info you might need
    let userInfo: [String: Any] = [
        "KotlinStackTrace": kotlinException.cause as Any
    ]

    // Return an NSException with the extracted details
    return NSException(
        name: NSExceptionName(rawValue: "KotlinException"),
        reason: message,
        userInfo: userInfo
    )
}

