//
//  AboutAppViewController.swift
//  swift-9uick
//
//  Created by Issei Ueda on 2023/02/12.
//

import UIKit

class AboutAppViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var tutorialView: UITextView!
    
    @IBOutlet weak var finishButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseString = "動画でのウィジェット追加方法はこちら"
        let baseString2 = "動画での9uickの使い方はこちら"

        let attributedString = NSMutableAttributedString(string: baseString)
        let attributedString2 = NSMutableAttributedString(string: baseString2)

        attributedString.addAttribute(.link,
                                      value: "https://voracious-sardine-e88.notion.site/f954ec2b87084a1daa8deb0bdf8e65a2",
                                      range: NSString(string: baseString).range(of: "こちら"))
        
        attributedString2.addAttribute(.link,
                                       value: "https://voracious-sardine-e88.notion.site/9uick-4d2867f472fe4dd785952d2e7d37571c",
                                       range: NSString(string: baseString2).range(of: "こちら"))

        textView.attributedText = attributedString
        // isSelectableをtrue、isEditableをfalseにする必要がある
        // （isSelectableはデフォルトtrueだが説明のため記述）
        textView.isSelectable = true
        textView.isEditable = false
//        textView.delegate = self
        
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 10
//        let attributes = [NSAttributedString.Key.paragraphStyle : style]
//
//        textView.attributedText = NSAttributedString(string: textView.text,
//                                       attributes: attributes)
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.setContentOffset(CGPoint.zero, animated: false)


        
        tutorialView.attributedText = attributedString2
        // isSelectableをtrue、isEditableをfalseにする必要がある
        // （isSelectableはデフォルトtrueだが説明のため記述）
        tutorialView.isSelectable = true
        tutorialView.isEditable = false
        tutorialView.delegate = self
//        tutorialView.attributedText = NSAttributedString(string: tutorialView.text,
//                                       attributes: attributes)
        tutorialView.font = UIFont.systemFont(ofSize: 17)
        tutorialView.setContentOffset(CGPoint.zero, animated: false)


        finishButton.layer.cornerRadius = 26
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {

        UIApplication.shared.open(URL)

        return false
    }
    
    private func tutorialView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {

        UIApplication.shared.open(URL)

        return false
    }
    
    
    func executeLink(){
        let application = UIApplication.shared // シングルトンのインスタンスを取得
        application.open(URL(string: "https://tech.amefure.com/")!) // openメソッド呼び出し
    }
    
    
    @IBAction func toback(_ sender: Any) {
        
        let alert = UIAlertController(title: "終了しますか？", message: "チュートリアルは終了した後でも確認することができます", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            return
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
