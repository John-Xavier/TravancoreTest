//
//  User.swift
//  TravancoreTest
//
//  Created by John Xavier  on 01/08/2026.
//

import Foundation

struct User: Codable,Hashable {
    let createdAt: String
      let name: String
      let avatar: String
      let id: String

      enum CodingKeys: String, CodingKey {
          case createdAt = "createdAt"
          case name = "name"
          case avatar = "avatar"
          case id = "id"
      }
}
