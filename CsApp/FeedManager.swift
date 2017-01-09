//
//  FeedManager.swift
//  CsApp
//
//  Created by William Gossard on 09/01/2017.
//  Copyright © 2017 William Gossard. All rights reserved.
//

import Foundation
import SWXMLHash

class FeedManager {

    static let shared: FeedManager = {
        let instance = FeedManager()
        return instance
    }()
    
    var feeds : [Feed] = []
    
    init() {
        self.populateFeeds()
    }
    
    func populateFeeds() {
        let url = NSURL(string: Config.URLFEED)
        let pattern = "src=\"([^\"]*)\""

        
        do {
            let xmlString = try String(contentsOf: url as! URL)
            let xml = SWXMLHash.parse(xmlString)
            let items = xml["rss"]["channel"]["item"]
            for item in items {
                let feed = Feed()
                
                // get title
                feed.title = item["title"].element!.text!
                
                // get links
                let content = item["content:encoded"].element!.text!
                let nsContent = content as NSString
                let regex = try NSRegularExpression(pattern: pattern, options: [])
                let matches = regex.matches(in: content, options: [], range: NSMakeRange(0, content.characters.count))
                for match in matches {
                    let group1 : NSRange = match.rangeAt(1)
                    let matchText1 = nsContent.substring(with: group1)
                    feed.link = matchText1
                    
                }
                
                // insert in Dictionnary
                feeds.append(feed)

            }
            
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
}
