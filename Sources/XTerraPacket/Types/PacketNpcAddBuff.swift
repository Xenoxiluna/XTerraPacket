//
//  PacketNpcAddBuff.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketNpcAddBuff: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NpcAddBuff
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    public var buff: UInt16 = 0
    public var time: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readInt16()
        self.buff = try reader.readUInt16()
        self.time = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeInt16(npcId)
        try writer.writeUInt16(buff)
        try writer.writeInt16(time)
        payload.append(contentsOf: writer.data.bytes)
    }
}
