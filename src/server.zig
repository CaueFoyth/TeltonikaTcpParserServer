//! Este é o arquivo root.zig para a biblioteca TeltonikaTcpParserServer.
//! Ele fornece uma interface para criar e gerenciar um servidor TCP que processa conexões.
const std = @import("std");
const testing = std.testing;

// Estrutura para representar o servidor
pub const TcpServer = struct {
    address: std.net.Address,
    server: std.net.Server,

    // Inicializa o servidor com um endereço e porta
    pub fn init(ip: []const u8, port: u16) !TcpServer {
        const address = try std.net.Address.parseIp(ip, port);
        const server = try address.listen(.{});
        return TcpServer{
            .address = address,
            .server = server,
        };
    }

    // Libera os recursos do servidor
    pub fn deinit(self: *TcpServer) void {
        self.server.deinit();
    }

    pub fn acceptAndHandle(self: *TcpServer, comptime handler: fn ([]const u8) []const u8) !void {
        while (true) {
            const conn = try self.server.accept();
            defer conn.stream.close();

            std.debug.print("Nova conexão de {}\n", .{conn.address});

            var buffer: [1024]u8 = undefined;
            const bytes_read = try conn.stream.read(&buffer);
            if (bytes_read > 0) {
                var packet = buffer[0..bytes_read];

                const expected_prefix: [2]u8 = [2]u8{ 0x00, 0x0f };
                if (packet.len < 2 or !std.mem.eql(u8, packet[0..2], expected_prefix[0..])) return;

                // Extrai e exibe o IMEI
                const imei_length = std.mem.readInt(u16, packet[0..2], .big);
                if (packet.len < 2 + imei_length) return; // Garante que há bytes suficientes para o IMEI
                const imei = packet[2 .. 2 + imei_length];
                packet = packet[2 + imei_length ..];

                std.debug.print("IMEI recebido: ", .{});
                for (imei) |byte| {
                    std.debug.print("{x:0>2} ", .{byte});
                }
                std.debug.print("\n", .{});

                // Converte o IMEI de ASCII para um inteiro
                var imei_int: u64 = 0;
                for (imei) |byte| {
                    imei_int = imei_int * 10 + (byte - '0');
                }

                std.debug.print("IMEI como inteiro: {}\n", .{imei_int});

                // Determina se aceita o IMEI
                const accept_imei = true; // Aqui você pode adicionar a lógica para aceitar ou rejeitar o IMEI
                if (accept_imei) {
                    _ = try conn.stream.write(&[_]u8{0x01}); // Aceita a conexão

                    // Espera o próximo hexadecimal
                    var next_buffer: [1024]u8 = undefined;
                    const next_bytes_read = try conn.stream.read(&next_buffer);
                    if (next_bytes_read > 0) {
                        const next_packet = next_buffer[0..next_bytes_read];

                        // Exibe os bytes recebidos em hexadecimal
                        std.debug.print("Próximos bytes recebidos (hex): ", .{});
                        for (next_packet) |byte| {
                            std.debug.print("{x:0>2} ", .{byte});
                        }
                        std.debug.print("\n", .{});

                        // Processa o próximo pacote
                        packet = next_packet;
                    }
                } else {
                    _ = try conn.stream.write(&[_]u8{0x00}); // Rejeita a conexão
                    return;
                }

                std.debug.print("\n", .{});

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                // Extração do preâmbulo (4 bytes)
                if (packet.len < 4) return; // Garante que há pelo menos 4 bytes disponíveis
                const preamble = packet[0..4];
                packet = packet[4..];

                std.debug.print("Preâmbulo (hex): ", .{});
                for (preamble) |byte| {
                    std.debug.print("{x:0>2} ", .{byte});
                }
                std.debug.print("\n", .{});

                // Converter o preâmbulo para decimal
                const preamble_value: u32 = (@as(u32, preamble[0]) << 24) |
                    (@as(u32, preamble[1]) << 16) |
                    (@as(u32, preamble[2]) << 8) |
                    (@as(u32, preamble[3]));

                std.debug.print("Preâmbulo (decimal): {}\n", .{preamble_value});

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                // Extração do tamanho do campo de dados (4 bytes)
                if (packet.len < 4) return;
                const data_field = packet[0..4];
                packet = packet[4..];

                std.debug.print("Tamanho do campo de dados (hex): ", .{});
                for (data_field) |byte| {
                    std.debug.print("{x:0>2} ", .{byte});
                }
                std.debug.print("\n", .{});

                // Converter o tamanho do campo de dados para decimal
                const data_size: u32 = (@as(u32, data_field[0]) << 24) |
                    (@as(u32, data_field[1]) << 16) |
                    (@as(u32, data_field[2]) << 8) |
                    (@as(u32, data_field[3]));

                std.debug.print("Tamanho do campo de dados (decimal): {}\n", .{data_size});

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                if (packet.len < 1) return;
                const codec_id = packet[0];
                packet = packet[1..];

                std.debug.print("ID do codec (hex): {x:0>2}", .{codec_id});
                std.debug.print("\n", .{});
                std.debug.print("ID do codec (decimal): {}\n", .{codec_id});

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                if (packet.len < 1) return;
                const number_data = packet[0];
                packet = packet[1..];

                std.debug.print("Number of Data (hex): {x:0>2}", .{number_data});
                std.debug.print("\n", .{});
                std.debug.print("Number of Data (decimal): {}\n", .{number_data});

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                if (packet.len <= 4) return;
                const last_4_bytes = packet[packet.len - 4 ..];
                packet = packet[0 .. packet.len - 4];

                std.debug.print("CRC-16 (hex): ", .{});
                for (last_4_bytes) |byte| {
                    std.debug.print("{x:0>2} ", .{byte});
                }
                std.debug.print("\n", .{});

                const crc16: u32 = (@as(u32, last_4_bytes[0]) << 24) |
                    (@as(u32, last_4_bytes[1]) << 16) |
                    (@as(u32, last_4_bytes[2]) << 8) |
                    (@as(u32, last_4_bytes[3]));

                std.debug.print("CRC-16 (decimal): {}\n", .{crc16});

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                if (packet.len < 1) return;
                const number_data_2 = packet[packet.len - 1];
                packet = packet[0 .. packet.len - 1];

                std.debug.print("Number of Data 2 (hex): {x:0>2}", .{number_data_2});
                std.debug.print("\n", .{});
                std.debug.print("Number of Data 2 (decimal): {}\n", .{number_data_2});

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                if (packet.len <= 8) return;
                const timestamp_bytes = packet[0..8];
                packet = packet[8..];

                std.debug.print("Timestamp (hex): ", .{});
                for (timestamp_bytes) |byte| {
                    std.debug.print("{x:0>2} ", .{byte});
                }
                std.debug.print("\n", .{});

                // Converter o tamanho do campo de dados para decimal
                const timestamp: u64 = (@as(u64, timestamp_bytes[0]) << 56) |
                    (@as(u64, timestamp_bytes[1]) << 48) |
                    (@as(u64, timestamp_bytes[2]) << 40) |
                    (@as(u64, timestamp_bytes[3]) << 32) |
                    (@as(u64, timestamp_bytes[4]) << 24) |
                    (@as(u64, timestamp_bytes[5]) << 16) |
                    (@as(u64, timestamp_bytes[6]) << 8) |
                    (@as(u64, timestamp_bytes[7]));

                std.debug.print("Timestamp (decimal): {}\n", .{timestamp});

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                if (packet.len < 1) return;
                const priority_bytes = packet[0];
                packet = packet[1..];

                std.debug.print("Priority (hex): {x:0>2}", .{priority_bytes});
                std.debug.print("\n", .{});
                std.debug.print("Priority (decimal): {}\n", .{priority_bytes});

                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                // Exibir os bytes restantes após a extração
                std.debug.print("Bytes faltantes (hex): ", .{});
                for (packet) |byte| {
                    std.debug.print("{x:0>2} ", .{byte});
                }
                std.debug.print("\n\n\n", .{});

                // Chama o handler personalizado para processar a mensagem
                const response = handler(packet);
                _ = try conn.stream.write(response);
            }
        }
    }
};

// Função de exemplo para handler
pub fn defaultHandler(message: []const u8) []const u8 {
    _ = message; // Evita warning de variável não utilizada
    return "Mensagem recebida com sucesso!\n";
}
