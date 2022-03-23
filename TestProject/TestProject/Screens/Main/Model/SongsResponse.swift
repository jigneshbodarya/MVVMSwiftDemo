//
//  SongsResponse.swift
//  TestProject
//
//  Created by Jignesh's Mac on 26/06/21.
//

import Foundation

struct SongsResponse : Codable {
    let resultCount : Int?
    let songs : [SongDetails]?

    enum CodingKeys: String, CodingKey {

        case resultCount = "resultCount"
        case songs = "results"
    }
}

struct SongDetails : Codable {
    let wrapperType : String?
    let kind : String?
    let artistId : Int?
    let collectionId : Int?
    let trackId : Int?
    let artistName : String?
    let collectionName : String?
    let trackName : String?
    let collectionCensoredName : String?
    let trackCensoredName : String?
    let artistViewUrl : String?
    let collectionViewUrl : String?
    let trackViewUrl : String?
    let previewUrl : String?
    let artworkUrl30 : String?
    let artworkUrl60 : String?
    let artworkUrl100 : String?
    let collectionPrice : Double?
    let trackPrice : Double?
    let releaseDate : String?
    let collectionExplicitness : String?
    let trackExplicitness : String?
    let discCount : Int?
    let discNumber : Int?
    let trackCount : Int?
    let trackNumber : Int?
    let trackTimeMillis : Int?
    let country : String?
    let currency : String?
    let primaryGenreName : String?
    let isStreamable : Bool?

    enum CodingKeys: String, CodingKey {

        case wrapperType = "wrapperType"
        case kind = "kind"
        case artistId = "artistId"
        case collectionId = "collectionId"
        case trackId = "trackId"
        case artistName = "artistName"
        case collectionName = "collectionName"
        case trackName = "trackName"
        case collectionCensoredName = "collectionCensoredName"
        case trackCensoredName = "trackCensoredName"
        case artistViewUrl = "artistViewUrl"
        case collectionViewUrl = "collectionViewUrl"
        case trackViewUrl = "trackViewUrl"
        case previewUrl = "previewUrl"
        case artworkUrl30 = "artworkUrl30"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case collectionPrice = "collectionPrice"
        case trackPrice = "trackPrice"
        case releaseDate = "releaseDate"
        case collectionExplicitness = "collectionExplicitness"
        case trackExplicitness = "trackExplicitness"
        case discCount = "discCount"
        case discNumber = "discNumber"
        case trackCount = "trackCount"
        case trackNumber = "trackNumber"
        case trackTimeMillis = "trackTimeMillis"
        case country = "country"
        case currency = "currency"
        case primaryGenreName = "primaryGenreName"
        case isStreamable = "isStreamable"
    }
}
