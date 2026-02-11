//
//  TaskUserDefaultsStorage.swift
//  DuoTask
//
//  Created by Ruslan Marlinsky on 17.12.2025.
//

import Foundation

enum TaskUserDefaultsStorage {
    private static let key = "savedTasks"

    static func load() -> [Task] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try JSONDecoder().decode([Task].self, from: data)
        } catch {
            return []
        }
    }

    static func save(_ tasks: [Task]) {
        do {
            let data = try JSONEncoder().encode(tasks)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            // Encoding failed, skip save
        }
    }
}
