//
//  UpdateManager.swift
//  AppUpdateManager
//
//  Created by lw-66 on 29/09/22.
//

import Foundation
import UIKit
import AVFoundation

public class AppsOnAirServices : NSObject, NetworkServiceDelegate {
    private var appId: String = ""
    private var window: UIWindow?
    
    var networkService: NetworkService = ReachabilityNetworkService()
    var isShowNativeUI: Bool = false
    public func setAppId(_ appId: String,_ showNativeUI: Bool = false) -> (Void) {
        
        self.appId = appId;
        self.isShowNativeUI = showNativeUI
        
        networkService.delegate = self
        networkService.startMonitoring()
    }
    
    func networkStatusDidChange(status: Bool) {
        if status {
            if(isShowNativeUI) {
                // get app data from CDN
                AppUpdateRequest.cdnRequest(self.appId) { cdnData in
                    
                    var appUpdateInfo: NSDictionary = NSDictionary()
                    appUpdateInfo = cdnData
                    
                    if(appUpdateInfo.count == 0 || appUpdateInfo["error"] != nil) {
                        // get app data from API if CDN data is empty or getting error
                        AppUpdateRequest.fetchAppUpdate(self.appId) { (appUpdateData) in
                            appUpdateInfo = appUpdateData
                            self.presentAppUpdate(appUpdateInfo: appUpdateInfo)
                        }
                    } else {
                        self.presentAppUpdate(appUpdateInfo: appUpdateInfo)
                    }
                
                }
                
            }
        }
    }
    
    /// handle force update | maintenance alert using App data
    func presentAppUpdate(appUpdateInfo: NSDictionary) {
        if (appUpdateInfo.count > 0) {
            DispatchQueue.main.sync {
                let bundle = Bundle(for: type(of: self))
                let storyboard = UIStoryboard(name: "AppUpdate", bundle: bundle)
                let modalVc = storyboard.instantiateViewController(withIdentifier: "MaintenanceViewController") as! MaintenanceViewController
                modalVc.updateDataDictionary = appUpdateInfo
                
                if let topController = UIApplication.topMostViewController(), !(topController is MaintenanceViewController) {
                    let navController = UINavigationController(rootViewController: modalVc)
                    navController.modalPresentationStyle = .overCurrentContext
                    let topController = UIApplication.topMostViewController()
                    topController?.present(navController, animated: true) {
                        // This code snippet is for fixing one UI accessability related bug for our other cross platform plugin
                        NotificationCenter.default.post(name: NSNotification.Name("visibilityChanges"), object: nil, userInfo: ["isPresented": true])
                    }
                }
                
            }
        }
    
    }
    
    public func checkForAppUpdate(_ completion : @escaping (NSDictionary) -> ()) {
        AppUpdateRequest.fetchAppUpdate(self.appId) { (appUpdateData) in
            completion(appUpdateData)
        }
    }
}
