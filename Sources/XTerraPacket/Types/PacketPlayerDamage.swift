//
//  PacketPlayerDamage.swift
//  
//
//  Created by Quentin Berry on 5/10/20.
//

// INCOMPLETE

import Foundation
import SwiftyBytes

public struct PacketPlayerDamage: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerDamage
    public var payload: [UInt8] = []
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        print("Not Implemented")
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
