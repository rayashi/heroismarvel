//
//  HeroesTableViewController.swift
//  HeroisMarvel
//
//  Created by Eric Brito on 22/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class HeroesTableViewController: UITableViewController {

    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var heros: [Hero] = []
    var name: String = ""
    var loading: Bool = true
    var currentPage: Int = 0
    var total: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Buscando herois..."
        loadHeros()
    }
    
    func loadHeros() {
        loading = true
        MarvelAPI.loadHeros(name: name, page: currentPage) { (marvelInfo) in
            if let info = marvelInfo {
                self.loading = false
                self.heros += info.data.results
                self.total = info.data.total
                print("Total de herois: \(self.total)")
                DispatchQueue.main.async {
                    self.loading = false
                    self.tableView.reloadData()
                    self.label.text = "Nenhum heroi encontrado com o nome \(self.name)"
                }
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = heros.count > 0 ? nil : label
        return heros.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeroTableViewCell
        cell.prepare(with: heros[indexPath.row])
        return cell
    }
    
    
    // This method is called before tableview display a cell
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !loading && total != heros.count && indexPath.row == heros.count - 10 {
            currentPage += 1
            loadHeros()
            print("Carrendo mais herois")
        }
    }

}
