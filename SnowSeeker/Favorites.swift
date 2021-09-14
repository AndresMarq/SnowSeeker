//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Andres Marquez on 2021-09-09.
//

import SwiftUI

class Favorites: ObservableObject {
    //resorts the user selected as favorites
    private var resorts: Set<String>
    
    //key to be used to read/write in UserDefaults
    private let saveKey = "Favorites"
    
    init() {
        //load saved data
        if let data = UserDefaults.standard.data(forKey: self.saveKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decoded
                return
            }
        }
        
        //still here? Use empty array
        self.resorts = []
    }
    
    //returns true if set contains chosen resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    //adds resort to our set, update View, saves changes
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    //removes resort from set, update view and saves changes
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        //write our data
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: self.saveKey)
        }
    }
}
