//
//  ContentViewController.swift
//  swift-9uick
//
//  Created by Issei Ueda on 2023/02/09.
//

import UIKit

class ContentViewController: UIViewController, UITextViewDelegate {
    
    var saveArray:  [String] = []
    var dateArray:  [String] = []
    
    
    @IBOutlet weak var memoTextView: UITextView!
    
    var text = ""
    var textFieldValuebefore :String = ""
    var textFieldValue :String = ""
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        memoTextView.delegate = self
        
        let value = UserDefaults.standard.string(forKey: "memo")
        memoTextView.text = value
        
        if memoTextView.text == "" {
            storeData(text: "9uick")
        }
        
        // ツールバー生成 サイズはsizeToFitメソッドで自動で調整される。
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        //サイズの自動調整。敢えて手動で実装したい場合はCGRectに記述してsizeToFitは呼び出さない。
        toolBar.sizeToFit()
        
        // 左側のBarButtonItemはflexibleSpace。これがないと右に寄らない。
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // Doneボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(commitButtonTapped))
        
        // BarButtonItemの配置
        toolBar.items = [spacer, commitButton]
        // textViewのキーボードにツールバーを設定
        memoTextView.inputAccessoryView = toolBar
        
        self.saveArray = UserDefaults.standard.stringArray(forKey: "history") ?? []
        
        self.dateArray = UserDefaults.standard.stringArray(forKey: "date") ?? []
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.saveArray = UserDefaults.standard.stringArray(forKey: "history") ?? []
        self.dateArray = UserDefaults.standard.stringArray(forKey: "date") ?? []
    }
    
    
    func storeData(text : String) {
        let storedata = StoreData(showText: text)
        let primaryData = PrimaryData(storeData: storedata)
        primaryData.encodeData()
    }
    
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
        storeData(text: memoTextView.text ?? "--")
        
        if self.saveArray.count >= 30 {
            self.saveArray.removeFirst()
            print("呼ばれました")
        }
        
        if self.dateArray.count >= 30 {
            self.dateArray.removeFirst()
        }
        
        textFieldValuebefore = memoTextView.text
        
        textFieldValue = textFieldValuebefore.replacingOccurrences(of: "\n", with: "｜")
        
        print(textFieldValue)
        
        if saveArray.contains(textFieldValue) {
            return
            
        } else if textFieldValue == "" {
            return
            
        } else {
            saveArray.append("\(textFieldValue)")
            UserDefaults.standard.set(saveArray, forKey: "history")
            
        }
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd HH:mm"
        dateArray.append("\(df.string(from: Date()))")
        UserDefaults.standard.set(dateArray, forKey: "date")
    }
}

