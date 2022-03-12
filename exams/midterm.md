# Midterm Exam

## Subnets

| Subnet | Hosts Required | Addresses Required | Total Size | IP                  | VLAN |
|--------|----------------|--------------------|------------|---------------------|------|
| A      | 108            | 110                | 128        | `172.16.128.0/25`   | 10   |
| B      | 64             | 66                 | 128        | `172.16.128.128/25` | 20   |
| C      | 32             | 34                 | 64         | `172.16.129.0/26`   | 30   |
| D      | 6              | 8                  | 8          | `172.16.129.64/29`  | 99   |
| E      | 2              | 4                  | 4          | `172.16.128.80/30`  | N/A  |
| F      | 6              | 8                  | 8          | `172.16.128.72/29`  | N/A  |

## VLANs

| VLAN | Name       |
|------|------------|
| 10   | Student    |
| 20   | Faculty    |
| 30   | HR         |
| 99   | Management |

## Routers

### R1

#### Settings

- Hostname: `R1`
- DNS lookup disabled
- Password: `class`
- MOTD: "Unauthorized access is strictly prohibited."

#### Services

- `password-encryption`: enabled

#### Lines

- `vty 0 15`
  - Password: `cisco`
  - Login: enabled
- `console 0`
  - Password: `cisco`
  - Login: enabled

#### Interfaces

- `g0/0/0`
  - Connected to S3
  - Assign with IPv6 SLAAC (?)
- `g0/0/0.10`
  - IPv4: Use broadcast address for subnet A (`172.16.128.127/25`)
  - VLAN: 10
- `g0/0/0.20`
  - IPv4: Use broadcast address for subnet B (`172.16.128.255/25`)
  - VLAN: 20
- `g0/0/0.30`
  - IPv4: Use broadcast address for subnet C (`172.16.129.63/26`)
  - VLAN: 30
- `g0/0/0.99`
  - IPv4: Use broadcast address for subnet D (`172.16.129.83/29`)
  - VLAN: 99
- `g0/0/1`
  - Connected to R2
  - IPv4: Use first host in subnet E (`172.16.128.81/30`)

### R2

#### Settings

- Hostname: `R2`
- DNS lookup disabled
- Password: `class`
- MOTD: "Unauthorized access is strictly prohibited."

#### Services

- `password-encryption`: enabled

#### Lines

- `vty 0 15`
  - Password: `cisco`
  - Login: enabled
- `console 0`
  - Password: `cisco`
  - Login: enabled

#### Interfaces

- `g0/0/0`
  - Connected to S4
  - IPv4: Use first host in subnet F (`172.16.128.73/29`)
  - IPv6: `2001:abc:456:11::1/64`
- `g0/0/1`
  - Connected to R1
  - IPv4: Use second host in subnet E (`172.16.128.82/30`)
  - IPv6: `2001:abc:456:10::1/64`

## Switches

### S1

#### Settings

- Hostname: `S1`
- DNS lookup disabled
- Password: `class`
- MOTD: "Unauthorized access is strictly prohibited."
- STP: `rapid-pvst`
- Root bridge for VLAN 10
- Add to VLAN 99 for remote access
- Assign portfast and BPDU guard to appropriate interfaces

#### Services

- `password-encryption`: enabled

#### Lines

- `vty 0 15`
  - Password: `cisco`
  - Login: enabled
- `console 0`
  - Password: `cisco`
  - Login: enabled

#### Interfaces

- `f0/1`
  - Connected to S3
  - Trunk VLANs: 10, 20, 30, 99
  - LACP group: 1
  - Enabled
- `f0/2`
  - Connected to S3
  - Trunk VLANs: 10, 20, 30, 99
  - LACP group: 1
  - Enabled
- `f0/3`
  - Connected to S2
  - Trunk VLANs: 10, 20, 30, 99
  - PAgP group: 2
  - Enabled
- `f0/4`
  - Connected to S2
  - Trunk VLANs: 10, 20, 30, 99
  - PAgP group: 2
  - Enabled
- `f0/5`
  - Disconnected
  - Disabled
- `f0/6`
  - Disconnected
  - Disabled
- `f0/7`
  - Disconnected
  - Disabled
- `f0/8`
  - Disconnected
  - Disabled
- `f0/9`
  - Disconnected
  - Disabled
- `f0/10`
  - Disconnected
  - Disabled
- `f0/11`
  - Disconnected
  - Disabled
- `f0/12`
  - Disconnected
  - Disabled
- `f0/13`
  - Disconnected
  - Disabled
- `f0/14`
  - Disconnected
  - Disabled
- `f0/15`
  - Disconnected
  - Disabled
- `f0/16`
  - Disconnected
  - Disabled
- `f0/17`
  - Disconnected
  - Disabled
- `f0/18`
  - Disconnected
  - Disabled
- `f0/19`
  - Disconnected
  - Disabled
- `f0/21`
  - Disconnected
  - Disabled
- `f0/22`
  - Disconnected
  - Disabled
- `f0/23`
  - Disconnected
  - Disabled
- `f0/24`
  - Connected to PCA
  - Access VLANs: 10
  - Enabled
- `g0/0`
  - Disconnected
  - Disabled
- `g0/1`
  - Disconnected
  - Disabled
- `vlan 99`
  - IPv4: Use second host in subnet D (`172.16.129.66/29`)

### S2

#### Settings

- Hostname: `S2`
- DNS lookup disabled
- Password: `class`
- MOTD: "Unauthorized access is strictly prohibited."
- STP: `rapid-pvst`
- Root bridge for VLAN 20
- Add to VLAN 99 for remote access
- Assign portfast and BPDU guard to appropriate interfaces

#### Services

- `password-encryption`: enabled

#### Lines

- `vty 0 15`
  - Password: `cisco`
  - Login: enabled
- `console 0`
  - Password: `cisco`
  - Login: enabled

#### Interfaces

- `f0/1`
  - Disconnected
  - Disabled
- `f0/2`
  - Disconnected
  - Disabled
- `f0/3`
  - Connected to S1
  - Trunk VLANs: 10, 20, 30, 99
  - PAgP group: 2
  - Enabled
- `f0/4`
  - Connected to S1
  - Trunk VLANs: 10, 20, 30, 99
  - PAgP group: 2
  - Enabled
- `f0/5`
  - Connected to S3
  - Trunk VLANs: 10, 20, 30, 99
  - PAgP group: 3
  - Enabled
- `f0/6`
  - Connected to S3
  - Trunk VLANs: 10, 20, 30, 99
  - PAgP group: 3
  - Enabled
- `f0/7`
  - Disconnected
  - Disabled
- `f0/8`
  - Disconnected
  - Disabled
- `f0/9`
  - Disconnected
  - Disabled
- `f0/10`
  - Disconnected
  - Disabled
- `f0/11`
  - Disconnected
  - Disabled
- `f0/12`
  - Disconnected
  - Disabled
- `f0/13`
  - Disconnected
  - Disabled
- `f0/14`
  - Disconnected
  - Disabled
- `f0/15`
  - Disconnected
  - Disabled
- `f0/16`
  - Disconnected
  - Disabled
- `f0/17`
  - Disconnected
  - Disabled
- `f0/18`
  - Disconnected
  - Disabled
- `f0/19`
  - Disconnected
  - Disabled
- `f0/21`
  - Disconnected
  - Disabled
- `f0/22`
  - Disconnected
  - Disabled
- `f0/23`
  - Connected to PCB
  - Access VLANs: 20
  - Enabled
- `f0/24`
  - Connected to PCC
  - Access VLANs: 30
  - Enabled
- `g0/0`
  - Disconnected
  - Disabled
- `g0/1`
  - Disconnected
  - Disabled
- `vlan 99`
  - IPv4: Use third host in subnet D (`172.16.129.67/29`)

### S3

#### Settings

- Hostname: `S3`
- DNS lookup disabled
- Password: `class`
- MOTD: "Unauthorized access is strictly prohibited."
- STP: `rapid-pvst`
- Root bridge for VLAN 30
- Add to VLAN 99 for remote access
- Assign portfast and BPDU guard to appropriate interfaces

#### Services

- `password-encryption`: enabled

#### Lines

- `vty 0 15`
  - Password: `cisco`
  - Login: enabled
- `console 0`
  - Password: `cisco`
  - Login: enabled

#### Interfaces

- `f0/1`
  - Connected to S1
  - Trunk VLANs: 10, 20, 30, 99
  - LACP group: 1
  - Enabled
- `f0/2`
  - Connected to S1
  - Trunk VLANs: 10, 20, 30, 99
  - LACP group: 1
  - Enabled
- `f0/3`
  - Disconnected
  - Disabled
- `f0/4`
  - Disconnected
  - Disabled
- `f0/5`
  - Connected to S3
  - Trunk VLANs: 10, 20, 30, 99
  - PAgP group: 3
  - Enabled
- `f0/6`
  - Connected to S3
  - Trunk VLANs: 10, 20, 30, 99
  - PAgP group: 3
  - Enabled
- `f0/7`
  - Disconnected
  - Disabled
- `f0/8`
  - Disconnected
  - Disabled
- `f0/9`
  - Disconnected
  - Disabled
- `f0/10`
  - Disconnected
  - Disabled
- `f0/11`
  - Disconnected
  - Disabled
- `f0/12`
  - Disconnected
  - Disabled
- `f0/13`
  - Disconnected
  - Disabled
- `f0/14`
  - Disconnected
  - Disabled
- `f0/15`
  - Disconnected
  - Disabled
- `f0/16`
  - Disconnected
  - Disabled
- `f0/17`
  - Disconnected
  - Disabled
- `f0/18`
  - Disconnected
  - Disabled
- `f0/19`
  - Disconnected
  - Disabled
- `f0/21`
  - Disconnected
  - Disabled
- `f0/22`
  - Disconnected
  - Disabled
- `f0/23`
  - Disconnected
  - Disabled
- `f0/24`
  - Disconnected
  - Disabled
- `g0/0`
  - Disconnected
  - Disabled
- `g0/1`
  - Connected to R1
  - Trunk VLANs: 10, 20, 30, 99
  - Enabled
- `vlan 99`
  - IPv4: Use fourth host in subnet D (`172.16.129.68/29`)

### S4

## Computers

### PCA

#### Interfaces

- `f0/1`
  - IPv4: Use DHCP for subnet A

### PCB

#### Interfaces

- `f0/1`
  - IPv4: Use DHCP for subnet B

### PCC

#### Interfaces

- `f0/1`
  - IPv4: Use DHCP for subnet C

### PCD

#### Interfaces

- `f0/1`
  - IPv4: Use DHCP for subnet F
  - IPv6: Use stateful DHCP
