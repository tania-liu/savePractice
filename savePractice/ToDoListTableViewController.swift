//
//  ToDoListTableViewController.swift
//  savePractice
//
//  Created by 劉俐廷 on 2025/5/28.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    //用property observer儲存任何改變
    var goals = [Goal](){
        didSet{
            Goal.saveGoal(goals: goals)
        }
    }
    //在初始畫面讀取存在UserDefaults的資料，並更新在變數goals array
    override func viewDidLoad() {
        super.viewDidLoad()
        if let goalsData = Goal.loadGoal(){
            self.goals = goalsData
        }
    }
    //設置打勾button
    @IBAction func buttonTapped(_ sender: UIButton) {
        //找到button位置在tableView的哪裡
        let point = sender.convert(CGPoint(x: sender.bounds.midX, y: sender.bounds.midY), to: tableView)
        //對應剛剛的位置，找到indexPath
        if let indexPath = tableView.indexPathForRow(at: point){
            var goal = goals[indexPath.row]
            //改變button的bool狀態
            goal.done.toggle()
            //把新的狀態存回去
            goals[indexPath.row] = goal
            //重新load被更改的row
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    //刪除功能
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        goals.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
    //設置custom cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell", for: indexPath) as! GoalTableViewCell
        let goal = goals[indexPath.row]
        
        cell.contentLabel.text = goal.content
        cell.doneButton.isSelected = goal.done

        return cell
    }
 
    
    // MARK: - Navigation

    //點選cell可以回到編輯頁面（把資料傳到下一頁）
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailViewController
            ,let row = tableView.indexPathForSelectedRow?.row{
            controller.goal = goals[row]
        }
    }
    //接收DetailVC的資料
    @IBAction func unwindToDetailVC(_ unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? DetailViewController
        ,let newGoal = source.goal{
            
            //判斷是新增：沒有indexPath；還是修改：有indexPath
            if let indexPath = tableView.indexPathForSelectedRow{
                goals[indexPath.row] = newGoal
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }else{
                goals.insert(newGoal, at: 0)
                tableView.reloadData()
            }
        }
    }
    
}
