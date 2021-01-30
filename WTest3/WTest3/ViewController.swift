//
//  ViewController.swift
//  WTest3
//
//  Created by Sofia Marques Teixeira on 29/01/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var listRMcopy = [RicknMorty]()
    
    var listRM = [RicknMorty]() {
        didSet {
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        let coredataArr = CoreData().retrieveData()
        
        if coredataArr.isEmpty {
          
            WebService().requestAPI("") { (listRM) in
                self.listRM = listRM
                self.listRMcopy = listRM
                
                DispatchQueue.main.async {
                    CoreData().createData(arr: listRM)
                }
            }
            
        } else {
            listRM = coredataArr
            listRMcopy = coredataArr
        }
   
    }
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        // condição que deixa a var de ser optional
        guard let searchText = searchBar.text?.lowercased() else {
            return
        }
        
        listRM = listRMcopy
        
        if searchText.isEmpty {
            return
        }
        
        listRM.removeAll { (object) -> Bool in
            object.name.lowercased().contains(searchText) == false
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        cell.textLabel?.text = listRM[indexPath.row].name
        
        if let url = URL(string: listRM[indexPath.row].image) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        return cell
    }
    
}

