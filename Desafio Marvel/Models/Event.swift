//
//  Event.swift
//  Desafio Marvel
//
//  Created by Felipe Brigagão de Almeida on 02/04/22.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let events = try? newJSONDecoder().decode(Events.self, from: jsonData)

import Foundation

// MARK: - Events
struct Events: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DataClassEvent?
}

// MARK: - DataClass
struct DataClassEvent: Codable {
    let offset, limit, total, count: Int?
    let results: [ResultEvent]?
}

// MARK: - Result
struct ResultEvent: Codable {
    let id: Int?
    let title, resultDescription: String?
    let resourceURI: String?
    let urls: [URLElementEvent]?
    //let modified: Date?
//    let start, end: String?
    let thumbnail: Thumbnail?
//    let creators: Creators?
//    let characters: Characters?
//    let stories: Stories?
//    let comics, series: Characters?
//    let next, previous: Next?
}

// MARK: - Characters
struct Characters: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [Next]?
    let returned: Int?
}

// MARK: - Next
struct Next: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - Creators
struct Creators: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [CreatorsItem]?
    let returned: Int?
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    let resourceURI: String?
    let name, role: String?
}

// MARK: - Stories
struct StoriesEvent: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [StoriesItem]?
    let returned: Int?
}

// MARK: - StoriesItem
struct StoriesItemEvent: Codable {
    let resourceURI: String?
    let name: String?
    //let type: TypeEnum?
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case textStory = "text story"
}

// MARK: - Thumbnail
struct ThumbnailEvent: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension
    }
}

// MARK: - URLElement
struct URLElementEvent: Codable {
    let type: String?
    let url: String?
}

