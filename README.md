# i3-utils-systemd

Systemd utilities for a minimalistic [i3](https://github.com/i3/i3) setup.

1. Lock screen before suspend
2. Suspend on lid close

---

**This repository is part of the [i3-utils](https://github.com/cytopia/i3-utils).** (See also [i3-utils-bin](https://github.com/cytopia/i3-utils-bin))

---

## Systemd

| Tool | Target | Description |
|------|--------|-------------|
| [70-close_lid.conf](systemd/logind.conf.d/70-close_lid.conf) | `/usr/lib/systemd/logind.conf.d/` | Systemd login configuration to handle notebook lid close. Will put the computer to sleep when the lid closes.<br/><br/><strong>Only going to sleep when:</strong><br/><ul><li>No power or docking station is connected</li><li>No external monitor is connected</li><li>No graphical desktop environment already handles lid close actions and prevents systemd via low-level inhibitor lock.</li></ul> |
| [suspend.service](systemd/system/suspend.service) | `/usr/lib/systemd/system/` | Suspend addition to lock the screen before going to sleep.<br/>**It requires [xlock](https://github.com/cytopia/i3-utils-bin/blob/master/bin/xlock).** |


## Integration

#### Requirements

* [convert](https://linux.die.net/man/1/convert)
* [i3lock](https://github.com/i3/i3lock)
* [scrot](https://man.cx/scrot)
* [xlock](https://github.com/cytopia/i3-utils-bin/blob/master/bin/xlock) *([i3-utils-bin](https://github.com/cytopia/i3-utils-bin))*

#### Install

This will copy files to `/usr/lib/systemd/`, enable the services and reload systemd.

```bash
$ ./configure
$ sudo make install
```

#### Uninstall

This will disable the services, remove files from `/usr/lib/systemd/` and reload systemd.

```bash
$ sudo make uninstall
```



