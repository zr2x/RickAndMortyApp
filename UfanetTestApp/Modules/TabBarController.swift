//
//  TabBarController.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 23.09.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarPages()
    }
    
    private func setupTabBarPages() {
        let mainVC = MainViewController()
        
        mainVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let navigationMainPage = UINavigationController(rootViewController: mainVC)
        tabBar.barTintColor = .systemMint
        mainVC.tabBarItem = UITabBarItem(title: "Главная",
                                         image: UIImage(systemName: "house"),
                                         tag: 1)

        setViewControllers([navigationMainPage], animated: true)
        
        for page in [mainVC] {
            page.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
}
