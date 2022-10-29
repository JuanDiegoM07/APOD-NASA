//
//  Planetary.PlaneratyInformation
//  APOD
//
//  Created by Juan Diego Marin on 28/10/22.
//

import Foundation


class PlaneratyInformation: Decodable  {
    let copyright: String?
    let date: String?
    let explanation: String?
    let hdurl: String?
    let mediaType: String?
    let serviceVersion: String?
    let title: String?
    let url: String?
    
    init(copyright: String?, date: String?, explanation: String?, hdurl: String?, mediaType: String?, serviceVersion: String?, title: String?, url: String?) {
        self.copyright = copyright
        self.date = date
        self.explanation = explanation
        self.hdurl = hdurl
        self.mediaType = mediaType
        self.serviceVersion = serviceVersion
        self.title = title
        self.url = url
    }
}
