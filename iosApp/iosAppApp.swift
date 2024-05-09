//
//  iosAppApp.swift
//  iosApp
//
//  Created by objex on 03/05/2024.
//

import SwiftUI
import Sentry


@main
struct iosAppApp: App {
    init() {
        SentrySDK.start { options in
            options.dsn = "SENTRY_URL"
            options.debug = true
            options.enableTracing = true
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
