//
//  PacketLoadNetModule.swift
//  
//
//  Created by Quentin Berry on 5/5/20.
//

import Foundation
import SwiftyBytes

/// TODO: Add additional 1.4 creative stuff
/*Packet type: LoadNetModule
NetModule Packet Bytes: [14, 0, 82, 1, 0, 3, 83, 97, 121, 4, 116, 101, 115, 116]

Header
14, 0, 82,

Payload
1, 0, 3, 83, 97, 121, 4, 116, 101, 115, 116


Load Net Module:
1, 0

Command: Say
3, 83, 97, 121

TextLength
4,

Text
116, 101, 115, 116*/
public struct PacketLoadNetModule: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .LoadNetModule
    public var payload: [UInt8] = []
    public var netModuleId: UInt16 = 1
    public var command: CommandType = .Say
    public var message: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.netModuleId = try reader.readUInt16()
        
        if let c = CommandType.init(rawValue: try reader.readVariableLengthString(.utf8)){
            self.command = c
        }
        
        self.message = try reader.readVariableLengthString(.utf8)
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt16(netModuleId)
        try writer.writeVariableLengthString(command.rawValue, .utf8)
        try writer.writeVariableLengthString(message, .utf8)
        payload.append(contentsOf: writer.data.bytes)
    }
    
    public enum CommandType: String{
        case Say = "\u{3}Say"
        case Emote = "\u{5}Emote"
        case Roll = "\u{4}Roll"
        case Party = "\u{5}Party"
        case Playing = "\u{7}Playing"
        case Help = "\u{4}Help"
        case RPS = "\u{3}RPS"
        case Emoji = "\u{5}Emoji"
    }
}
