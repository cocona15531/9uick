//
//  HistoryViewController.swift
//  swift-9uick
//
//  Created by Issei Ueda on 2023/02/09.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var historyTableView: UITableView!
    
    var saveArray:  [String] = []
    var dateArray:  [String] = []
    
    var textFieldValue :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "履歴"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.saveArray = UserDefaults.standard.stringArray(forKey: "history") ?? []
        saveArray = saveArray.reversed()
        
        self.dateArray = UserDefaults.standard.stringArray(forKey: "date") ?? []
        dateArray = dateArray.reversed()
        
        print(saveArray.count)
        
        self.historyTableView.reloadData()
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "注意", message: "履歴を全て削除しますか？", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            UserDefaults.standard.removeObject(forKey: "history")
            self.saveArray.removeAll()
            
            UserDefaults.standard.removeObject(forKey: "date")
            self.dateArray.removeAll()
            
            self.historyTableView.reloadData()
            
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print(self.memoryArrayReversed.count)
        //        print(saveArray.count)
        return saveArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = saveArray[indexPath.item]
        //        cell.textLabel?.numberOfLines=0
        cell.detailTextLabel?.text = "追加日：\(dateArray[indexPath.item])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "cellSegue",sender: nil) // ←追加する
    }
    
    // セルの削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            saveArray.remove(at: indexPath.row)
            dateArray.remove(at: indexPath.row)
            
            historyTableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            // 追加：削除した内容を保存
            UserDefaults.standard.set(saveArray, forKey: "history")
            UserDefaults.standard.set(dateArray, forKey: "date")
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let detailViewController: DetailViewController = segue.destination as! DetailViewController
        
        if segue.identifier == "cellSegue" {
            let indexPath = self.historyTableView.indexPathForSelectedRow
            detailViewController.str = saveArray[indexPath!.item]
            detailViewController.date = dateArray[indexPath!.item]
        }
        
    }
    
}

