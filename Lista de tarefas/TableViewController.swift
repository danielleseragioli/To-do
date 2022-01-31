//
//  ViewController.swift
//  Lista de tarefas
//
//  Created by user212279 on 31/01/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    var tasks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = UserDefaults.standard.stringArray(forKey: "tasksKey") ?? []
        
    }

    @IBAction func btAddItem(_ sender: Any) {
        
        let alertNewTask = UIAlertController(title: "Nova Tarefa", message: "Crie uma nova tarefa", preferredStyle: .alert)
        
        alertNewTask.addTextField{tf in
            tf.placeholder = "Título da Tarefa"
        }
        
        alertNewTask.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        alertNewTask.addAction(UIAlertAction(title: "Criar", style: .default, handler: {_ in
            // 1) desenbrulhar o textfield que tem no alerta
            if let tf = alertNewTask.textFields?.first {
                // 2) desenbrulhar o string que vem dentro
                if let textNewTaskTitle = tf.text {
                    // 3) garantir que esse texto não está vazio
                    if !textNewTaskTitle.isEmpty {
                        self.tasks.append(textNewTaskTitle)
                        self.tableView.insertRows(at: [IndexPath(row: self.tasks.count-1, section: 0)], with: .automatic)
                        self.tableView.reloadData()
                        
                        UserDefaults.standard.setValue(self.tasks, forKey: "tasksKey")
                    }
                }
            }
            
        }))
        
        present(alertNewTask, animated: true, completion: nil)
        
    }
    
    
// ----------------- Funções UITableViewDataSource  -> para criar linhas e células -----------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1) desenfileirar celulas dinâmicas par poder criar as células
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
 // ----------------- Funções UITableViewDelegate -> para quando seleciona uma linha por exemplo -----------------------------
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
}

