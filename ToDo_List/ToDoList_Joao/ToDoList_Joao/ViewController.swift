//
//  ViewController.swift
//  ToDoList_Joao
//
//  Created by COTEMIG on 18/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var listaDeTarefas: [String] = []
    var listaKey = "listaDeTarefas"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        // Retrieve data from local
        if let lista = UserDefaults.standard.value(forKey: listaKey) as? [String]{
            listaDeTarefas.append(contentsOf: lista)
            tableView.reloadData()
        }
    }
    
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Nova tarefa", message: "Adiciona uma nova tarefa", preferredStyle: .alert)
        let salvar = UIAlertAction(title: "Salvar", style: .default) { (action) in
            
            if let textField = alert.textFields?.first, let tarefa = textField.text {
                self.listaDeTarefas.append(tarefa)
                
                // Save local data
                UserDefaults.standard.set(self.listaDeTarefas, forKey: self.listaKey)
                
                self.tableView.reloadData()
            }
            
        }
        let cancelar = UIAlertAction(title: "Cancelar", style: .destructive)
        
        alert.addTextField()
        
        alert.addAction(salvar)
        alert.addAction(cancelar)
        
        present(alert, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeTarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listaDeTarefas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listaDeTarefas.remove(at: indexPath.row)
            UserDefaults.standard.set(self.listaDeTarefas, forKey: listaKey)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
