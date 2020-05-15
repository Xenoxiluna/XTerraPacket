//
//  PacketWorldInfo.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

// Incomplete

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   empty packet [3, 0, 6]
///
/// ----------------------------------
public struct PacketWorldInfo: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .WorldInfo
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
