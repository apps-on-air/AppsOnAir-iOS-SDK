//
//  UIImage+extension.swift
//  AppUpdateManager
//
//  Created by lw-66 on 29/09/22.
//

import Foundation
import UIKit

extension UIImage {
    static var appIcon: UIImage? {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String:Any],
              let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String:Any],
              let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
              let lastIcon = iconFiles.last else { return nil }
        return UIImage(named: lastIcon)
    }
}
