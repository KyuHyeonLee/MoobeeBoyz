//
//  AppDelegate.swift
//  Moobee Boyz
//
//  Created by COMP401 on 11/9/18.
//  Copyright © 2018 COMP401. All rights reserved.
//

import UIKit

class Constants{
    static let color_ : UIColor = UIColor(red: 0.16, green: 0.18, blue: 0.31, alpha: 1.0)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let barColor: UIColor = #colorLiteral(red: 0.03531658649, green: 0.05483096093, blue: 0.1286598742, alpha: 1)
        UINavigationBar.appearance().barTintColor = barColor
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let finalDestUrl : URL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("watchlist.txt")
        do {
            let str = try String(contentsOf: finalDestUrl)
            let lists = str.split(separator: "^")
            if lists.count == 4{
                let watch = lists[0].split(separator: "@")
                WatchListTVC.addList.removeAll()
                var tempArr : [String] = []
                for title in watch{
                    tempArr.append(String(describing: title))
                }
                let watchPoster = lists[1].split(separator: "@")
                var _tempArr : [String] = []
                for poster in watchPoster{
                    _tempArr.append(String(describing: poster))
                }
                var i = 0
                while i < min(tempArr.count, _tempArr.count){
                    WatchListTVC.addList.append([tempArr[i], _tempArr[i]])
                    i += 1
                }
                let seen = lists[2].split(separator: "@")
                WatchListTVC.seenList.removeAll()
                var __tempArr : [String] = []
                for title in seen{
                    __tempArr.append(String(describing: title))
                }
                let seenPoster = lists[3].split(separator: "@")
                var ___tempArr : [String] = []
                for poster in seenPoster{
                    ___tempArr.append(String(describing: poster))
                }
                i = 0
                while i < min(__tempArr.count, ___tempArr.count){
                    WatchListTVC.seenList.append([__tempArr[i], ___tempArr[i]])
                    i += 1
                }
            }
        } catch {
            print("Error")
        }
        // cell.layer.borderColor = borderColor.cgColor
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
        let finalDestUrl : URL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("watchlist.txt")
        do {
            var str = ""
            var i = 0
            for entry in WatchListTVC.addList{
                str.append(entry[0])
                i += 1
                if i != WatchListTVC.addList.count {
                    str.append("@")
                }
            }
            str.append("^")
            i = 0
            for entry in WatchListTVC.addList{
                str.append(entry[1])
                i += 1
                if i != WatchListTVC.addList.count {
                    str.append("@")
                }
            }
            str.append("^")
            i = 0
            for entry in WatchListTVC.seenList{
                str.append(entry[0])
                i += 1
                if i != WatchListTVC.seenList.count{
                    str.append("@")
                }
            }
            str.append("^")
            i = 0
            for entry in WatchListTVC.seenList{
                str.append(entry[1])
                i += 1
                if i != WatchListTVC.seenList.count{
                    str.append("@")
                }
            }
            try str.write(to: finalDestUrl, atomically: true, encoding: .utf8)
        } catch {
            print("Error")
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        let finalDestUrl : URL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("watchlist.txt")
        do {
            let str = try String(contentsOf: finalDestUrl)
            let lists = str.split(separator: "^")
            if lists.count == 4{
                let watch = lists[0].split(separator: "@")
                WatchListTVC.addList.removeAll()
                var tempArr : [String] = []
                for title in watch{
                    tempArr.append(String(describing: title))
                }
                let watchPoster = lists[1].split(separator: "@")
                var _tempArr : [String] = []
                for poster in watchPoster{
                    _tempArr.append(String(describing: poster))
                }
                var i = 0
                while i < min(tempArr.count, _tempArr.count){
                    WatchListTVC.addList.append([tempArr[i], _tempArr[i]])
                    i += 1
                }
                let seen = lists[2].split(separator: "@")
                WatchListTVC.seenList.removeAll()
                var __tempArr : [String] = []
                for title in seen{
                    __tempArr.append(String(describing: title))
                }
                let seenPoster = lists[3].split(separator: "@")
                var ___tempArr : [String] = []
                for poster in seenPoster{
                    ___tempArr.append(String(describing: poster))
                }
                i = 0
                while i < min(__tempArr.count, ___tempArr.count){
                    WatchListTVC.seenList.append([__tempArr[i], ___tempArr[i]])
                    i += 1
                }
            }
        } catch {
            print("Error")
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        let finalDestUrl : URL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent("watchlist.txt")
        do {
            var str = ""
            var i = 0
            for entry in WatchListTVC.addList{
                str.append(entry[0])
                i += 1
                if i != WatchListTVC.addList.count {
                    str.append("@")
                }
            }
            str.append("^")
            i = 0
            for entry in WatchListTVC.addList{
                str.append(entry[1])
                i += 1
                if i != WatchListTVC.addList.count {
                    str.append("@")
                }
            }
            str.append("^")
            i = 0
            for entry in WatchListTVC.seenList{
                str.append(entry[0])
                i += 1
                if i != WatchListTVC.seenList.count{
                    str.append("@")
                }
            }
            str.append("^")
            i = 0
            for entry in WatchListTVC.seenList{
                str.append(entry[1])
                i += 1
                if i != WatchListTVC.seenList.count{
                    str.append("@")
                }
            }
            try str.write(to: finalDestUrl, atomically: true, encoding: .utf8)
        } catch {
            print("Error")
        }
    }


}

