//
//  PacketTamperWithNPC.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//

import Foundation
import SwiftyBytes

public struct PacketTamperWithNPC: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TamperWithNPC
    public var payload: [UInt8] = []
    public var npcId: UInt16 = 0
    public var check: UInt8 = 0
    public var time: Int32 = 0
    public var fromWho: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readUInt16()
        self.check = try reader.readUInt8()
        if (self.check == 1) {
            self.time = try reader.readInt32()
            self.fromWho = try reader.readInt16()
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt16(npcId)
        try writer.writeUInt8(check)
        if (self.check == 1) {
            try writer.writeInt32(time)
            try writer.writeInt16(fromWho)
        }
        payload.append(contentsOf: writer.data.bytes)
    }
}
