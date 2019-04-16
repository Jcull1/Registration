//
//  AppDelegate.swift
//  RegistrationApp
//
//  Created by Justin Cullen on 1/4/19.
//  Copyright © 2019 Justin Cullen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ _app: UIApplication, open url: URL, options:[UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool{
        if let _:String = url.path {
            do {
                let content = try String(contentsOf: url, encoding: String.Encoding.utf8)
                let readings = content.components(separatedBy: "\r") as [String]
                
                for i in 1..<(readings.count){
                    let data = readings[i].components(separatedBy:"\t")
                    
                    guests.append(Guest(constId: "\(data[0])", firstName: "\(data[1])", lastName: "\(data[2])", email: "\(data[3])", cellPhone: "\(data[4])", guestOf: "\(data[5])", number: "\(data[6])", balanceDue: "\(data[7])")!)
                }
                currentGuestArray+=guests
                updatedArray+=guests
                orignalGuestArray += guests
            } catch {
                // contents could not be loaded
            }
        } else {
            // file not found!
        }
        return true
    }
}

