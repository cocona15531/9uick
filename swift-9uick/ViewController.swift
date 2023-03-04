//
//  ViewController.swift
//  swift-9uick
//
//  Created by Issei Ueda on 2023/02/09.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, UITabBarDelegate, UITabBarControllerDelegate {
    
    var pageViewController: UIPageViewController?
    
    var pallet = [UIColor.red, UIColor.yellow, UIColor.blue, UIColor.green, UIColor.purple]
    var cnt = 0
    var text = ""
    
    let hitokoto: [String] = ["⭐️忘れないようにメモしよう", "⭐️頭の中を整理するためにメモしよう", "⭐️TODOリストを作ってみよう"]
    
    
    @IBOutlet weak var hitokotoLabel: UILabel!
    
    @IBOutlet weak var targetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "9uick"
        // PageViewControllerを取得
        pageViewController = children.first! as? UIPageViewController
        setViewController()
        pageViewController?.dataSource = self
        pageViewController?.delegate = self
        targetView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        targetView.layer.shadowColor = UIColor.black.cgColor
        targetView.layer.shadowOpacity = 0.4
        targetView.layer.shadowRadius = 3
        self.tabBarController?.delegate = self
        
        let value = hitokoto.randomElement()
        hitokotoLabel.text = value
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let ud = UserDefaults.standard
        let firstLunchKey = "firstLunch"
        if ud.bool(forKey: firstLunchKey) {
            ud.set(false, forKey: firstLunchKey)
            ud.synchronize()
            self.performSegue(withIdentifier: "toAboutApp", sender: nil)
        }
    }
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func setViewController() {
        if cnt < pallet.count {
            cnt += 1
            let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
            
            // PageViewControllerにViewControllerをセット
            self.pageViewController?.setViewControllers([contentVC], direction: .forward, animated: true,completion: nil)
        } else {
            cnt = 0
            let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
            // PageViewControllerにViewControllerをセット
            self.pageViewController?.setViewControllers([contentVC], direction: .forward, animated: true,completion: nil)
            
        }
    }
    
    func storeData(text : String) {
        print(text)
        let storedata = StoreData(showText: text)
        let primaryData = PrimaryData(storeData: storedata)
        primaryData.encodeData()
    }
}


extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contentVC = storyboard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        cnt += 1
        
        if cnt == 0 {
            print("0です")
        }
        
        return contentVC
    }
    
    func pageViewController(_: UIPageViewController, willTransitionTo: [UIViewController]) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        UserDefaults.standard.set("",forKey: "memo")
        
    }
}
