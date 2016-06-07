//
//  FeedParser.swift
//  RSSReader
//
//  Created by PhuND on 5/17/16.
//  Copyright © 2016 PhuND. All rights reserved.
//

import Foundation

class FeedParser: NSObject, NSXMLParserDelegate {
    private var rssItems: [(title: String, description: String, pubDate: String)] = []
    private var currentElement: String = ""
    private var currentTitle: String = ""
    private var currentDescription: String = ""
    private var currentPubDate: String = ""
    
    private var parserCompleteHandler: ([(title: String, description: String, pubDate: String)] -> Void)?
    
    func parseFeed(url: String, completionHandler: ([(title: String, description: String, pubDate: String)] -> Void)?) {
        self.parserCompleteHandler = completionHandler
        
        let requesst = NSURLRequest(URL: NSURL(string: url)!)
        let urlSession = NSURLSession.sharedSession()
        let task =  urlSession.dataTaskWithRequest(requesst, completionHandler: {(data, response, error) -> Void in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            // parse XML data
            let parser = NSXMLParser(data: data)
            parser.delegate = self
            parser.parse()
        })
        
        task.resume()
    }
    
    // MARK: XMLParser
    func parserDidStartDocument(parser: NSXMLParser) {
        rssItems = []
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title":
            currentTitle += string
        case "description":
            currentDescription += string
        case "pubDate":
            currentPubDate += string
        default:
            break
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = (title: currentTitle, description: currentDescription, pubDate: currentPubDate)
            rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        parserCompleteHandler?(rssItems)
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError.localizedDescription)
    }
}