//
//  AppDelegate.swift
//  TodoLy
//
//  Created by Hector Moreno on 1/31/19.
//  Copyright © 2019 Hector Moreno. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(Realm.Configuration.defaultConfiguration.fileURL)

//        do {
//            let realm = try Realm()
//
//        } catch {
//            print(error)
//        }

        return true
    }


    func applicationWillTerminate(_ application: UIApplication) {

      
    }
}

