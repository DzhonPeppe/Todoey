//
//  AppDelegate.swift
//  Tadoey
//
//  Created by John Peppe on 6/26/18.
//  Copyright © 2018 John Peppe. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
        } catch {
            print("Error initialising new Realm, \(error)")
        }
        
        
        return true
    }


}

