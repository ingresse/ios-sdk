//
//  IngresseAlerts.swift
//  TicketsShare-Prototype
//
//  Created by Rubens Gondek on 5/17/16.
//  Copyright © 2016 Gondek. All rights reserved.
//

import Foundation
import UIKit

public struct IngresseAlerts {
    
    /**
        Show alert with directions options (Apple Maps, Google Maps, Waze)
     
        - parameter latitude:  Latitude of destination point
        - parameter longitude: Longitude of destination point
     */
    public static func getDirectionsTo(_ latitude: NSNumber, longitude: NSNumber) -> UIAlertController {
        
        let lat = latitude.doubleValue
        let lon = longitude.doubleValue
        
        let chooseRouting = UIAlertController(title: NSLocalizedString("route_alert_title", comment: ""), message: NSLocalizedString("route_alert_msg", comment: ""), preferredStyle: .actionSheet)
        let app = UIApplication.shared
        
        // Apple maps route
        let mapsURL = URL(string: "http://maps.apple.com/?daddr=\(lat),\(lon)")!
        let mapsAction = UIAlertAction(title: "Maps", style: .default) { (action) in
            app.openURL(mapsURL)
        }
        
        // Waze app Route
        let wazeURL = URL(string: "waze://?ll=\(lat),\(lon)&navigate=yes")!
        let wazeAction = UIAlertAction(title: "Waze", style: .default) { (action) in
            app.openURL(wazeURL)
        }
        
        // Google Maps app Route
        let googleURL = URL(string: "comgooglemaps://?daddr=\(lat),\(lon)")!
        let googleAction = UIAlertAction(title: "Google Maps", style: .default) { (action) in
            app.openURL(googleURL)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil)
        
        chooseRouting.addAction(cancelAction)
        
        // Check existing apps
        if app.canOpenURL(mapsURL) {
            chooseRouting.addAction(mapsAction)
        }
        if app.canOpenURL(wazeURL) {
            chooseRouting.addAction(wazeAction)
        }
        if app.canOpenURL(googleURL) {
            chooseRouting.addAction(googleAction)
        }
        
        return chooseRouting
    }
    
    /**
        Show any message on screen, just an action "OK"
     
        - parameter vc:      ViewController to show alert
        - parameter title:   String title of alert
        - parameter message: String message to show
     */
    public static func showMessageOnViewController(vc: UIViewController?, message: String, title: String) {
        let messageAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        messageAlert.addAction(okAction)
        
        guard (vc != nil) else {
            return
        }
        
        vc?.present(messageAlert, animated: true, completion: nil)
    }
    
    /**
        Show internet request error message on screen, just an action "OK"
     
        - parameter vc:         ViewController to show alert
        - parameter completion: success Callback
    */
    public static func showRequestErrorAlert(onViewController vc: UIViewController?, completion:@escaping ()->()) {
        let messageAlert = UIAlertController(
            title: NSLocalizedString("ops", comment: ""),
            message: NSLocalizedString("try_again_later", comment: ""),
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completion()
        })
        
        messageAlert.addAction(okAction)
        
        guard (vc != nil) else {
            return
        }
        
        vc?.present(messageAlert, animated: true, completion: nil)
    }
    
    /**
        Show error message on screen, just an action "OK"
     
        - parameter vc:        ViewController to show alert
        - parameter errorCode: Error code to get message
     */
    public static func errorAlert(errorCode: Int, vc: UIViewController?) {
        let message = IngresseErrorsSwift.shared.getErrorMessage(code: errorCode)
        
        let messageAlert = UIAlertController(
            title: NSLocalizedString("ops", comment: ""),
            message: message,
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        messageAlert.addAction(okAction)
        
        guard (vc != nil) else {
            return
        }
        
        vc?.present(messageAlert, animated: true, completion: nil)
    }
}

