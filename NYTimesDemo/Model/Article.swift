//
//  Audiobook.swift
//
//  Created by Jhanvi on 24/07/18.
//  Copyright © 2018 Jhanvi. All rights reserved.
//

import Foundation

enum Constants {
    static let url = "url"
    static let webUrl = "web_url"
    static let byline = "byline"
    static let title = "title"
    static let publishedDate = "published_date"
    static let abstract = "abstract"
    static let media = "media"
    static let mediaMetadata = "media-metadata"
}

struct Article {
    let header: String
    let description: String
    let author: String
    let publishDate: String
    let webUrl: String
    let tumbnailUrl: URL
    let detailImageURL: URL
    
    
    
    init(dictionary: ArticleData) throws {
        
        guard let title = dictionary[Constants.title] as? String else {
            throw SerializationError.missing(Constants.title)
        }
        
        guard let abstract = dictionary[Constants.abstract] as? String else {
            throw SerializationError.missing(Constants.abstract)
        }

        guard let author = dictionary[Constants.byline] as? String else {
            throw SerializationError.missing(Constants.byline)
        }
        self.header = title
        self.description = abstract
        self.author = author
        
        self.publishDate = dictionary[Constants.publishedDate] as! String
        self.webUrl = dictionary[Constants.url] as! String
        
        let media = dictionary[Constants.media] as! NSArray
        let metaData = media.firstObject as! NSDictionary
        let mediaMetadata = metaData[Constants.mediaMetadata] as! NSArray
        print(mediaMetadata)

        let imageComposite = mediaMetadata[0] as! NSDictionary
        print(imageComposite)
        let thumbnailUrlString = imageComposite[Constants.url] as? String
        self.tumbnailUrl = URL(string: thumbnailUrlString!)!
        
        let imageDetail = mediaMetadata[2] as! NSDictionary
        print(imageComposite)
        let normalImageUrl = imageDetail[Constants.url] as? String
        self.detailImageURL = URL(string: normalImageUrl!)!
    }
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

