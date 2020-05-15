//
//  PacketUpdateNPCName.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketUpdateNPCName: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .UpdateNPCName
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    public var name: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readInt16()
        if (reader.data.data.count > reader.readIndex) {
            self.name = try reader.read7BitEncodedString()
        }
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
