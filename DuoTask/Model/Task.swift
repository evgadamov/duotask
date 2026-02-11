//
//  Task.swift
//  DuoTask
//
//  Created by Ruslan Marlinsky on 19.12.2025.
//

import Foundation

struct Task: Codable {
    let id: UUID
    var subject: String
    var body: String
}
