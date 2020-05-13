//
//  PacketUpdateShieldStrengths.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketUpdateShieldStrengths: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .UpdateShieldStrengths
    public var payload: [UInt8] = []
    public var solarTowerShield: UInt16 = 0
    public var vortexTowerShield: UInt16 = 0
    public var nebulaTowerShield: UInt16 = 0
    public var stardustTowerShield: UInt16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.solarTowerShield = try reader.readUInt16()
        self.vortexTowerShield = try reader.readUInt16()
        self.nebulaTowerShield = try reader.readUInt16()
        self.stardustTowerShield = try reader.readUInt16()
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
