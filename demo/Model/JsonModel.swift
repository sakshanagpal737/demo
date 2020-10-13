//
//  JsonModel.swift
//  massMobileMassage
//
//  Created by Krishna on 13/10/20.
//  Copyright © 2020 Saksha. All rights reserved.
//

import UIKit


struct JsonModel : Codable {
    let title : String
    let description : String
    let imageHref : String
   
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }
    
}

/*
class JsonModel: NSObject {

    var titleString: String?
    var descriptionString: String?
    var imageUrl:String?
       
       init(obj: [String:AnyObject])
          {
             if let titleString = obj["title"] as? String {
             self.titleString = titleString
             }

            if let description = obj["description"] as? String {
                        self.descriptionString = description
                        }
            
            if let image = obj["imageHref"] as? String {
                        self.imageUrl = image
                        }
           
       }
}
*/
