import XCTest
@testable import XTerraPacket

final class XTerraPacketTests: XCTestCase {
    func testConnectRequest() {
        let pbytes: [UInt8] = [15, 0, 1, 11, 84, 101, 114, 114, 97, 114, 105, 97, 50, 51, 48]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketConnectRequest
        do{
            try newpacket.decodePayload()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.ConnectRequest)
        XCTAssertEqual(newpacket.version, "Terraria230")
    }

    func testPlayerInfo() {
        let pbytes: [UInt8] = [39, 0, 4, 3, 0, 0, 5, 98, 111, 105, 105, 51, 0, 0, 0, 0, 215, 90, 55, 255, 125, 90, 105, 90, 75, 175, 165, 140, 160, 180, 215, 255, 230, 175, 160, 105, 60, 0, 0]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketPlayerInfo
        do{
            try newpacket.decodePayload()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.PlayerInfo)
        XCTAssertEqual(newpacket.name, "\u{5}boii3")
        
        newpacket.name = "Boi4"
        do{
            try newpacket.encode()
            try newpacket.decodePayload()
        }catch {}
        XCTAssertEqual(newpacket.name, "\u{4}Boi4")
    }
    
    func testPasswordSend(){
        let pbytes: [UInt8] = [9, 0, 38, 5, 108, 111, 108, 112, 108]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketPasswordSend
        do{
            try newpacket.decodePayload()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.PasswordSend)
        XCTAssertEqual(newpacket.password.trimmingCharacters(in: .controlCharacters), "lolpl")
    }
    
    func testPlayerUpdate(){
        let pbytes: [UInt8] = [25, 0, 13, 0, 104, 20, 0, 0, 0, 114, 165, 133, 71, 0, 48, 213, 69, 84, 225, 107, 64, 0, 0, 0, 0]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketPlayerUpdate
        do{
            try newpacket.decode()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.PlayerUpdate)
        XCTAssertEqual(newpacket.positionY, 4.6667764e-10)
    }
    
    func testSayLoadNetModule(){
        let pbytes: [UInt8] = [24, 0, 82, 1, 0, 3, 83, 97, 121, 14, 116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketLoadNetModule
        do{
            try newpacket.decode()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.LoadNetModule)
        XCTAssertEqual(newpacket.netModuleType, PacketLoadNetModule.NetModuleType.Chat)
        
        let chat = newpacket.netModule as! NetModuleChat
        XCTAssertEqual(chat.command, NetModuleChat.ChatCommandType.Say)
        XCTAssertEqual(chat.message.trimmingCharacters(in: .controlCharacters), "this is a test")
        XCTAssertEqual(chat.message.trimmingCharacters(in: .controlCharacters).data(using: .utf8)!.bytes, [116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116])
    }
    
    func testCreateSayLoadNetModule(){
        var load = PacketLoadNetModule()
        load.netModuleType = .Chat
        load.netModule = NetModuleChat(command: .Say, message: "this is a test")
        do{
            try load.encode()
        }catch {}
        XCTAssertEqual(load.getType(), TerrariaPacketType.LoadNetModule)
        XCTAssertEqual(load.netModuleType, PacketLoadNetModule.NetModuleType.Chat)
        XCTAssertEqual(load.bytes, [24, 0, 82, 1, 0, 3, 83, 97, 121, 14, 116, 104, 105, 115, 32, 105, 115, 32, 97, 32, 116, 101, 115, 116])
        
        let chat = load.netModule as! NetModuleChat
        XCTAssertEqual(chat.command, NetModuleChat.ChatCommandType.Say)
        XCTAssertEqual(chat.message, "this is a test")
    }
    func testCreativeLoadNetModule(){
        let pbytes: [UInt8] = [12, 0, 82, 6, 0, 14, 0, 0, 126, 70, 9, 63]
        guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
        var newpacket = packet as! PacketLoadNetModule
        do{
            try newpacket.decode()
        }catch {}
        XCTAssertEqual(packet.getType(), TerrariaPacketType.LoadNetModule)
        XCTAssertEqual(newpacket.netModuleType, PacketLoadNetModule.NetModuleType.CreativePowers)
    }
        
    func testWorldInfo1405(){
            let pbytes: [UInt8] = [174, 0, 7, 120, 105, 0, 0, 1, 0, 208, 32, 96, 9, 131, 16, 251, 4, 233, 2, 241, 3, 1, 0, 0, 0, 18, 68, 97, 114, 107, 32, 71, 97, 109, 105, 110, 103, 32, 45, 32, 76, 105, 116, 101, 0, 162, 115, 81, 63, 236, 123, 78, 162, 148, 66, 147, 134, 228, 29, 125, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 7, 0, 6, 0, 9, 0, 8, 0, 107, 0, 108, 0, 111, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
            guard let packet = try? TerrariaPacketFactory.decodePacket(packet: pbytes) else { return }
            var newpacket = packet as! PacketWorldInfo
            do{
                try newpacket.decode()
            }catch {}
            XCTAssertEqual(packet.getType(), TerrariaPacketType.WorldInfo)
            XCTAssertEqual(newpacket.worldName, "Dark Gaming - Lite")
            XCTAssertEqual(newpacket.cloudNumber, 0)
        }
    
    static var allTests = [
        ("testConnectRequest", testConnectRequest),
        ("testPlayerInfo", testPlayerInfo),
        ("testPasswordSend", testPasswordSend),
        ("testSayLoadNetModule", testSayLoadNetModule),
        ("testCreativeLoadNetModule", testCreativeLoadNetModule),
        ("testCreateSayLoadNetModule", testCreateSayLoadNetModule),
        ("testWorldInfo1405", testWorldInfo1405),
    ]
}

extension Data {
    var bytes : [UInt8]{
        return [UInt8](self)
    }
}
