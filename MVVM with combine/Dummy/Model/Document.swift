//
//  Docks.swift
//  Dummy
//
//  Created by Sulay on 06/03/24.
//

import Foundation

struct DocumentResponse: Decodable {
    let response: Document?
}

struct Document: Decodable {
    var docs: [Doc]
}

struct Doc: Decodable {
    var abstract: String
    var headline: Headline
    var multimedia: [Multimedia]
}

struct Headline: Decodable {
    var main: String
}

struct Multimedia: Decodable {
    var url: String
}
