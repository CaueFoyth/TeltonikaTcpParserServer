# TeltonikaTcpParserServer

## Objective

The goal of this project is to develop a TCP server capable of parsing data from any Teltonika device. The server is designed to accept connections from Teltonika devices, receive data, and process it according to the device specifications.

## Features

- **IMEI Parsing**: Parses the IMEI of Teltonika devices to identify the device.
- **Data Field Extraction and Processing**:
  - **Preamble**: Extracts the preamble from the received data, which is used for synchronization.
  - **Data Size**: Extracts the data size, which indicates the length of the subsequent data.
  - **Codec ID**: Extracts the codec ID, which identifies the type of encoded data.
  - **Number of Data**: Extracts the number of data sets present.
  - **CRC16**: Calculates and verifies the CRC16 of the data to ensure data integrity.
  - **Timestamp**: Extracts the timestamp from the data, indicating when the data was generated.
  - **Priority**: Extracts the priority of the data, which can be used to determine the importance of the data.
- Modular and extensible code.

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/TeltonikaTcpParserServer.git
    cd TeltonikaTcpParserServer
    ```

2. Install Zig (if not already installed):
    Follow the instructions on the [Zig website](https://ziglang.org/download/) to install Zig.

## How to Run

To run the server, use the command:

```sh
zig build run
```

The server will start and listen on port 2202.

## Project Structure

- `src/main.zig`: Main file that initializes and runs the TCP server.
- `src/server.zig`: Contains the implementation of the TCP server.
- `src/parser/parser.zig`: Main parser module that imports various parsing functions.
- `src/parser/teltonika/`: Directory containing individual parsing functions for different data fields.
- `src/model/teltonika_data.zig`: Data model representing the structure of Teltonika data.

## Usage

Once the server is running, it will accept connections from Teltonika devices and process the received data. The parsed data will be printed to the console for debugging purposes.

## Dependencies

- Zig: Make sure you have the Zig compiler installed on your machine.

## Feature Details

### IMEI Parsing

The `imei_handler` function parses the IMEI of Teltonika devices. The IMEI is a unique identifier for each device and is essential for identifying the source of the data.

### Preamble

The `parsePreamble` function extracts the preamble from the received data. The preamble is used for synchronization and ensures that the subsequent data is interpreted correctly.

### Data Size

The `parseDataField` function extracts the data size, which indicates the length of the subsequent data. This is important to know how many bytes should be read for the next fields.

### Codec ID

The `parseCodecId` function extracts the codec ID, which identifies the type of encoded data. Different codecs can be used for different types of data, and the codec ID helps determine how the data should be decoded.

### Number of Data

The `parseNumberData` function extracts the number of data sets present. This is useful for iterating over multiple data sets in a single message.

### CRC16

The `parseCrc16` function calculates and verifies the CRC16 of the data to ensure data integrity. The CRC16 is a checksum value that helps detect errors in the transmitted data.

### Timestamp

The `parseTimestamp` function extracts the timestamp from the data, indicating when the data was generated. This is useful for logging when events occurred.

### Priority

The `parsePriority` function extracts the priority of the data, which can be used to determine the importance of the data. Higher priority data can be processed before lower priority data.

## Contribution

Contributions are welcome! Feel free to open issues and pull requests.

## License

This project is licensed under the MIT License.