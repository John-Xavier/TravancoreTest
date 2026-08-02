//
//  Company.swift
//  TravancoreTest
//
//  Created by John Xavier  on 01/08/2026.
//
import Foundation

struct Company: Codable, Hashable {
    let name: String
    let city: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case city = "City"
        case id = "id"
    }
}

