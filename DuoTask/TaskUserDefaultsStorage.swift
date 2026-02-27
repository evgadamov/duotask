//
//  TaskUserDefaultsStorage.swift
//  DuoTask
//
//  Created by Ruslan Marlinsky on 13.02.2026.
//


import Foundation

enum TaskUserDefaultsStorage {
    
    private static let key = "savedTask"
    
    static func load() -> [Task] {
        guard let dataTask = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        
        let decodedTasks = try? JSONDecoder().decode([Task].self, from: dataTask)
        return decodedTasks ?? []
    }
    
    static func save(tasks: [Task]) {
        let encodedTasks = try? JSONEncoder().encode(tasks)
        UserDefaults.standard.set(encodedTasks, forKey: key)
    }
}
