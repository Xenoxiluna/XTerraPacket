//
//  PacketSetCountsAsHostForGameplay.swift
//
//
//  Created by Quentin Berry on 5/22/20.
//

import Foundation
import SwiftyBytes

public struct PacketSetCountsAsHostForGameplay: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .SetCountsAsHostForGameplay
    public var payload: [UInt8] = []
    public var id: UInt8 = 0
    public var value: Bool = false
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.id = try reader.readUInt8()
        self.value = try reader.readBool()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(id)
        try writer.writeBool(value)
        payload.append(contentsOf: writer.data.bytes)
    }
}
