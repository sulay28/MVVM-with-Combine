//
//  ViewController.swift
//  Dummy
//
//  Created by Sulay on 06/03/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private(set) var docsListVm: DocsListViewModel
    private var docsListTableview = UITableView(frame: .zero, style: .plain)
    
    private var cancellables = Set<AnyCancellable>()
    private var cellIdentifier = "DocsListTableViewCell"
    
    init(docsListVm: DocsListViewModel) {
        self.docsListVm = docsListVm
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        docsListVm = DocsListViewModel()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setObservers()
        loadDocs()
    }

}

extension ViewController {
    
    func setObservers() {
        docsListVm.$documents
            .receive(on: RunLoop.main)
            .sink { [weak self] docs in
                self?.docsListTableview.reloadData()
            }
            .store(in: &cancellables)
    }
    
    func loadDocs() {
        Task {
            try await docsListVm.fetchDocs()
        }
    }
}

// MARK: Tableview Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func setupViews() {
        
        self.docsListTableview.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        docsListTableview.delegate = self
        docsListTableview.dataSource = self
        
        view.addSubview(docsListTableview)
        docsListTableview.translatesAutoresizingMaskIntoConstraints = false
        
        docsListTableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        docsListTableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        docsListTableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        docsListTableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        docsListVm.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        let doc = docsListVm.docs(atIndexPath: indexPath)
        
        cell?.textLabel?.text = doc.headline.main
        cell?.textLabel?.numberOfLines = 0
        
        cell?.detailTextLabel?.text = doc.abstract
        cell?.detailTextLabel?.numberOfLines = 0
        
        return cell!
    }
    
    
    
}
