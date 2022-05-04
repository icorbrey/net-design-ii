# Final Exam

## Devices

| Device   | Domain Name | Password | Rapid PVST | Message of the Day                          |
|----------|-------------|----------|------------|---------------------------------------------|
| ISP      |             |          |            |                                             |
| R1       |             |          |            |                                             |
| R2       |             |          |            |                                             |
| R3       |             |          |            |                                             |
| R4       |             |          |            |                                             |
| S1       |             | Cisco    |            | Unauthorized access is strictly prohibited. |
| S2       |             | Cisco    |            | Unauthorized access is strictly prohibited. |
| S3       |             | Cisco    |            | Unauthorized access is strictly prohibited. |
| S4       |             | Cisco    |            | Unauthorized access is strictly prohibited. |
| PC A     |             |          |            |                                             |
| PC B     |             |          |            |                                             |
| PC C     |             |          |            |                                             |
| PC D     |             |          |            |                                             |
| Laptop 1 |             |          |            |                                             |

## VLANs

| Number | Name        | Network        |
|--------|-------------|----------------|
| 10     | Engineering | 192.168.1.0/24 |
| 20     | Finance     | 192.168.2.0/24 |
| 30     | Marketing   | 192.168.3.0/24 |
| 40     | Management  | 192.168.4.0/24 |

## Connections

| Source | Destination | Network        |
|--------|-------------|----------------|
| R1     | R4          | 10.10.10.0/30  |
| R2     | R4          | 10.10.10.4/30  |
| R2     | ISP         | 10.10.10.8/30  |
| R4     | ISP         | 10.10.10.12/30 |
| R4     | R3          | 10.10.10.16/30 |
| R3     | PC D        | 172.16.21.0/24 |

## Lines

| Device | Line      | Login | Password | Transport Input | Transport Output |
|--------|-----------|-------|----------|-----------------|------------------|
| S1     | console 0 |       | Class    |                 |                  |
| S2     | console 0 |       | Class    |                 |                  |
| S3     | console 0 |       | Class    |                 |                  |
| S4     | console 0 |       | Class    |                 |                  |
| S1     | vty 0 15  | local | Remote   | ssh             |                  |
| S2     | vty 0 15  | local | Remote   | ssh             |                  |
| S3     | vty 0 15  | local | Remote   | ssh             |                  |
| S4     | vty 0 15  | local | Remote   | telnet          |                  |

## Interfaces

| Device   | Interface | Mode   | VLAN(s)        | Default Gateway (IPv4) | Default Gateway (IPv6) | EtherChannel Mode  | EtherChannel Group | PortFast | BPDU Guard | Port Security | Max Devices | 
|----------|-----------|--------|----------------|------------------------|------------------------|--------------------|--------------------|----------|------------|
| R1       | g0/0/0    | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |          |            |
| R1       | g0/0/0.10 |        |                | 192.168.1.0/24         |                        |                    |                    |          |            |
| R1       | g0/0/0.20 |        |                | 192.168.2.0/24         |                        |                    |                    |          |            |
| R1       | g0/0/0.30 |        |                | 192.168.3.0/24         |                        |                    |                    |          |            |
| R1       | g0/0/0.40 |        |                | 192.168.4.0/24         |                        |                    |                    |          |            |
| R1       | g0/0/1    | trunk  | 10, 20, 30, 40 | 10.10.10.0/30          |                        |                    |                    |          |            |
| R2       | g0/0/0    | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |          |            |
| R2       | g0/0/0.10 |        |                | 192.168.1.0/24         |                        |                    |                    |          |            |
| R2       | g0/0/0.20 |        |                | 192.168.2.0/24         |                        |                    |                    |          |            |
| R2       | g0/0/0.30 |        |                | 192.168.3.0/24         |                        |                    |                    |          |            |
| R2       | g0/0/0.40 |        |                | 192.168.4.0/24         |                        |                    |                    |          |            |
| R2       | g0/0/1    | trunk  | 10, 20, 30, 40 | 10.10.10.4/30          |                        |                    |                    |          |            |
| R2       | s0/2/0    |        |                | 10.10.10.8/30          |                        |                    |                    |          |            |
| R3       | g0/0/0    | trunk  | 10, 20, 30, 40 | 172.16.21.0/24         | 2001:db8:acad:1::/64   |                    |                    |          |            |
| R3       | g0/0/1    | trunk  | 10, 20, 30, 40 | 10.10.10.16/30         | 2001:db8:acad:2::/64   |                    |                    |          |            |
| R4       | g0/0/0    | trunk  | 10, 20, 30, 40 | 10.10.10.0/30          |                        |                    |                    |          |            |
| R4       | g0/0/1    | trunk  | 10, 20, 30, 40 | 10.10.10.16/30         |                        |                    |                    |          |            |
| R4       | s0/2/0    |        |                | 10.10.10.4/30          |                        |                    |                    |          |            |
| R4       | s0/2/1    |        |                | 10.10.10.12/30         |                        |                    |                    |          |            |
| S1       | VLAN 40   |        |                | 192.168.4.0/24         |                        |                    |                    |          |            |
| S1       | f0/1      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 1                  |          |            |
| S1       | f0/2      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 1                  |          |            |
| S1       | f0/3      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 2                  |          |            |
| S1       | f0/4      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 2                  |          |            |
| S1       | f0/5      | access |                |                        |                        |                    |                    | Enabled  | Enabled    |
| S1       | f0/24     | access | 10             |                        |                        |                    |                    | Enabled  | Enabled    |
| S2       | VLAN 40   |        |                | 192.168.4.0/24         |                        |                    |                    |          |            |
| S2       | g0/1      | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |          |            |
| S2       | f0/3      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 2                  |          |            |
| S2       | f0/4      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 2                  |          |            |
| S2       | f0/5      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 3                  |          |            |
| S2       | f0/6      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 3                  |          |            |
| S2       | f0/22     | access | 30             |                        |                        |                    |                    | Enabled  | Enabled    |
| S2       | f0/23     | access | 20             |                        |                        |                    |                    | Enabled  | Enabled    |
| S3       | VLAN 40   |        |                | 192.168.4.0/24         |                        |                    |                    |          |            |
| S3       | g0/1      | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |          |            |
| S3       | f0/1      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 1                  |          |            |
| S3       | f0/2      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 1                  |          |            |
| S3       | f0/5      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 3                  |          |            |
| S3       | f0/6      | trunk  | 10, 20, 30, 40 |                        |                        | PAgP               | 3                  |          |            |
| S4       | VLAN 1    |        |                | 172.16.21.0/24         |                        |                    |                    |          |            |
| S4       | g0/1      | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |          |            |
| S4       | f0/11     | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |          |            |
| ISP      | s0/2/0    |        |                | 10.10.10.12/30         |                        |                    |                    |          |            |
| ISP      | s0/2/1    |        |                | 10.10.10.8/30          |                        |                    |                    |          |            |
| ISP      | loop0     |        |                | 193.45.28.0/30         |                        |                    |                    |          |            |
| PC A     | NIC       |        |                | 192.168.1.0/24         |                        |                    |                    |          |            |
| PC B     | NIC       |        |                | 192.168.2.0/24         |                        |                    |                    |          |            |
| PC C     | NIC       |        |                | 192.168.3.0/24         |                        |                    |                    |          |            |
| PC D     | NIC       |        |                | 172.16.21.0/24         | 2001:db8:acad:1::/64   |                    |                    |          |            |
| Laptop 1 | NIC       |        |                | 192.168.1.0/24         |                        |                    |                    |          |            |

## Routes

| Device | IP Mask | Subnet Mask | Destination | Administrative Distance |
|--------|---------|-------------|-------------|-------------------------|
