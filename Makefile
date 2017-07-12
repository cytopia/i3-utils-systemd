# Configuration
SHELL = /bin/sh
MKDIR_P = mkdir -p
SYSTEMCTL = systemctl

# Check if './configure' has been run
CONFIGURED = 0
ifneq ("$(wildcard build/70-close_lid.conf)","")
  ifneq ("$(wildcard build/suspend.service)","")
    CONFIGURED = 1
  endif
endif

all:
	@echo "Type 'make install' or 'make uninstall'"
	@echo
	@echo "make install"
	@echo "   Will copy files to /var/lib/systemd"
	@echo "   enable services and reload systemd."
	@echo ""
	@echo "make uninstall"
	@echo "   Will remove files from /var/lib/systemd"
	@echo "   disable services and reload systemd."

install:
ifeq ($(CONFIGURED),0)
  $(error Not configured, run ./configure)
endif
	@# root check
	@[ `id -u` = 0 ] || { echo "Must be run as root or with sudo"; exit 1; }

	@# Create dir
	${MKDIR_P} /usr/lib/systemd/system
	${MKDIR_P} /usr/lib/systemd/logind.conf.d/
	@# Copy files
	install -m 0644 build/suspend.service   /usr/lib/systemd/system/suspend.service
	install -m 0644 build/70-close_lid.conf /usr/lib/systemd/logind.conf.d/70-close_lid.conf

	${SYSTEMCTL} enable suspend.service
	${SYSTEMCTL} daemon-reload

uninstall:
	@# root check
	@[ `id -u` = 0 ] || { echo "Must be run as root or with sudo"; exit 1; }

	@# Remove files
	${SYSTEMCTL} disable suspend.service 2>/dev/null || true
	rm -f /usr/lib/systemd/system/suspend.service
	rm -f /usr/lib/systemd/logind.conf.d/70-close_lid.conf
	${SYSTEMCTL} daemon-reload
