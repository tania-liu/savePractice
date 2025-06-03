//
//  DetailViewController.swift
//  savePractice
//
//  Created by 劉俐廷 on 2025/5/28.
//

import UIKit

class DetailViewController: UIViewController {
    var goal:Goal?
    
    @IBOutlet weak var textField: UITextField!
    
    //如果上一頁有傳goal資料，表示要修改，設定元資料顯示
    override func viewDidLoad() {
        super.viewDidLoad()
        if let goal{
            textField.text = goal.content
        }
    }
    
    // MARK: - Navigation
    
    //準備要傳給ToDoListTVC的資料
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        goal = Goal(content: textField.text ?? " ",done: false)
    }
}

