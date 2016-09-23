//
//  CSSearchableItemGenerator.swift
//  CSSearchQueryController
//
//  Created by alexruperez on 22/9/16.
//  Copyright © 2016 alexruperez. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

class CSSearchableItemGenerator {
    static func generate(amount: Int) -> [CSSearchableItem] {
        var searchableItems = [CSSearchableItem]()
        for i in (1..<amount+1) {
            let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
            searchableItemAttributeSet.identifier = String(i)
            searchableItemAttributeSet.relatedUniqueIdentifier = String(i)
            searchableItemAttributeSet.title = String(i)
            searchableItemAttributeSet.displayName = String(i)
            searchableItemAttributeSet.keywords = [String(i), String(amount)]
            searchableItemAttributeSet.creator = "alexruperez"
            searchableItemAttributeSet.kind = String(amount)
            searchableItemAttributeSet.textContent = String(i)
            searchableItemAttributeSet.contentDescription = String(i)
            searchableItemAttributeSet.subject = String(amount)
            searchableItemAttributeSet.genre = String(amount)

            let searchableItem = CSSearchableItem(uniqueIdentifier: String(i), domainIdentifier: String(amount), attributeSet: searchableItemAttributeSet)
            searchableItems.append(searchableItem)
        }
        return searchableItems
    }
}
