# Final Exam

## Devices

| X | Device   | Domain Name | DNS Lookup | Password | Password Encryption | Rapid PVST | Root Bridge | Message of the Day                          |
|---|----------|-------------|------------|----------|---------------------|------------|-------------|---------------------------------------------|
|   | ISP      |             |            |          |                     |            |             |                                             |
| X | R1       | ccnalab.com | Disabled   | Cisco    | Enabled             |            |             | Unauthorized access is strictly prohibited. |
| X | R2       | ccnalab.com | Disabled   | Cisco    | Enabled             |            |             | Unauthorized access is strictly prohibited. |
| X | R3       | ccnalab.com | Disabled   | Cisco    | Enabled             |            |             | Unauthorized access is strictly prohibited. |
| X | R4       | ccnalab.com | Disabled   | Cisco    | Enabled             |            |             | Unauthorized access is strictly prohibited. |
| X | S1       |             | Disabled   | Cisco    | Enabled             | Enabled    |             | Unauthorized access is strictly prohibited. |
| X | S2       |             | Disabled   | Cisco    | Enabled             | Enabled    |             | Unauthorized access is strictly prohibited. |
| X | S3       |             | Disabled   | Cisco    | Enabled             | Enabled    |             | Unauthorized access is strictly prohibited. |
| X | S4       |             | Disabled   | Cisco    | Enabled             |            |             | Unauthorized access is strictly prohibited. |
|   | PC A     |             |            |          |                     |            |             |                                             |
|   | PC B     |             |            |          |                     |            |             |                                             |
|   | PC C     |             |            |          |                     |            |             |                                             |
|   | PC D     |             |            |          |                     |            |             |                                             |
|   | Laptop 1 |             |            |          |                     |            |             |                                             |

## VLANs

| X | Number | Name        | Network        |
|---|--------|-------------|----------------|
| X | 10     | Engineering | 192.168.1.0/24 |
| X | 20     | Finance     | 192.168.2.0/24 |
| X | 30     | Marketing   | 192.168.3.0/24 |
| X | 40     | Management  | 192.168.4.0/24 |

## Connections

| X | Source | Destination | Network        |
|---|--------|-------------|----------------|
| X | R1     | R4          | 10.10.10.0/30  |
| X | R2     | R4          | 10.10.10.4/30  |
| X | R2     | ISP         | 10.10.10.8/30  |
| X | R4     | ISP         | 10.10.10.12/30 |
| X | R4     | R3          | 10.10.10.16/30 |
| X | R3     | PC D        | 172.16.21.0/24 |

## Lines

| X | Device | Line      | Login | Password | Transport Input | Transport Output |
|---|--------|-----------|-------|----------|-----------------|------------------|
| X | R1     | console 0 |       | Class    |                 |                  |
| X | R2     | console 0 |       | Class    |                 |                  |
| X | R3     | console 0 |       | Class    |                 |                  |
| X | R4     | console 0 |       | Class    |                 |                  |
| X | S1     | console 0 |       | Class    |                 |                  |
| X | S2     | console 0 |       | Class    |                 |                  |
| X | S3     | console 0 |       | Class    |                 |                  |
| X | S4     | console 0 |       | Class    |                 |                  |
| X | R1     | vty 0 15  | local | Remote   | ssh             |                  |
| X | R2     | vty 0 15  | local | Remote   | ssh             |                  |
| X | R3     | vty 0 15  | local | Remote   | ssh             |                  |
| X | R4     | vty 0 15  | local | Remote   | ssh             |                  |
| X | S1     | vty 0 15  | local | Remote   | ssh             |                  |
| X | S2     | vty 0 15  | local | Remote   | ssh             |                  |
| X | S3     | vty 0 15  | local | Remote   | ssh             |                  |
| X | S4     | vty 0 15  | local | Remote   | telnet          |                  |

## Interfaces

| X | Device   | Interface | State    | Mode   | VLAN(s)        | Default Gateway (IPv4) | Default Gateway (IPv6) | Encapsulation VLAN | EtherChannel Mode  | EtherChannel Group | PortFast | BPDU Guard | Port Security | Max Devices | 
|---|----------|-----------|----------|--------|----------------|------------------------|------------------------|--------------------|--------------------|--------------------|----------|------------|---------------|-------------|
| X | R1       | g0/0/0    | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |                    |          |            |               |             |
| X | R1       | g0/0/0.10 | Enabled  |        |                | 192.168.1.0/24         |                        | 10                 |                    |                    |          |            |               |             |
| X | R1       | g0/0/0.20 | Enabled  |        |                | 192.168.2.0/24         |                        | 20                 |                    |                    |          |            |               |             |
| X | R1       | g0/0/0.30 | Enabled  |        |                | 192.168.3.0/24         |                        | 30                 |                    |                    |          |            |               |             |
| X | R1       | g0/0/0.40 | Enabled  |        |                | 192.168.4.0/24         |                        | 40                 |                    |                    |          |            |               |             |
| X | R1       | g0/0/1    | Enabled  | trunk  | 10, 20, 30, 40 | 10.10.10.0/30          |                        |                    |                    |                    |          |            |               |             |
| X | R2       | g0/0/0    | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |                    |          |            |               |             |
| X | R2       | g0/0/0.10 | Enabled  |        |                | 192.168.1.0/24         |                        | 10                 |                    |                    |          |            |               |             |
| X | R2       | g0/0/0.20 | Enabled  |        |                | 192.168.2.0/24         |                        | 20                 |                    |                    |          |            |               |             |
| X | R2       | g0/0/0.30 | Enabled  |        |                | 192.168.3.0/24         |                        | 30                 |                    |                    |          |            |               |             |
| X | R2       | g0/0/0.40 | Enabled  |        |                | 192.168.4.0/24         |                        | 40                 |                    |                    |          |            |               |             |
| X | R2       | g0/0/1    | Enabled  | trunk  | 10, 20, 30, 40 | 10.10.10.4/30          |                        |                    |                    |                    |          |            |               |             |
| X | R2       | s0/1/0    | Enabled  |        |                | 10.10.10.8/30          |                        |                    |                    |                    |          |            |               |             |
| X | R3       | g0/0/0    | Enabled  | trunk  | 10, 20, 30, 40 | 172.16.21.0/24         | 2001:db8:acad:1::/64   |                    |                    |                    |          |            |               |             |
| X | R3       | g0/0/1    | Enabled  | trunk  | 10, 20, 30, 40 | 10.10.10.16/30         | 2001:db8:acad:2::/64   |                    |                    |                    |          |            |               |             |
| X | R4       | g0/0/0    | Enabled  | trunk  | 10, 20, 30, 40 | 10.10.10.0/30          |                        |                    |                    |                    |          |            |               |             |
| X | R4       | g0/0/1    | Enabled  | trunk  | 10, 20, 30, 40 | 10.10.10.16/30         |                        |                    |                    |                    |          |            |               |             |
| X | R4       | s0/1/0    | Enabled  |        |                | 10.10.10.4/30          |                        |                    |                    |                    |          |            |               |             |
| X | R4       | s0/1/1    | Enabled  |        |                | 10.10.10.12/30         |                        |                    |                    |                    |          |            |               |             |
| X | S1       | VLAN 40   | Enabled  |        |                | 192.168.4.0/24         |                        |                    |                    |                    |          |            |               |             |
| X | S1       | f0/1      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 1                  |          |            |               |             |
| X | S1       | f0/2      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 1                  |          |            |               |             |
| X | S1       | f0/3      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 2                  |          |            |               |             |
| X | S1       | f0/4      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 2                  |          |            |               |             |
| X | S1       | f0/5      | Enabled  | access |                |                        |                        |                    |                    |                    | Enabled  | Enabled    |               |             |
| X | S1       | f0/6-23   | Disabled |        |                |                        |                        |                    |                    |                    |          |            |               |             |
| X | S1       | f0/24     | Enabled  | access | 10             |                        |                        |                    |                    |                    | Enabled  | Enabled    |               |             |
| X | S2       | VLAN 40   | Enabled  |        |                | 192.168.4.0/24         |                        |                    |                    |                    |          |            |               |             |
| X | S2       | g0/1      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |                    |          |            |               |             |
| X | S2       | f0/1-2    | Disabled |        |                |                        |                        |                    |                    |                    |          |            |               |             |
| X | S2       | f0/3      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 2                  |          |            |               |             |
| X | S2       | f0/4      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 2                  |          |            |               |             |
| X | S2       | f0/5      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 3                  |          |            |               |             |
| X | S2       | f0/6      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 3                  |          |            |               |             |
| X | S2       | f0/7-21   | Disabled |        |                |                        |                        |                    |                    |                    |          |            |               |             |
| X | S2       | f0/22     | Enabled  | access | 30             |                        |                        |                    |                    |                    | Enabled  | Enabled    |               |             |
| X | S2       | f0/23     | Enabled  | access | 20             |                        |                        |                    |                    |                    | Enabled  | Enabled    |               |             |
| X | S2       | f0/24     | Disabled |        |                |                        |                        |                    |                    |                    |          |            |               |             |
| X | S3       | VLAN 40   | Enabled  |        |                | 192.168.4.0/24         |                        |                    |                    |                    |          |            |               |             |
| X | S3       | g0/1      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |                    |          |            |               |             |
| X | S3       | f0/1      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 1                  |          |            |               |             |
| X | S3       | f0/2      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 1                  |          |            |               |             |
| X | S3       | f0/3-4    | Disabled |        |                |                        |                        |                    |                    |                    |          |            |               |             |
| X | S3       | f0/5      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 3                  |          |            |               |             |
| X | S3       | f0/6      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    | PAgP               | 3                  |          |            |               |             |
| X | S3       | f0/7-24   | Disabled |        |                |                        |                        |                    |                    |                    |          |            |               |             |
| X | S4       | VLAN 1    | Enabled  |        |                | 172.16.21.0/24         |                        |                    |                    |                    |          |            |               |             |
|   | S4       | g0/1      | Enabled  | trunk  | 10, 20, 30, 40 |                        |                        |                    |                    |                    |          |            |               |             |
|   | S4       | f0/1-10   | Disabled | access |                |                        |                        |                    |                    |                    |          |            |               |             |
|   | S4       | f0/11     | Enabled  | access |                |                        |                        |                    |                    |                    |          |            | Protect       | 1           |
|   | S4       | f0/12-24  | Disabled | access |                |                        |                        |                    |                    |                    |          |            |               |             |
| X | ISP      | s0/1/0    | Enabled  |        |                | 10.10.10.12/30         |                        |                    |                    |                    |          |            |               |             |
| X | ISP      | s0/1/1    | Enabled  |        |                | 10.10.10.8/30          |                        |                    |                    |                    |          |            |               |             |
| X | ISP      | loop0     | Enabled  |        |                | 193.45.28.0/30         |                        |                    |                    |                    |          |            |               |             |
|   | PC A     | NIC       | Enabled  |        |                | 192.168.1.0/24         |                        |                    |                    |                    |          |            |               |             |
|   | PC B     | NIC       | Enabled  |        |                | 192.168.2.0/24         |                        |                    |                    |                    |          |            |               |             |
|   | PC C     | NIC       | Enabled  |        |                | 192.168.3.0/24         |                        |                    |                    |                    |          |            |               |             |
|   | PC D     | NIC       | Enabled  |        |                | 172.16.21.0/24         | 2001:db8:acad:1::/64   |                    |                    |                    |          |            |               |             |
|   | Laptop 1 | NIC       | Enabled  |        |                | 192.168.1.0/24         |                        |                    |                    |                    |          |            |               |             |

## DHCP Pools

| X | Device | Name        | VLAN | Network        |
|---|--------|-------------|------|----------------|
|   | R4     | Engineering | 10   | 192.168.1.0/24 |
|   | R4     | Finance     | 20   | 192.168.2.0/24 |
|   | R4     | Marketing   | 30   | 192.168.3.0/24 |
|   | R4     | Management  | 40   | 192.168.4.0/24 |

## Networks

| Name | Connection | Network        |
|------|------------|----------------|
| A    | VLAN 10    | 192.168.1.0/24 |
| B    | VLAN 20    | 192.168.2.0/24 |
| C    | VLAN 30    | 192.168.3.0/24 |
| D    | VLAN 40    | 192.168.4.0/24 |
| E    | R1 to R4   | 10.10.10.0/30  |
| F    | R2 to R4   | 10.10.10.4/30  |
| G    | R2 to ISP  | 10.10.10.8/30  |
| H    | R4 to ISP  | 10.10.10.12/30 |
| I    | R4 to R3   | 10.10.10.16/30 |
| J    | R3 to PC3  | 172.16.21.0/24 |

## Routes

> | Type                   | Dest. IP        | Dest. Mask      | Exit Interface | Next Hop        | Admin. Distance |
> |------------------------|-----------------|-----------------|----------------|-----------------|-----------------|
> | Static Default         | 0.0.0.0         | 0.0.0.0         |                | xxx.xxx.xxx.xxx |                 |
> | Static Summary         | xxx.xxx.xx0.000 | xxx.xx0.000.000 |                | xxx.xxx.xxx.xxx |                 |
> | Recursive Static       | xxx.xxx.xxx.xxx | xxx.xxx.xxx.xxx |                | xxx.xxx.xxx.xxx |                 |
> | Static Floating        | xxx.xxx.xxx.xxx | xxx.xxx.xxx.xxx |                | xxx.xxx.xxx.xxx | X               |
> | Fully Specified Static | xxx.xxx.xxx.xxx | xxx.xxx.xxx.xxx | aX/Y/Z         | xxx.xxx.xxx.xxx |                 |

| X | Device | Destination IP | Destination Mask | Exit Interface | Next Hop    | Admin. Distance |
|---|--------|----------------|------------------|----------------|-------------|-----------------|
| X | R1     | 0.0.0.0        | 0.0.0.0          |                | 172.16.21.0 |                 |
| X | R1     | 0.0.0.0        | 0.0.0.0          | g0/0/1         | 10.10.10.0  |                 |
| X | R2     | 0.0.0.0        | 0.0.0.0          |                | 172.16.21.0 |                 |
| X | R2     | 172.16.21.0    | /24              |                | 10.10.10.4  | 5               |
| X | R3     | 0.0.0.0        | 0.0.0.0          |                | 172.16.21.0 |                 |
| X | R3     | 192.168.0.0    | /21              |                | 172.16.21.0 |                 |
| X | R3     | ::             | /64              |                |             |                 |
| X | R4     | 0.0.0.0        | 0.0.0.0          |                | 172.16.21.0 |                 |
| X | R4     | 172.16.21.0    | /24              |                | 10.10.10.4  | 5               |
| X | R4     | ::             | /64              |                |             |                 |
| X | ISP    | 0.0.0.0        | 0.0.0.0          |                | 172.16.21.0 |                 |
| X | ISP    | 0.0.0.0        | 0.0.0.0          | loop0          |             |                 |
