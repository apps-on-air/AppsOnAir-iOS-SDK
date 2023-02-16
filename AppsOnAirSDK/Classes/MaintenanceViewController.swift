//
//  MaintenanceViewController.swift
//  AppUpdateManager
//
//  Created by lw-66 on 29/09/22.
//

import UIKit
import Foundation

class MaintenanceViewController: UIViewController {
    
    @IBOutlet weak var updateView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var subTitleText: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var maintenanceView: UIView!
    @IBOutlet weak var staticMaintenanceView: UIView!
    @IBOutlet weak var customMaintenanceView: UIView!
    @IBOutlet weak var maintenanceLogoImageView: UIImageView!
    @IBOutlet weak var appTitleText: UILabel!
    @IBOutlet weak var maintenanceTitleText: UILabel!
    @IBOutlet weak var maintenanceReasonText: UILabel!
    @IBOutlet weak var staticMaintenanceImageView: UIImageView!
    @IBOutlet weak var staticMaintenanceText: UILabel!
    
    var updateDataDictionary : NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.customMaintenanceView.isHidden = true
        self.staticMaintenanceView.isHidden = true
        self.updateView.isHidden = true
        self.maintenanceView.isHidden = true
        self.setUpdateViewLayout()
    }
    
    func setUpdateViewLayout() {
        self.updateView.layer.cornerRadius = 8.0
        self.updateView.layer.borderWidth = 1.0
        self.updateView.layer.borderColor = UIColor(hex: "#DDE1EE")?.cgColor
        self.updateView.backgroundColor = .white
        
        self.titleText.textColor = UIColor(hex: "#1A1D40")
        self.subTitleText.textColor = UIColor(hex: "#1A1D40")
        
        self.dismissButton.setTitleColor(UIColor(hex: "#585E75"), for: .normal)
        self.updateButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        self.updateButton.backgroundColor = UIColor(hex: "#007AFF")
        self.updateButton.layer.cornerRadius = 4.0
        
        let isMaintenanceAvailable = self.updateDataDictionary?.value(forKey: "isMaintenance") as! Bool
        let iosUpdate = self.updateDataDictionary?.value(forKeyPath: "updateData.isIOSUpdate") as? Bool
        
        if iosUpdate == true {
            if let updateData = self.updateDataDictionary?.value(forKey: "updateData") as? NSDictionary {
                let iosMinBuildVersion = updateData.value(forKey: "iosMinBuildVersion") as? String
                let iosMinBuildNumber = updateData.value(forKey: "iosBuildNumber") as? String
                let isForceUpdate = updateData.value(forKey: "isIOSForcedUpdate") as? Bool
                if iosUpdate == true {
                    if isForceUpdate == true {
                        self.dismissButton.isHidden = true
                    } else {
                        self.dismissButton.isHidden = false
                    }
                    let versionCompare = Bundle.main.releaseVersionNumber!.compare(iosMinBuildVersion!, options: .numeric)
                    if versionCompare == .orderedSame {
                        let builNumber = Bundle.main.buildVersionNumber!.compare(iosMinBuildNumber!, options: .numeric)
                        if builNumber == .orderedAscending {
                            self.showUpdateView(isForceUpdate!)
                        } else {
                            self.dismissController()
                        }
                    } else if versionCompare == .orderedAscending {
                        self.showUpdateView(isForceUpdate!)
                    } else {
                        self.dismissController()
                    }
                }
            }
        } else if isMaintenanceAvailable == true {
            self.view.backgroundColor = UIColor(hex: "#00000080")
            self.maintenanceView.isHidden = false
            if let maintenanceData = self.updateDataDictionary?.value(forKey: "maintenanceData") as? NSDictionary {
                self.customMaintenanceView.isHidden = false
                self.staticMaintenanceView.isHidden = true
                self.updateView.isHidden = true
                self.appTitleText.text = Bundle.main.appName
                if let imageUrlStr = maintenanceData.value(forKey: "image") as? String {
                    let imageUrl = URL(string: imageUrlStr)
                    self.maintenanceLogoImageView.load(url: imageUrl!)
                }
                if let bgColorCode = maintenanceData.value(forKey: "backgroundColorCode") as? String {
                    self.maintenanceView.backgroundColor = UIColor(hex: bgColorCode)
                }
                if let titleText = maintenanceData.value(forKey: "title") as? String {
                    self.maintenanceTitleText.text = titleText
                }
                if let description = maintenanceData.value(forKey: "description") as? String {
                    self.maintenanceReasonText.text = description
                }
                if let textColor = maintenanceData.value(forKey: "textColorCode") as? String {
                    self.maintenanceReasonText.textColor = UIColor(hex: textColor)
                    self.maintenanceTitleText.textColor = UIColor(hex: textColor)
                    self.appTitleText.textColor = UIColor(hex: textColor)
                }
                self.maintenanceTitleText.sizeToFit()
                self.maintenanceReasonText.sizeToFit()
            } else {
                self.customMaintenanceView.isHidden = true
                self.staticMaintenanceView.isHidden = false
                self.updateView.isHidden = true
                self.staticMaintenanceImageView.image = UIImage.appIcon
                self.staticMaintenanceText.text = "\(Bundle.main.appName!) app is under maintenance"
                self.staticMaintenanceText.sizeToFit()
            }
        } else {
            self.dismissController()
        }
    }
    
    func showUpdateView(_ isForceUpdate: Bool) {
        self.view.backgroundColor = UIColor(hex: "#00000080")
        self.logoImageView.image = UIImage.appIcon
        self.titleText.text = "\(Bundle.main.appName!) app update available"
        if isForceUpdate == true {
            self.subTitleText.text = "An update is available that must be installed."
        } else {
            self.subTitleText.text = "An update is available. Would you like to install it?"
        }
        self.customMaintenanceView.isHidden = true
        self.staticMaintenanceView.isHidden = true
        self.updateView.isHidden = false
        self.maintenanceView.isHidden = true
    }
    
    func dismissController() {
        self.dismiss(animated: true) {
            // This code snippet is for fixing one UI accessbility related bug for our other cross platform plugin
            NotificationCenter.default.post(name: NSNotification.Name("visibilityChanges"), object: nil, userInfo: ["isPresented": false])
        }
    }
    
    @IBAction func onTapDismissButton(_ sender: UIButton) {
        self.dismissController()
    }
    
    func verifyUrl(_ urlString: String?) -> Bool {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return false
        }

        return UIApplication.shared.canOpenURL(url)
    }
    
    @IBAction func onTapUpdateButton(_ sender: Any) {
        if let updateData = self.updateDataDictionary?.value(forKey: "updateData") as? NSDictionary {
            if let updateUrl = updateData.value(forKey: "iosUpdateLink") as? String {
                let urlStr = updateUrl.hasPrefix("https://") || updateUrl.hasPrefix("http://") || updateUrl.hasPrefix("itms-apps://") ? updateUrl : "https://\(updateUrl)"
                let checkUrl = verifyUrl(urlStr)
                if checkUrl == true {
                    let url = URL(string: urlStr)
                    UIApplication.shared.open(url!)
                }
            }
        }
    }
    
}
