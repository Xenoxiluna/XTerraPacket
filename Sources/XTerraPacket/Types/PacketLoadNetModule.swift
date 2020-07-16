//
//  PacketLoadNetModule.swift
//  
//
//  Created by Quentin Berry on 5/5/20.
//

import Foundation
import SwiftyBytes

/// TODO: Add additional 1.4 creative stuff
public struct PacketLoadNetModule: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .LoadNetModule
    public var payload: [UInt8] = []
    public var netModuleType: NetModuleType = .Liquid
    public lazy var netModule: NetModule = NetModuleChat()
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        if let m = NetModuleType.init(rawValue: try reader.readUInt16()){
            self.netModuleType = m
        }
        
        switch self.netModuleType{
        case .Ambience:
            break
        case .Bestiary:
            break
        case .Chat:
            self.netModule = NetModuleChat()
            try self.netModule.decode(reader)
        case .CreativePowerPermissions:
            break
        case .CreativePowers:
            break
        case .CreativeUnlocks:
            break
        case .CreativeUnlocksReport:
            break
        case .Liquid:
            break
        case .Particles:
            break
        case .Ping:
            break
        case .TeleportPylon:
            break
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt16(netModuleType.rawValue)
        switch self.netModuleType{
        case .Ambience:
            break
        case .Bestiary:
            break
        case .Chat:
            try self.netModule.encode(writer)
        case .CreativePowerPermissions:
            break
        case .CreativePowers:
            break
        case .CreativeUnlocks:
            break
        case .CreativeUnlocksReport:
            break
        case .Liquid:
            break
        case .Particles:
            break
        case .Ping:
            break
        case .TeleportPylon:
            break
        }
        payload.append(contentsOf: writer.data.bytes)
    }
    
    public enum NetModuleType: UInt16{
        case Liquid = 0
        case Chat = 1
        case Ping = 2
        case Ambience = 3
        case Bestiary = 4
        case CreativeUnlocks = 5
        case CreativePowers = 6
        case CreativeUnlocksReport = 7
        case TeleportPylon = 8
        case Particles = 9
        case CreativePowerPermissions = 10
    }
}
