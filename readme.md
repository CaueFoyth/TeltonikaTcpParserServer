# TeltonikaTcpParserServer

## Objective

The objective of this project is to develop a TCP server capable of parsing data from any Teltonika device. The server accepts connections, receives data, and processes it according to the device specifications.

## Features

- **IMEI Parsing**: Identifies the device based on the IMEI.
- **Data Field Extraction and Processing**:
  - **Preamble**: Synchronizes the received data.
  - **Data Size**: Determines the size of the subsequent data.
  - **Codec ID**: Identifies the type of encoded data.
  - **Number of Data**: Counts the data sets present.
  - **CRC16**: Verifies the integrity of the data.
  - **Timestamp**: Extracts the moment when the data was generated.
  - **Priority**: Determines the importance of the data.
  - **GPS Element**: Parses location information such as latitude, longitude, altitude, speed, and angle.
  - **IO Elements**: Processes input/output elements based on predefined mappings.
- Modular and extensible code.

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/TeltonikaTcpParserServer.git
    cd TeltonikaTcpParserServer
    ```

2. Install Zig (if not already installed):
    Follow the instructions on the [Zig website](https://ziglang.org/download/) to install.

## How to Run

To run the server, use the command:

```sh
zig build run
```

The server will start and listen on port 2202.

## Project Structure

- `src/main.zig`: Main file that initializes and runs the TCP server.
- `src/server.zig`: Implementation of the TCP server.
- `src/parser.zig`: Main module that imports various parsing functions.
- `src/teltonika/imei_handler.zig`: Handles and parses the IMEI.
- `src/teltonika/validate_checksum.zig`: Validates the checksum of received packets.
- `src/teltonika/parser/`: Directory containing specific parsing functions:
  - `preamble.zig`: Parses the preamble.
  - `data_field.zig`: Parses the data size.
  - `codec.zig`: Parses the Codec ID.
  - `number_data.zig`: Parses the number of data sets.
  - `crc16.zig`: Parses and verifies the CRC16.
  - `avl/`: Directory with functions related to AVL:
    - `timestamp.zig`: Parses the timestamp.
    - `priority.zig`: Parses the priority.
    - `gps_element.zig`: Parses GPS elements.
    - `io_elements/`: Directory for IO Elements parsing:
      - `io_element.zig`: Parses input/output elements.
      - `mapping_io.zig`: Maps event IDs to properties.

## Usage

Once the server is running, it will accept connections from Teltonika devices and process the received data. The parsed data will be displayed in the console for debugging purposes.

## Feature Details

### IMEI Parsing

The `imei_handler` parses the IMEI of Teltonika devices, identifying the source of the data.

### Preamble

The `parsePreamble` synchronizes the received data.

### Data Size

The `parseDataField` determines the size of the subsequent data.

### Codec ID

The `parseCodecId` identifies the type of encoded data.

### Number of Data

The `parseNumberData` counts the data sets present.

### CRC16

The `parseCrc16` verifies the integrity of the data.

### Timestamp

The `parseTimestamp` extracts the moment when the data was generated.

### Priority

The `parsePriority` determines the importance of the data.

### GPS Element

The `parseGpsElement` parses location information such as latitude, longitude, altitude, speed, and angle.

### IO Elements

The `parseIoElements` processes input/output elements based on predefined mappings in `mapping_io.zig`.

## Contribution

Contributions are welcome! Feel free to open issues and pull requests.

## License

This project is licensed under the MIT License.