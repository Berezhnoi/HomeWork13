//
//  CatalogViewController.swift
//  Lesson13HW
//

//

import UIKit

class CatalogViewController: UIViewController {
    
    @IBOutlet weak var contentView: CatalogView!
    var model: CatalogModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        model.saveChangesIfNeeded()
    }
    
    private func setupInitialState() {
        
        title = "Catalog"
        
        model = CatalogModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        
        contentView.tableView.rowHeight = 170
        
        // Register custom cell class with the table view
        contentView.tableView.register(PcTableViewCell.self, forCellReuseIdentifier: PcTableViewCell.identifier)
    }
}

// MARK: - CatalogModelDelegate
extension CatalogViewController: CatalogModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

// MARK: - CatalogViewDelegate
extension CatalogViewController: CatalogViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.pcItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PcTableViewCell.identifier, for: indexPath) as? PcTableViewCell
        else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let item = model.pcItems[indexPath.row]
        cell.productCodeLabel.text = "Product code: \(item.id)"
        cell.nameLabel.text = item.name
        cell.manufacturerModelLabel.text = "\(item.manufacturer), \(item.model)"
        cell.ratingView.setRating(item.rating)
        cell.priceCurrencyLabel.text = "\(item.price), \(item.currency)"
        
        // Configure the closure to handle favorite button tap
        cell.favoriteButtonTapped = { [weak self] isFavorite in
            self?.model.updateItem(with: isFavorite, at: indexPath.row)
        }
        
        // Set the state of the favorite button
        cell.favoriteButton.isSelected = item.isFavorite ?? false
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {
    
}
