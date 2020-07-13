//
//  PacketCatchNPC.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketCatchNPC: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .CatchNPC
    public var payload: [UInt8] = []
    public var npcId: UInt16 = 0
    public var who: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readUInt16()
        self.who = try reader.readUInt8()
    }
    
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt16(npcId)
        try writer.writeUInt8(who)
        payload.append(contentsOf: writer.data.bytes)
    }
}
