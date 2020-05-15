//
//  PacketClientUUID.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketClientUUID: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ClientUUID
    public var payload: [UInt8] = []
    public var UUID: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.UUID = try reader.read7BitEncodedString()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.write7BitEncodedString(UUID, encoding: .utf8)
        payload.append(contentsOf: writer.data)
    }
}
