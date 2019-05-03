//
//  RideRequest.swift
//  WePool
//
//  Created by Raj Kadiyala on 5/2/19.
//  Copyright © 2019 WePool. All rights reserved.
//

import Foundation

enum Status : Int {
    case pending = 0
    case confirmed = 1
    case notAccepted = -1
}

@objcMembers
class RideRequest:NSObject ,Encodable,Decodable{
    var fromId: String!
    var toDriverId: String!
    var requestStatus: Int!
    var timeStamp : Date!
    var ridePostId : String!
    var fromIdFirstName : String!
    var rideRequestId : String!
}
