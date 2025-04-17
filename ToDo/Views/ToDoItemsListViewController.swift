//
//  ToDoItemsListViewController.swift
//  ToDo
//
//  Created by kiranjith on 24/03/2025.
//

import UIKit
import Combine

protocol ToDoItemsListViewControllerProtocol {
    func selectToDoItem(_ viewController: UIViewController, item: ToDoItem)
    func addToDoItem(_ viewController: UIViewController)
}

class ToDoItemsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: ToDoItemsListViewControllerProtocol?
    
    private var dataSource: UITableViewDiffableDataSource<Section, ToDoItem>?
    
    var todoItemStore: ToDoItemStoreProtocol?
    
    private var items: [ToDoItem] = []
    private var token: AnyCancellable?
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! ToDoItemCell
            cell.titleLabel.text = item.title
            if let timestamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                cell.dateLabel.text = self?.dateFormatter.string(from: date)
            }
            return cell
        })
        tableView.register(ToDoItemCell.self,
                           forCellReuseIdentifier: "ToDoItemCell")
        token = todoItemStore?.itemPublisher
            .sink(receiveValue: { [weak self] items in
                self?.items = items
                self?.update(with: items)
            })
        tableView.delegate = self
        
        let addItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(add(_ :)))
        navigationItem.rightBarButtonItem = addItem
    }
    
    @objc func add(_ sender: UIBarButtonItem) {
        delegate?.addToDoItem(self)
    }
    
    private func update(with items: [ToDoItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ToDoItem>()
        snapshot.appendSections([.todo, .done])
        snapshot.appendItems(items.filter({$0.done == false}), toSection: .todo)
        snapshot.appendItems(items.filter({$0.done}), toSection: .done)
        dataSource?.apply(snapshot)
    }
    
    func calculateSum(list: [Any]) -> Int {
        var total = 0
        for item in list {
            if let item = item as? Int {
                total += item
            } else if let item = item as? [Any] {
                let current = calculateSum(list: item)
                total += current
            }
        }
        return total
    }

}


enum Section {
    case todo
    case done
}

extension ToDoItemsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        delegate?.selectToDoItem(self, item: item)
    }
}
