//
//  SceneDelegate.swift
//  Wanted-Challenge
//
//  Created by 홍승현 on 2023/03/03.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    window = UIWindow(windowScene: windowScene)
    window!.rootViewController = ViewController()
    window!.makeKeyAndVisible()
  }
}

