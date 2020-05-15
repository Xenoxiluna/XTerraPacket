//
//  PacketPlayerBuff.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

//Incomplete

import Foundation
import SwiftyBytes

public struct PacketPlayerBuff: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerBuff
    public var payload: [UInt8] = []
    private let MAX_BUFFS = 22
    
    public var playerId: UInt8 = 0
    public var buffs: [UInt8] = []
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        
        for _ in 0..<self.MAX_BUFFS{
            buffs += [try reader.readUInt8()]
        }
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
