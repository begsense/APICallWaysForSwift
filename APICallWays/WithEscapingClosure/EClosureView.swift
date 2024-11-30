//
//  EClosureView.swift
//  APICallWays
//
//  Created by M1 on 30.11.2024.
//

import UIKit

final class EClosureView: UIViewController, DataUpdateProtocol {
    
    private var viewModel: EClosureViewModel
    
    private var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(viewModel: EClosureViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        
        /* second way to communicate to objects with closures (without delegate)*/
        //        viewModel.onDataUpdate = { [weak self] in
        //            DispatchQueue.main.async {
        //                self?.tableView.reloadData()
        //            }
        //        }
        
        //        viewModel.onError = { [weak self] errorMessage in
        //            DispatchQueue.main.async {
        //                self?.showErrorAlert(message: errorMessage)
        //            }
        //        }
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
}

extension EClosureView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.downloadedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = viewModel.downloadedData[indexPath.row].title
        return cell
    }
}

// Comments do same thing with closures (communication)
