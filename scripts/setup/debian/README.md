# Debian Things

## Download Debian

### Roots
- [/cdimage](https://cdimage.debian.org/cdimage/) **(preferred)**
- [/debian-cd](https://cdimage.debian.org/debian-cd/)

### Stable / Bookworm (12)
- [x] [stable-netinstall-iso](https://cdimage.debian.org/cdimage/release/current/amd64/iso-cd/)
- [x] [stable-netinstall-torrent](https://cdimage.debian.org/cdimage/release/current/amd64/bt-cd/)
- [x] [stable-full-iso](https://cdimage.debian.org/cdimage/release/current/amd64/iso-dvd/)
- [x] [stable-full-torrent](https://cdimage.debian.org/cdimage/release/current/amd64/bt-dvd/)

### Testing (weekly)
- [x] [testing-netinstall-iso](https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-cd/)
- [ ] *testing-netinstall-torrent*
- [x] [testing-full-iso](https://cdimage.debian.org/cdimage/weekly-builds/amd64/iso-dvd/)
- [ ] *testing-full-torrent*

### Unstable (daily)
- [x] [unstable-netinstall-iso](https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/)
- [ ] *unstable-netinstall-torrent*
- [ ] *unstable-full-iso*
- [ ] *unstable-full-torrent*

### Non-Free Firmware (all versions)
[link](https://cdimage.debian.org/cdimage/unofficial/non-free/firmware/)

## Debian sources.list

### Stable / Bookworm (12)
```txt
deb https://ftp.debian.org/debian bookworm main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian bookworm main contrib non-free non-free-firmware

deb https://ftp.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb https://ftp.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian bookworm-updates main contrib non-free non-free-firmware

# deb https://ftp.debian.org/debian bookworm-proposed-updates main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian bookworm-proposed-updates main contrib non-free non-free-firmware

deb https://ftp.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
```

### Testing
```txt
deb https://ftp.debian.org/debian testing main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian bookworm main contrib non-free non-free-firmware

deb https://ftp.debian.org/debian-security testing-security main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian-security testing-security main contrib non-free non-free-firmware

deb https://ftp.debian.org/debian testing-updates main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian testing-updates main contrib non-free non-free-firmware

deb https://ftp.debian.org/debian testing-proposed-updates main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian testing-proposed-updates main contrib non-free non-free-firmware

deb https://ftp.debian.org/debian testing-backports main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian testing-backports main contrib non-free non-free-firmware
```

### Unstable
```txt
deb https://ftp.debian.org/debian unstable main contrib non-free non-free-firmware
# deb-src https://ftp.debian.org/debian unstable main contrib non-free non-free-firmware
```
