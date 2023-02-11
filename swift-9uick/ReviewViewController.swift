//
//  ReviewViewController.swift
//  swift-9uick
//
//  Created by Issei Ueda on 2023/02/09.
//

import UIKit
import StoreKit
import MessageUI

class ReviewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    var sections = ["使い方","レビュー","お問い合わせ","開発者"]
    var usingCell = ["ウィジェットの追加方法","9uickの使い方"]
    var reviewCell = ["レビューを書く"]
    var mailCell = ["お問い合わせ（メール）"]
    var blogCell = ["開発者のブログ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "その他"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rows = 0
        if section == 0 {
            rows = usingCell.count
        } else if section == 1 {
            rows = reviewCell.count
        } else if section == 2 {
            rows = mailCell.count
        } else if section == 3 {
            rows = blogCell.count
        }
        return rows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        var text = ""
        var color = UIColor.white
        if indexPath.section == 0 {
            text = usingCell[indexPath.row]
        } else if indexPath.section == 1 {
            text = reviewCell[indexPath.row]
        } else if indexPath.section == 2 {
            text = mailCell[indexPath.row]
        } else if indexPath.section == 3 {
            text = blogCell[indexPath.row]
        }
        
        cell.textLabel?.text = text
        cell.backgroundColor = color
        return cell
    }
    
    //セルをタップした時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //タップした時の選択色を消す
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        print(indexPath.row)
        
        if indexPath == [0,0] {
            let url = NSURL(string: "https://voracious-sardine-e88.notion.site/f954ec2b87084a1daa8deb0bdf8e65a2")
            if UIApplication.shared.canOpenURL(url! as URL) {
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            }
        } else if indexPath == [0,1] {
            let url = NSURL(string: "https://voracious-sardine-e88.notion.site/9uick-4d2867f472fe4dd785952d2e7d37571c")
            if UIApplication.shared.canOpenURL(url! as URL) {
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            }
        } else if indexPath == [1,0] {
            if #available(iOS 14.0, *) {
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            } else if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        } else if indexPath == [2,0] {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["cocona15531@gmail.com"]) // 宛先アドレス
                mail.setSubject("お問い合わせ") // 件名
                mail.setMessageBody("ここに本文が入ります。", isHTML: false) // 本文
                present(mail, animated: true, completion: nil)
            } else {
                print("送信できません")
            }
        } else if indexPath == [3,0] {
            let url = NSURL(string: "https://coconaly.org/")
            if UIApplication.shared.canOpenURL(url! as URL) {
                UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
            }
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("キャンセル")
        case .saved:
            print("下書き保存")
        case .sent:
            print("送信成功")
        default:
            print("送信失敗")
        }
        dismiss(animated: true, completion: nil)
    }
}

