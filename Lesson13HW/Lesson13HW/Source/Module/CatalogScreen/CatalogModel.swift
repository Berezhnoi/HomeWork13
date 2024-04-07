//
//  CatalogModel.swift
//  Lesson13HW
//

//

import Foundation

protocol CatalogModelDelegate: AnyObject {
    
    func dataDidLoad()
}

class CatalogModel {
    
    weak var delegate: CatalogModelDelegate?
    private let dataLoader = DataLoaderService()
    private let localStorage = LocalStorageService()
    
    var pcItems: [Pc] = []
    
    func loadData() {
        
        dataLoader.loadCatalog { [weak self] catalog in
            guard let self = self else { return }
            
            // Mark favorites from saved items
            self.pcItems = self.markFavoritesFromSavedItems(
                catalogItems: catalog?.data ?? [],
                savedFavorites: localStorage.getFavorites()
            )
            
            // Notify the delegate that data has loaded
            self.delegate?.dataDidLoad()
        }
    }
    
    func updateItem(with isFavorite: Bool, at index: Int) {
        pcItems[index].isFavorite = isFavorite
    }
    
    func saveChangesIfNeeded() {
        
        let favoriteItems = getFavoriteItems()
        let savedItems = localStorage.getFavorites()
        
        guard savedItems != favoriteItems else { return }
        
        // Deprecated - previous implementation
        // let totlaSet: Set<Favorite> = Set(savedItems + favoriteItems)
        
        // Save only the current state of favorites, allowing removal of favorites from the catalog screen
        localStorage.saveFavorites(favoriteItems)
    }
    
    private func getFavoriteItems() -> [Favorite] {
        
        return pcItems.filter({ $0.favorite() }).compactMap {
            Favorite(
                id: $0.id,
                name: $0.name,
                manufacturer: $0.manufacturer,
                model: $0.model
            )
        }
    }
    
    private func markFavoritesFromSavedItems(catalogItems: [Pc], savedFavorites: [Favorite]) -> [Pc] {
        var updatedCatalogItems = catalogItems
        
        for (index, item) in updatedCatalogItems.enumerated() {
            if savedFavorites.contains(where: { $0.id == item.id }) {
                updatedCatalogItems[index].isFavorite = true
            }
        }
        
        return updatedCatalogItems
    }
}
