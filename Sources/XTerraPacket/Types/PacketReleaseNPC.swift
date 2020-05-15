//
//  PacketReleaseNPC.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketReleaseNPC: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ReleaseNPC
    public var payload: [UInt8] = []
    public var x: Int32 = 0
    public var y: Int32 = 0
    public var npcType: Int16 = 0
    public var style: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.x = try reader.readInt32()
        self.y = try reader.readInt32()
        self.npcType = try reader.readInt16()
        self.style = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
