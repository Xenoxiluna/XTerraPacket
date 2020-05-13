//
//  PacketZonesAlt.swift
//
//
//  Created by Quentin Berry on 5/10/20.
//

import Foundation
import SwiftyBytes

/// Payload Structure
/// Offset  |  Type  |  Description
///   1-4        UInt32    x
///   5-8        UInt32    y
///
/// ----------------------------------
public struct PacketZonesAlt: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .Zones
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var zone1: UInt8 = 0
    public var zone2: UInt8 = 0
    public var zone3: UInt8 = 0
    public var zone4: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.zone1 = try reader.readUInt8()
        self.zone2 = try reader.readUInt8()
        self.zone3 = try reader.readUInt8()
        self.zone4 = try reader.readUInt8()
    }
    public func encoded() -> [UInt8]{
        print("Not Implemented")
        return []
    }
    mutating public func encode(){
        print("Not Implemented")
    }
    public func getLength(){
        print("Not Implemented")
    }
}
