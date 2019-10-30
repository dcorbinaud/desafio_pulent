//
//  ituneModel.swift
//  desafio_pulent
//
//  Created by bild on 10/29/19.
//

import Foundation

struct song: Decodable {
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let collectionCensoredName: String?
    let trackCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl30: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let trackPrice: Double?
    let collectionHdPrice: Double?
    let trackHdPrice: Double?
    let releaseDate: String?
    let currency: String?
    let shortDescription: String?
}

struct ituneData: Decodable {
    let results: [song]?
}
