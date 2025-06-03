//
//  Goal.swift
//  savePractice
//
//  Created by 劉俐廷 on 2025/5/28.
//

import Foundation

struct Goal: Codable{
    var content: String
    var done: Bool

    //儲存goal功能傳入整個goal array當參數
    static func saveGoal(goals:[Goal]?){
        let encoder = JSONEncoder()
        //將傳入的array編碼
        guard let data = try? encoder.encode(goals) else {return}
        //這行是想要印出編碼內容的JSON來檢查
        if let content = String(data: data, encoding: .utf8){
            print(content)
        }
        //儲存
        UserDefaults.standard.setValue(data, forKey: "goalData")
    }
    //讀取goal func，會回傳goal array
    static func loadGoal() -> [Goal]?{
        guard let data = UserDefaults.standard.data(forKey: "goalData") else {return nil}
            
        let decoder = JSONDecoder()
        return try? decoder.decode([Goal].self, from: data)
    }
    
}
