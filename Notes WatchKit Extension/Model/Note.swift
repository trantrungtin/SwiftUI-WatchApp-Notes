//
//  Note.swift
//  Notes WatchKit Extension
//
//  Created by Tin Tran on 11/06/2022.
//

import Foundation

struct Note: Identifiable, Codable {
    let id: UUID
    let text: String
}
