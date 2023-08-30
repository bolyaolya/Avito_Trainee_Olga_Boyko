//
//  TabBarController.swift
//  Avito_Trainee_Olga_Boyko
//
//  Created by Ольга Бойко on 25.08.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - Properties
    
    var firstTabBarContr: UINavigationController!
    var secondTabBarContr: UINavigationController!
    var thirdTabBarContr: UINavigationController!
    var forthTabBarContr: UINavigationController!
    var fifthTabBarContr: UINavigationController!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        
        let productsVC = ProductsViewController()
        let favoritesVC = FavoritesViewController()
        let adsVC = AdsViewController()
        let messagesVC = MessagesViewController()
        let profileVC = ProfileViewController()
        
        firstTabBarContr = UINavigationController.init(rootViewController: productsVC)
        secondTabBarContr = UINavigationController.init(rootViewController: favoritesVC)
        thirdTabBarContr = UINavigationController.init(rootViewController: adsVC)
        forthTabBarContr = UINavigationController.init(rootViewController: messagesVC)
        fifthTabBarContr = UINavigationController.init(rootViewController: profileVC)
        
        self.viewControllers = [firstTabBarContr, secondTabBarContr, thirdTabBarContr, forthTabBarContr, fifthTabBarContr]
        
        let activeSearchImage = UIImage(named: "searchColor")?.withRenderingMode(.alwaysOriginal)
        let inactiveSearchImage = UIImage(named: "search")?.withRenderingMode(.alwaysTemplate)
        
        let item1 = UITabBarItem(title: "Поиск", image: inactiveSearchImage, selectedImage: activeSearchImage)
        let item2 = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart.fill"), tag: 1)
        let item3 = UITabBarItem(title: "Объявления", image: UIImage(named: "ads"), tag: 2)
        let item4 = UITabBarItem(title: "Сообщения", image: UIImage(systemName: "message.fill"), tag: 3)
        let item5 = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person.fill"), tag: 4)
        
        firstTabBarContr.tabBarItem = item1
        secondTabBarContr.tabBarItem = item2
        thirdTabBarContr.tabBarItem = item3
        forthTabBarContr.tabBarItem = item4
        fifthTabBarContr.tabBarItem = item5
        
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(named: "avitoBlue")
    }
}
