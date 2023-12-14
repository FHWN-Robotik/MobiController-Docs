## Befehle (Commands)

### Imu

| Attribut | Wert |
| -------- | ---- |
| min_id | 32 |
| name | imu |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | select sensor |
| c_type | uint8_t |
| bits | [accelerometer, magnetometer, gyroscope, euler, linear_accel, gravity, quaternion] |

| name | interval |
| unit | ms |
| c_type | uint16_t |

### Ultrasonic sensor

| Attribut | Wert |
| -------- | ---- |
| min_id | 33 |
| name | ultrasonic sensor |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | select sensor |
| c_type | uint8_t |
| bits | [us-1, us-2, us-3, us-4, us-5, us-6] |

| name | interval |
| unit | ms |
| c_type | uint16_t |

### Encoder

| Attribut | Wert |
| -------- | ---- |
| min_id | 34 |
| name | encoder |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | select sensor |
| c_type | uint8_t |
| bits | [encoder-1, encoder-2, encoder-3, encoder-4] |

| name | interval |
| unit | ms |
| c_type | uint16_t |

### Brightness

| Attribut | Wert |
| -------- | ---- |
| min_id | 35 |
| name | brightness |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | interval |
| unit | ms |
| c_type | uint16_t |

### Temperature

| Attribut | Wert |
| -------- | ---- |
| min_id | 36 |
| name | temperature |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | interval |
| unit | ms |
| c_type | uint16_t |

### Bat voltage

| Attribut | Wert |
| -------- | ---- |
| min_id | 37 |
| name | bat voltage |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | interval |
| unit | ms |
| c_type | uint16_t |

### User button

| Attribut | Wert |
| -------- | ---- |
| min_id | 38 |
| name | user button |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | user button mode |
| c_type | uint8_t |
| codes | [INTERNAL, EXTERNAL] |

### Led strip

| Attribut | Wert |
| -------- | ---- |
| min_id | 39 |
| name | led strip |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | animation preset |
| c_type | uint8_t |
| codes | [DRIVING_LIGHTS, BEACON, BLINK, ON] |

| name | color r |
| c_type | uint8_t |

| name | color g |
| c_type | uint8_t |

| name | color b |
| c_type | uint8_t |

| name | color w |
| c_type | uint8_t |

| name | update_rate |
| c_type | uint8_t |
| unit | 10ms * update_rate |

| name | line_length |
| c_type | uint8_t |

| name | line_count |
| c_type | uint8_t |

| name | rotate_left |
| c_type | uint8_t |

| name | frame_count |
| c_type | uint8_t |

### Motor control

| Attribut | Wert |
| -------- | ---- |
| min_id | 40 |
| name | motor control |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | x speed |
| unit | mm/s |
| c_type | int16_t |

| name | y speed |
| unit | mm/s |
| c_type | int16_t |

| name | phi speed |
| unit | mrad/s |
| c_type | int16_t |

### Pozyx power

| Attribut | Wert |
| -------- | ---- |
| min_id | 41 |
| name | pozyx power |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | pozyx power control |
| c_type | uint8_t |

### Pozyx

| Attribut | Wert |
| -------- | ---- |
| min_id | 42 |
| name | pozyx |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | select sensor |
| c_type | uint8_t |
| bits | [position, euler, quaternion] |

| name | interval |
| unit | ms |
| c_type | uint16_t |

### Pozyx config

| Attribut | Wert |
| -------- | ---- |
| min_id | 43 |
| name | pozyx config |
| payload | empty |

### Imu calibration status

| Attribut | Wert |
| -------- | ---- |
| min_id | 44 |
| name | imu calibration status |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | interval |
| unit | ms |
| c_type | uint16_t |

### Imu get calibration data

| Attribut | Wert |
| -------- | ---- |
| min_id | 45 |
| name | imu get calibration data |
| payload | empty |

### Imu set calibration data

| Attribut | Wert |
| -------- | ---- |
| min_id | 46 |
| name | imu set calibration data |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | offset gyroscope x |
| c_type | int16_t |

| name | offset gyroscope y |
| c_type | int16_t |

| name | offset gyroscope z |
| c_type | int16_t |

| name | offset magnetometer x |
| c_type | int16_t |

| name | offset magnetometer y |
| c_type | int16_t |

| name | offset magnetometer z |
| c_type | int16_t |

| name | offset accelerometer x |
| c_type | int16_t |

| name | offset accelerometer y |
| c_type | int16_t |

| name | offset accelerometer z |
| c_type | int16_t |

| name | radius magnetometer |
| c_type | uint16_t |

| name | radius accelerometer |
| c_type | uint16_t |

### Jump to bootloader

| Attribut | Wert |
| -------- | ---- |
| min_id | 60 |
| name | jump to bootloader |
| payload | empty |

### Disable all intervals

| Attribut | Wert |
| -------- | ---- |
| min_id | 61 |
| name | disable all intervals |
| payload | empty |

### Firmware info

| Attribut | Wert |
| -------- | ---- |
| min_id | 62 |
| name | Firmware Info |
| payload | empty |


## Antworten/Daten (Data)

### Command status

| Attribut | Wert |
| -------- | ---- |
| min_id | 0 |
| name | command status |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | status code |
| c_type | uint8_t |
| codes | [OK, ERROR, INVALID_PARAMETER, UNKOWN_COMMAND, BATTERY_WARNING] |

### Imu

| Attribut | Wert |
| -------- | ---- |
| min_id | 1 |
| name | imu |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | sensor bit |
| c_type | uint8_t |
| bits | [accelerometer, magnetometer, gyroscope, euler, linear_accel, gravity, quaternion] |

| name | w |
| c_type | double |

| name | x |
| c_type | double |

| name | y |
| c_type | double |

| name | z |
| c_type | double |

### Ultrasonic sensor

| Attribut | Wert |
| -------- | ---- |
| min_id | 2 |
| name | ultrasonic sensor |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | sensor bit |
| c_type | uint8_t |
| bits | [us-1, us-2, us-3, us-4, us-5, us-6] |

| name | distance |
| unit | cm |
| c_type | float |

### Encoder

| Attribut | Wert |
| -------- | ---- |
| min_id | 3 |
| name | encoder |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | sensor bit |
| c_type | uint8_t |
| bits | [encoder-1, encoder-2, encoder-3, encoder-4] |

| name | counter |
| c_type | uint16_t |

### Brightness

| Attribut | Wert |
| -------- | ---- |
| min_id | 4 |
| name | brightness |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | brightness |
| unit | lux |
| c_type | float |

### Temperature

| Attribut | Wert |
| -------- | ---- |
| min_id | 5 |
| name | temperature |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | temperature |
| unit | °C |
| c_type | int8_t |

### Bat voltage

| Attribut | Wert |
| -------- | ---- |
| min_id | 6 |
| name | bat voltage |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | voltage |
| unit | V |
| c_type | float |

### User button

| Attribut | Wert |
| -------- | ---- |
| min_id | 7 |
| name | user button |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | is pressed |
| c_type | bool |

### Pozyx

| Attribut | Wert |
| -------- | ---- |
| min_id | 8 |
| name | pozyx |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | sensor bit |
| c_type | uint8_t |
| bits | [position, euler, quaternion] |

| name | w |
| c_type | float |

| name | x |
| c_type | float |

| name | y |
| c_type | float |

| name | z |
| c_type | float |

### Pozyx info

| Attribut | Wert |
| -------- | ---- |
| min_id | 9 |
| name | pozyx info |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | network id |
| c_type | uint16_t |

| name | firmware version |
| c_type | uint8_t |

| name | harware version |
| c_type | uint8_t |

### Pozyx power state

| Attribut | Wert |
| -------- | ---- |
| min_id | 10 |
| name | pozyx power state |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | on/off |
| c_type | bool |

### Imu calibration status

| Attribut | Wert |
| -------- | ---- |
| min_id | 11 |
| name | imu calibration status |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | system |
| c_type | uint8_t |

| name | gyro |
| c_type | int8_t |

| name | mag |
| c_type | uint8_t |

| name | accel |
| c_type | uint8_t |

### Imu calibration data

| Attribut | Wert |
| -------- | ---- |
| min_id | 12 |
| name | imu calibration data |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | offset gyroscope x |
| c_type | int16_t |

| name | offset gyroscope y |
| c_type | int16_t |

| name | offset gyroscope z |
| c_type | int16_t |

| name | offset magnetometer x |
| c_type | int16_t |

| name | offset magnetometer y |
| c_type | int16_t |

| name | offset magnetometer z |
| c_type | int16_t |

| name | offset accelerometer x |
| c_type | int16_t |

| name | offset accelerometer y |
| c_type | int16_t |

| name | offset accelerometer z |
| c_type | int16_t |

| name | radius magnetometer |
| c_type | uint16_t |

| name | radius accelerometer |
| c_type | uint16_t |

### Firmware info

| Attribut | Wert |
| -------- | ---- |
| min_id | 63 |
| name | Firmware Info |

#### Payload
{: .no_toc }

| Attribut | Wert |
| -------- | ---- |
| name | info |
| c_type | string |
