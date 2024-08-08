//
//  responseStruct.swift
//  vaLineup_swift
//
//  Created by Juan Carlos Hernández Cárdenas
//

import Foundation

struct Response: Codable{
    // el URL de la lista: https://private-2f576-valineupsapi.apiary-mock.com/org/org_list
    let id: String
    let thumbnail: String
    let title: String
}

struct ResponseDetail: Codable{
    //URL del detalle: https://private-2f576-valineupsapi.apiary-mock.com/org/org_detail/{ID}
    let title: String
    let image: String
    let sovaLineup: String
    let kayoLineup: String
    let gekkoLineup: String
    let viperLineup: String
    let kjLineup: String
    let fadeLineup: String
    let brimLineup: String
}
