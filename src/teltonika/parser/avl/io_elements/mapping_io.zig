pub fn getProperty(event_id: u16) ![]const u8 {
    return switch (event_id) {
        239 => "Ignition",
        240 => "Movement",
        80 => "Data Mode",
        21 => "GSM Signal",
        200 => "Sleep Mode",
        69 => "GNSS Status",
        181 => "GNSS PDOP",
        182 => "GNSS HDOP",
        66 => "External Voltage",
        24 => "Speed",
        205 => "GSM Cell ID",
        206 => "GSM Area Code",
        67 => "Battery Voltage",
        68 => "Battery Current",
        241 => "Active GSM Operator",
        199 => "Trip Odometer",
        16 => "Total Odometer",
        1 => "Digital Input 1",
        9 => "Analog Input 1",
        179 => "Digital Output 1",
        12 => "Fuel Used GPS",
        13 => "Fuel Rate GPS",
        17 => "Axis X",
        18 => "Axis Y",
        19 => "Axis Z",
        11 => "ICCID1",
        10 => "SD Status",
        2 => "Digital Input 2",
        3 => "Digital Input 3",
        6 => "Analog Input 2",
        180 => "Digital Output 2",
        72 => "Dallas Temperature 1",
        73 => "Dallas Temperature 2",
        74 => "Dallas Temperature 3",
        75 => "Dallas Temperature 4",
        76 => "Dallas Temperature ID 1",
        77 => "Dallas Temperature ID 2",
        79 => "Dallas Temperature ID 3",
        71 => "Dallas Temperature ID 4",
        78 => "iButton",
        207 => "RFID",
        201 => "LLS 1 Fuel Level",
        202 => "LLS 1 Temperature",
        203 => "LLS 2 Fuel Level",
        204 => "LLS 2 Temperature",
        210 => "LLS 3 Fuel Level",
        211 => "LLS 3 Temperature",
        212 => "LLS 4 Fuel Level",
        213 => "LLS 4 Temperature",
        214 => "LLS 5 Fuel Level",
        215 => "LLS 5 Temperature",
        15 => "Eco Score",
        113 => "Battery Level",
        238 => "User ID",
        237 => "Network Type",
        4 => "Pulse Counter Din1",
        5 => "Pulse Counter Din2",
        263 => "BT Status",
        264 => "Barcode ID",
        303 => "Instant Movement",
        327 => "UL202-02 Sensor Fuel level",
        483 => "UL202-02 Sensor Status",
        380 => "Digital output 3",
        381 => "Ground Sense",
        387 => "ISO6709 Coordinates",
        636 => "UMTS/LTE Cell ID",
        403 => "Driver Name",
        404 => "Driver card license type",
        405 => "Driver Gender",
        406 => "Driver Card ID",
        407 => "Driver card expiration date",
        408 => "Driver Card place of issue",
        409 => "Driver Status Event",
        329 => "AIN Speed",
        500 => "MSP500 vendor name",
        501 => "MSP500 vehicle number",
        502 => "MSP500 speed sensor",
        637 => "Wake Reason",
        10800 => "EYE Temperature 1",
        10801 => "EYE Temperature 2",
        10802 => "EYE Temperature 3",
        10803 => "EYE Temperature 4",
        10804 => "EYE Humidity 1",
        10805 => "EYE Humidity 2",
        10806 => "EYE Humidity 3",
        10807 => "EYE Humidity 4",
        10808 => "EYE Magnet 1",
        10809 => "EYE Magnet 2",
        10810 => "EYE Magnet 3",
        10811 => "EYE Magnet 4",
        10812 => "EYE Movement 1",
        10813 => "EYE Movement 2",
        10814 => "EYE Movement 3",
        10815 => "EYE Movement 4",
        10816 => "EYE Pitch 1",
        10817 => "EYE Pitch 2",
        10818 => "EYE Pitch 3",
        10819 => "EYE Pitch 4",
        10820 => "EYE Low Battery 1",
        10821 => "EYE Low Battery 2",
        10822 => "EYE Low Battery 3",
        10823 => "EYE Low Battery 4",
        10824 => "EYE Battery Voltage 1",
        10825 => "EYE Battery Voltage 2",
        10826 => "EYE Battery Voltage 3",
        10827 => "EYE Battery Voltage 4",
        10832 => "EYE Roll 1",
        10833 => "EYE Roll 2",
        10834 => "EYE Roll 3",
        10835 => "EYE Roll 4",
        10836 => "EYE Movement count 1",
        10837 => "EYE Movement count 2",
        10838 => "EYE Movement count 3",
        10839 => "EYE Movement count 4",
        10840 => "EYE Magnet count 1",
        10841 => "EYE Magnet count 2",
        10842 => "EYE Magnet count 3",
        10843 => "EYE Magnet count 4",
        383 => "AXL Calibration Status",
        451 => "BLE RFID #1",
        452 => "BLE RFID #2",
        453 => "BLE RFID #3",
        454 => "BLE RFID #4",
        455 => "BLE Button 1 state #1",
        456 => "BLE Button 1 state #2",
        457 => "BLE Button 1 state #3",
        458 => "BLE Button 1 state #4",
        459 => "BLE Button 2 state #1",
        460 => "BLE Button 2 state #2",
        461 => "BLE Button 2 state #3",
        462 => "BLE Button 2 state #4",
        622 => "Frequency DIN1",
        623 => "Frequency DIN2",
        155 => "Geofence zone 01",
        156 => "Geofence zone 02",
        157 => "Geofence zone 03",
        158 => "Geofence zone 04",
        159 => "Geofence zone 05",
        61 => "Geofence zone 06",
        62 => "Geofence zone 07",
        63 => "Geofence zone 08",
        64 => "Geofence zone 09",
        65 => "Geofence zone 10",
        70 => "Geofence zone 11",
        88 => "Geofence zone 12",
        91 => "Geofence zone 13",
        92 => "Geofence zone 14",
        93 => "Geofence zone 15",
        94 => "Geofence zone 16",
        95 => "Geofence zone 17",
        96 => "Geofence zone 18",
        97 => "Geofence zone 19",
        98 => "Geofence zone 20",
        99 => "Geofence zone 21",
        153 => "Geofence zone 22",
        154 => "Geofence zone 23",
        190 => "Geofence zone 24",
        191 => "Geofence zone 25",
        192 => "Geofence zone 26",
        193 => "Geofence zone 27",
        194 => "Geofence zone 28",
        195 => "Geofence zone 29",
        196 => "Geofence zone 30",
        197 => "Geofence zone 31",
        198 => "Geofence zone 32",
        208 => "Geofence zone 33",
        209 => "Geofence zone 34",
        216 => "Geofence zone 35",
        217 => "Geofence zone 36",
        218 => "Geofence zone 37",
        219 => "Geofence zone 38",
        220 => "Geofence zone 39",
        221 => "Geofence zone 40",
        222 => "Geofence zone 41",
        223 => "Geofence zone 42",
        224 => "Geofence zone 43",
        225 => "Geofence zone 44",
        226 => "Geofence zone 45",
        227 => "Geofence zone 46",
        228 => "Geofence zone 47",
        229 => "Geofence zone 48",
        230 => "Geofence zone 49",
        231 => "Geofence zone 50",
        175 => "Auto Geofence",
        250 => "Trip",
        255 => "Over Speeding",
        257 => "Crash trace data",
        285 => "Blood alcohol content",
        251 => "Idling",
        253 => "Green driving type",
        246 => "Towing",
        252 => "Unplug",
        247 => "Crash detection",
        248 => "Immobilizer",
        254 => "Green Driving Value",
        249 => "Jamming",
        14 => "ICCID2",
        243 => "Green driving event duration",
        236 => "Alarm",
        258 => "EcoMaximum",
        259 => "EcoAverage",
        260 => "EcoDuration",
        283 => "Driving State",
        284 => "Driving Records",
        317 => "Crash event counter",
        318 => "GNSS Jamming",
        391 => "Private mode",
        449 => "Ignition On Counter",
        1412 => "Motorcycle Fall Detection",
        256 => "VIN",
        30 => "Number of DTC",
        31 => "Engine Load",
        32 => "Coolant Temperature",
        33 => "Short Fuel Trim",
        34 => "Fuel pressure",
        35 => "Intake MAP",
        36 => "Engine RPM",
        37 => "Vehicle Speed",
        38 => "Timing Advance",
        39 => "Intake Air Temperature",
        40 => "MAF",
        41 => "Throttle Position",
        42 => "Runtime since engine start",
        43 => "Distance Traveled MIL On",
        44 => "Relative Fuel Rail Pressure",
        45 => "Direct Fuel Rail Pressure",
        46 => "Commanded EGR",
        47 => "EGR Error",
        48 => "Fuel Level",
        49 => "Distance Since Codes Clear",
        50 => "Barometic Pressure",
        51 => "Control Module Voltage",
        52 => "Absolute Load Value",
        759 => "Fuel Type",
        53 => "Ambient Air Temperature",
        54 => "Time Run With MIL On",
        55 => "Time Since Codes Cleared",
        56 => "Absolute Fuel Rail Pressure",
        57 => "Hybrid battery pack life",
        58 => "Engine Oil Temperature",
        59 => "Fuel injection timing",
        540 => "Throttle position group",
        541 => "Commanded Equivalence R",
        542 => "Intake MAP 2 bytes",
        543 => "Hybrid System Voltage",
        544 => "Hybrid System Current",
        281 => "Fault Codes",
        60 => "Fuel Rate",
        389 => "OBD OEM Total Mileage",
        390 => "OBD OEM Fuel Level",
        402 => "OEM Distance Until Service",
        410 => "OEM Battery charge state",
        411 => "OEM Battery charge level",
        755 => "OEM Remaining distance",
        1151 => "OEM Battery State Of Health",
        1152 => "OEM Battery Temperature",
        385 => "Beacon",
        548 => "Advanced BLE Beacon data",
        25 => "BLE Temperature #1",
        26 => "BLE Temperature #2",
        27 => "BLE Temperature #3",
        28 => "BLE Temperature #4",
        29 => "BLE Battery #1",
        20 => "BLE Battery #2",
        22 => "BLE Battery #3",
        23 => "BLE Battery #4",
        86 => "BLE Humidity #1",
        104 => "BLE Humidity #2",
        106 => "BLE Humidity #3",
        108 => "BLE Humidity #4",
        270 => "BLE Fuel Level #1",
        273 => "BLE Fuel Level #2",
        276 => "BLE Fuel Level #3",
        279 => "BLE Fuel Level #4",
        306 => "BLE Fuel Frequency #1",
        307 => "BLE Fuel Frequency #2",
        308 => "BLE Fuel Frequency #3",
        309 => "BLE Fuel Frequency #4",
        335 => "BLE Luminosity #1",
        336 => "BLE Luminosity #2",
        337 => "BLE Luminosity #3",
        338 => "BLE Luminosity #4",
        331 => "BLE 1 Custom #1",
        463 => "BLE 1 Custom #2",
        464 => "BLE 1 Custom #3",
        465 => "BLE 1 Custom #4",
        466 => "BLE 1 Custom #5",
        332 => "BLE 2 Custom #1",
        467 => "BLE 2 Custom #2",
        468 => "BLE 2 Custom #3",
        469 => "BLE 2 Custom #4",
        470 => "BLE 2 Custom #5",
        333 => "BLE 3 Custom #1",
        471 => "BLE 3 Custom #2",
        472 => "BLE 3 Custom #3",
        473 => "BLE 3 Custom #4",
        474 => "BLE 3 Custom #5",
        334 => "BLE 4 Custom #1",
        475 => "BLE 4 Custom #2",
        476 => "BLE 4 Custom #3",
        477 => "BLE 4 Custom #4",
        478 => "BLE 4 Custom #5",
        81 => "Vehicle Speed",
        82 => "Accelerator Pedal Position",
        83 => "Fuel Consumed",
        84 => "Fuel Level",
        85 => "Engine RPM",
        87 => "Total Mileage",
        89 => "Fuel level",
        90 => "Door Status",
        100 => "Program Number",
        101 => "Module ID 8B",
        388 => "Module ID 17B",
        102 => "Engine Worktime",
        103 => "Engine Worktime (counted)",
        105 => "Total Mileage (counted)",
        107 => "Fuel Consumed (counted)",
        110 => "Fuel Rate",
        111 => "AdBlue Level",
        112 => "AdBlue Level",
        114 => "Engine Load",
        115 => "Engine Temperature",
        118 => "Axle 1 Load",
        119 => "Axle 2 Load",
        120 => "Axle 3 Load",
        121 => "Axle 4 Load",
        122 => "Axle 5 Load",
        123 => "Control State Flags",
        124 => "Agricultural Machinery Flags",
        125 => "Harvesting Time",
        126 => "Area of Harvest",
        127 => "Mowing Efficiency",
        128 => "Grain Mown Volume",
        129 => "Grain Moisture",
        130 => "Harvesting Drum RPM",
        131 => "Gap Under Harvesting Drum",
        132 => "Security State Flags",
        133 => "Tachograph Total Vehicle Distance",
        134 => "Trip Distance",
        135 => "Tachograph Vehicle Speed",
        136 => "Tacho Driver Card Presence",
        137 => "Driver 1 States",
        138 => "Driver 2 States",
        139 => "Driver 1 Continuous Driving Time",
        140 => "Driver 2 Continuous Driving Time",
        141 => "Driver 1 Cumulative Break Time",
        142 => "Driver 2 Cumulative Break Time",
        143 => "Driver 1 Selected Activity Duration",
        144 => "Driver 2 Selected Activity Duration",
        145 => "Driver 1 Cumulative Driving Time",
        146 => "Driver 2 Cumulative Driving Time",
        147 => "Driver 1 ID High",
        148 => "Driver 1 ID Low",
        149 => "Driver 2 ID High",
        150 => "Driver 2 ID Low",
        151 => "Battery Temperature",
        152 => "HV Battery Level",
        160 => "DTC Faults",
        161 => "Slope of Arm",
        162 => "Rotation of Arm",
        163 => "Eject of Arm",
        164 => "Horizontal Distance Arm Vehicle",
        165 => "Height Arm Above Ground",
        166 => "Drill RPM",
        167 => "Amount Of Spread Salt Square Meter",
        168 => "Battery Voltage",
        169 => "Amount Of Spread Fine Grained Salt",
        170 => "Amount Of Coarse Grained Salt",
        171 => "Amount Of Spread DiMix",
        172 => "Amount Of Spread Coarse Grained Calcium",
        173 => "Amount Of Spread Calcium Chloride",
        174 => "Amount Of Spread Sodium Chloride",
        176 => "Amount Of Spread Magnesium Chloride",
        177 => "Amount Of Spread Gravel",
        178 => "Amount Of Spread Sand",
        183 => "Width Pouring Left",
        184 => "Width Pouring Right",
        185 => "Salt Spreader Working Hours",
        186 => "Distance During Salting",
        187 => "Load Weight",
        188 => "Retarder Load",
        189 => "Cruise Time",
        232 => "CNG Status",
        233 => "CNG Used",
        234 => "CNG Level",
        235 => "Oil Level",
        304 => "Vehicles Range On Battery",
        305 => "Vehicles Range On Additional Fuel",
        325 => "VIN",
        282 => "Fault Codes",
        517 => "Security State Flags P4",
        518 => "Control State Flags P4",
        519 => "Indicator State Flags P4",
        520 => "Agricultural State Flags P4",
        521 => "Utility State Flags P4",
        522 => "Cistern State Flags P4",
        855 => "LNG Used",
        856 => "LNG Used (counted)",
        857 => "LNG Level",
        858 => "LNG Level",
        1100 => "Total LPG Used",
        1101 => "Total LPG Used Counted",
        1102 => "LPG Level Proc",
        1103 => "LPG Level Liters",
        898 => "SSF Ignition",
        652 => "SSF KeyInIgnitionLock",
        899 => "SSF Webasto",
        900 => "SSF Engine Working",
        901 => "SSF Standalone Engine",
        902 => "SSF Ready To Drive",
        903 => "SSF Engine Working On CNG",
        904 => "SSF Work Mode",
        905 => "SSF Operator",
        906 => "SSF Interlock",
        907 => "SSF Engine Lock Active",
        908 => "SSF Request To Lock Engine",
        653 => "SSF Handbrake Is Active",
        910 => "SSF Footbrake Is Active",
        911 => "SSF Clutch Pushed",
        912 => "SSF Hazard Warning Lights",
        654 => "SSF Front Left Door Open",
        655 => "SSF Front Right Door Open",
        656 => "SSF Rear Left Door Open",
        657 => "SSF Rear Right Door Open",
        658 => "SSF Trunk Door Open",
        913 => "SSF Engine Cover Open",
        909 => "SSF Roof Open",
        914 => "SSF Charging Wire Plugged",
        915 => "SSF Batttery Charging",
        916 => "SSF Electric Engine State",
        917 => "SSF Car Closed Factory Remote",
        662 => "SSF Car Is Closed",
        918 => "SSF Factory Alarm Actuated",
        919 => "SSF Factory Alarm Emulated",
        920 => "SSF Signal Close Factory Remote",
        921 => "SSF Signal Open Factory Remote",
        922 => "SSF Rearming Signal",
        923 => "SSF Trunk Door Opened Factory Remote",
        924 => "SSF CAN Module In Sleep",
        925 => "SSF Factory Remote 3x",
        926 => "SSF Factory Armed",
        660 => "SSF Parking Gear Active (automatic gear box)",
        661 => "SSF Reverse Gear Active",
        659 => "SSF Neutral Gear Active (automatic gear box)",
        927 => "SSF Drive Is Active (automatic gear box)",
        1083 => "SSF Engine Working On Dual Fuel",
        1084 => "SSF Engine Working On LPG",
        928 => "CSF Parking Lights",
        929 => "CSF Dipped Head lights",
        930 => "CSF Full Beam Headlights",
        931 => "CSF Rear Fog Lights",
        932 => "CSF Front Fog Lights",
        933 => "CSF Additional Front Lights",
        934 => "CSF Additional Rear Lights",
        935 => "CSF Light Signal",
        936 => "CSF Air Conditioning",
        937 => "CSF Cruise Control",
        938 => "CSF Automatic Retarder",
        939 => "CSF Manual Retarder",
        940 => "CSF Driver's Seatbelt Fastened",
        941 => "CSF Front Driver's Seatbelt Fastened",
        942 => "CSF Left Driver's Seatbelt Fastened",
        943 => "CSF Right Driver's Seatbelt Fastened",
        944 => "CSF Centre Driver's Seatbelt Fastened",
        945 => "CSF Front Passenger Present",
        946 => "CSF PTO",
        947 => "CSF Front Differential Locked",
        948 => "CSF Rear Differential Locked",
        949 => "CSF Central Differential 4HI Locked",
        950 => "CSF Rear Differential 4LO Locked",
        951 => "CSF Trailer Axle 1 Lift Active",
        952 => "CSF Trailer Axle 2 Lift Active",
        1085 => "CSF Trailer Connected",
        1086 => "CSF Start Stop System Inactive",
        953 => "ISF Check Engine Indicator",
        954 => "ISF ABS Indicator",
        955 => "ISF ESP Indicator",
        956 => "ISF ESP Turned Off",
        957 => "ISF Stop Indicator",
        958 => "ISF Oil Level Indicator",
        959 => "ISF Coolant liquid level",
        960 => "ISF Battery Not Charging Indicator",
        961 => "ISF Handbrake System Indicator",
        962 => "ISF AIRBAG Indicator",
        963 => "ISF EPS Indicator",
        964 => "ISF Warning Indicator",
        965 => "ISF Lights Failure Indicator",
        966 => "ISF Low Tire Pressure Indicator",
        967 => "ISF Wear Of Brake Pads Indicator",
        968 => "ISF Low Fuel Level Indicator",
        969 => "ISF Maintenence required Indicator",
        970 => "ISF Glow Plug Indicator",
        971 => "ISF FAP Indicator",
        972 => "ISF EPC (Electronic Power Control) Indicator",
        973 => "ISF Clogged Engine Oil Filter Indicator",
        974 => "ISF Low Engine Oil Pressure Indicator",
        975 => "ISF Too High Engine Oil Temperature Indicator",
        976 => "ISF Low Coolant Level Indicator",
        977 => "ISF Clogged Hydraulic System Oil filter Indicator",
        978 => "ISF Hydraulic System Low Pressure Indicator",
        979 => "ISF Hydraulic Oil Low Level Indicator",
        980 => "ISF Hydraulic System High Temperature Indicator",
        981 => "ISF Oil Overflow In Hydraulic Chamber Indicator",
        982 => "ISF Clogged Air Filter Indicator",
        983 => "ISF Clogged Fuel Filter Indicator",
        984 => "ISF Water in Fuel Indicator",
        985 => "ISF Clogged Brake System Filter Indicator",
        986 => "ISF Low Washer Fluid Level Indicator",
        987 => "ISF Low AdBlue Level Indicator",
        988 => "ISF Low Trailer Tyre Pressure Indicator",
        989 => "ISF Wear Of Trailer Brake Lining Indicator",
        990 => "ISF High Trailer Brake Temperature Indicator",
        991 => "ISF Incorrect Trailer Pneumatic Supply Indicator",
        992 => "ISF Low CNG Level Indicator",
        993 => "ASF Right Joystick Moved Right Active",
        994 => "ASF Right Joystick Moved Left Active",
        995 => "ASF Right Joystick Moved Forward Active",
        996 => "ASF Right Joystick Moved Back Active",
        997 => "ASF Left Joystick Moved Right Active",
        998 => "ASF Left Joystick Moved Left Active",
        999 => "ASF Left Joystick Moved Forward Active",
        1000 => "ASF Left Joystick Moved Back Active",
        1001 => "ASF First Rear hydraulic",
        1002 => "ASF Second Rear hydraulic",
        1003 => "ASF Third Rear hydraulic",
        1004 => "ASF Fourth Rear hydraulic",
        1005 => "ASF First Front hydraulic",
        1006 => "ASF Second Front hydraulic",
        1007 => "ASF Third Front hydraulic",
        1008 => "ASF Fourth Front hydraulic",
        1009 => "ASF Front Three-point Hitch",
        1010 => "ASF Rear Three-point Hitch",
        1011 => "ASF Front Power Take-off",
        1012 => "ASF Rear Power Take-off",
        1013 => "ASF Mowing Active",
        1014 => "ASF Threshing Active",
        1015 => "ASF Grain Release From Hopper",
        1016 => "ASF Grain Tank Is 100% Full",
        1017 => "ASF Grain Tank Is 70% Full",
        1018 => "ASF Grain Tank Is Opened",
        1019 => "ASF Unloader Drive",
        1020 => "ASF Cleaning Fan Control Turned Off",
        1021 => "ASF Threshing Drum Control Turned Off",
        1022 => "ASF Straw Walker Is Clogged",
        1023 => "ASF Excessive Clearance Under The Threshing Drum",
        1024 => "ASF Low Temperature Of Drive System Hydraulics Less Than 5 Grades",
        1025 => "ASF High Temperature Of Drive System Hydraulics Greater Than 86 Grades",
        1026 => "ASF Ear Auger Speed Below The Norm",
        1027 => "ASF Grain Auger Speed Below The Norm",
        1028 => "ASF Straw Chooper Speed Below The Norm",
        1029 => "ASF Straw Shaker Speed Below The Norm",
        1030 => "ASF Feeder Speed Below The Norm",
        1031 => "ASF Straw Chopper Switched On",
        1032 => "ASF Corn Header Connected",
        1033 => "ASF Grain Header Connected",
        1034 => "ASF Feeder Reverse Switched On",
        1035 => "ASF The Pressure Filter Of The Hydraulic Pump Is Clogged",
        1087 => "ASF Adapter Pressure Filter Sensor",
        1088 => "ASF Service 2 Required Indicator",
        1089 => "ASF Drain Filter Clogged Indicator",
        1090 => "ASF Section 1 Spraying",
        1091 => "ASF Section 2 Spraying",
        1092 => "ASF Section 3 Spraying",
        1093 => "ASF Section 4 Spraying",
        1094 => "ASF Section 5 Spraying",
        1095 => "ASF Section 6 Spraying",
        1096 => "ASF Section 7 Spraying",
        1097 => "ASF Section 8 Spraying",
        1098 => "ASF Section 9 Spraying",
        1036 => "USF Spreading",
        1037 => "USF Pouring Chemicals",
        1038 => "USF Conveyor Belt",
        1039 => "USF Salt Spreader's Drive Wheel",
        1040 => "USF Brushes",
        1041 => "USF Vacuum Cleaner",
        1042 => "USF Water Supply",
        1043 => "USF Spreading",
        1044 => "USF Liquid pump",
        1045 => "USF Unloading From The Hopper",
        1046 => "USF Low Salt (Sand) Level In Container Indicator",
        1047 => "USF Low Water Level in Container Indicator",
        1048 => "USF Chemicals",
        1049 => "USF Compressor",
        1050 => "USF Water Valve Is Opened",
        1051 => "USF Cabin Moved Up Status Active",
        1052 => "USF Cabin Moved Down Status Active",
        1099 => "USF Hydraulics Work Not Permitted",
        1053 => "CiSF Section 1 Presence Of Fluid In The Downpipe",
        1054 => "CiSF Section 1 Filled",
        1055 => "CiSF Section 1 Overfilled",
        1056 => "CiSF Section 2 Presence Of Fluid In The Downpipe",
        1057 => "CiSF Section 2 Filled",
        1058 => "CiSF Section 2 Overfilled",
        1059 => "CiSF Section 3 Presence Of Fluid In The Downpipe",
        1060 => "CiSF Section 3 Filled",
        1061 => "CiSF Section 3 Overfilled",
        1062 => "CiSF Section 4 Presence Of Fluid In The Downpipe",
        1063 => "CiSF Section 4 Filled",
        1064 => "CiSF Section 4 Overfilled",
        1065 => "CiSF Section 5 Presence Of Fluid In The Downpipe",
        1066 => "CiSF Section 5 Filled",
        1067 => "CiSF Section 5 Overfilled",
        1068 => "CiSF Section 6 Presence Of Fluid In The Downpipe",
        1069 => "CiSF Section 6 Filled",
        1070 => "CiSF Section 6 Overfilled",
        1071 => "CiSF Section 7 Presence Of Fluid In The Downpipe",
        1072 => "CiSF Section 7 Filled",
        1073 => "CiSF Section 7 Overfilled",
        1074 => "CiSF Section 8 Presence Of Fluid In The Downpipe",
        1075 => "CiSF Section 8 Filled",
        1076 => "CiSF Section 8 Overfilled",
        400 => "Distance to Next Service",
        450 => "CNG Level Kg",
        859 => "Distance from need of service",
        860 => "Distance from last service",
        861 => "Time to next service",
        862 => "Time from need of service",
        863 => "Time from last serivce",
        864 => "Distance to next oil service",
        865 => "Time to next oil service",
        866 => "LVCAN Vehicle Range",
        867 => "LVCAN Total CNG counted",
        1079 => "Total Bale Count",
        1080 => "Bale Count",
        1081 => "Cut Bale Count",
        1082 => "Bale Slices",
        1116 => "LVCAN MaxRoadSpeed",
        1117 => "LVCAN ExceededRoadSpeed",
        1205 => "LVCAN RSF SpeedLimitSign",
        1206 => "LVCAN RSF EndOfSpeedLimitSign",
        1207 => "LVCAN RSF SpeedExceeded",
        1208 => "LVCAN RSF TimeSpeedLimitSign",
        1209 => "LVCAN RSF WthrSpeedLimitSign",
        else => "UnknownProperty",
    };
}
