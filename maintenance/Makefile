
UNIX_DASHBOARDS = factory-macos factory-south-macos factory-south-ubuntu metroplex
WIN_DASHBOARDS = overload

DASHBOARDS = $(UNIX_DASHBOARDS) $(WIN_DASHBOARDS)

help:
	@echo "$(MAKE) [target]"
	@echo
	@echo "  targets:"
	@echo
	@echo "    nightly-script-cmake-update                      - Update cmake used in nightly dasboard scripts"
	@echo "    nightly-script-cmake-update.<dashboard_name>     - Update cmake used in a nightly specific dasboard script"
	@echo
	@echo "    remote-install-cmake                             - Install cmake on dashboards"
	@echo "    remote-install-cmake.<dashboard_name>            - Install cmake on a specific dashboard"
	@echo
	@echo "    pull-crontab                                     - Download crontab setting of all dashboards"
	@echo "    pull-crontab.<dashboard_name>                    - Download crontab setting of a specific dashboard"
	@echo
	@echo "    push-crontab                                     - Install crontab setting of all dashboards"
	@echo "    push-crontab.<dashboard_name>                    - Install crontab setting of a specific dashboard"
	@echo
	@echo "  dashboards:"
	@echo
	@for dashboard in $(DASHBOARDS); do \
		echo "    $$dashboard"; \
	done
	@echo

.PHONY: help

#-------------------------------------------------------------------------------
nightly-script-cmake-update: $(addprefix nightly-script-cmake-update.,$(DASHBOARDS))

$(addprefix nightly-script-cmake-update.,$(DASHBOARDS)):
	@echo
	common/nightly-script-cmake-update.sh $(subst .,,$(suffix $@)) ${CMAKE_VERSION}

.PHONY: nightly-script-cmake-update $(addprefix nightly-script-cmake-update.,$(DASHBOARDS))

nightly-script-cmake-update.metroplex:
	echo "metroplex: skipping nightly-script-cmake-update"

#-------------------------------------------------------------------------------
remote-install-cmake: nightly-script-cmake-update $(addprefix remote-install-cmake.,$(UNIX_DASHBOARDS))

$(addprefix remote-install-cmake.,$(UNIX_DASHBOARDS)):
	$(subst .,,$(suffix $@))/remote-install-cmake.sh ${CMAKE_VERSION}

.PHONY: remote-install-cmake $(addprefix remote-install-cmake.,$(UNIX_DASHBOARDS))

remote-install-cmake.metroplex:
	echo "metroplex: skipping remote-install-cmake"

#-------------------------------------------------------------------------------
pull-crontab:$(addprefix pull-crontab.,$(UNIX_DASHBOARDS))

$(addprefix pull-crontab.,$(UNIX_DASHBOARDS)):
	common/pull-crontab.sh $(subst .,,$(suffix $@))

.PHONY: pull-crontab $(addprefix pull-crontab.,$(UNIX_DASHBOARDS))

#-------------------------------------------------------------------------------
push-crontab:$(addprefix push-crontab.,$(UNIX_DASHBOARDS))

$(addprefix push-crontab.,$(UNIX_DASHBOARDS)):
	common/push-crontab.sh $(subst .,,$(suffix $@))

.PHONY: push-crontab $(addprefix push-crontab.,$(UNIX_DASHBOARDS))
