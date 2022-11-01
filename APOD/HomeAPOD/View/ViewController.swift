//
//  ViewController.swift
//  APOD
//
//  Created by Juan Diego Marin on 28/10/22.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    
    // MARK: - IBOutlets

    @IBOutlet private weak var infoTableView: UITableView!
    
    //MARK: - Private Properties

    private var viewModel = ApodViewModel(repository: ApodRepository())
    
    // MARK: - Life cycle View

    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.register(.init(nibName: "ApodTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        infoTableView.delegate = self
        infoTableView.dataSource = self
        viewModel.getPlanet()
        viewModel.success = {
            self.infoTableView.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.planet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ApodTableViewCell else {
            return UITableViewCell()
        }
        cell.planet = viewModel.planet[indexPath.row]
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    
}


