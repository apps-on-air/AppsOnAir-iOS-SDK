//
//  Bundle+extension.swift
//  AppUpdateManager
//
//  Created by lw-66 on 29/09/22.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var appName : String? {
        return infoDictionary?["CFBundleDisplayName"] as? String
    }
}
