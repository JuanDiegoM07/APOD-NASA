//
//  ApodFake.swift
//  APODTests
//
//  Created by Juan Diego Marin on 1/11/22.
//

import Foundation
@testable import APOD

enum ApodFake {
    static var values: [PlaneratyInformation] {
        [.init(copyright: "",
               date: "",
               explanation: "",
               hdurl: "",
               mediaType: "",
               serviceVersion: "",
               title: "",
               url: "")]
    }
}
