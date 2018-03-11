
DASHBOARDS = factory-south-macos factory-south-ubuntu

push-crontab:$(addprefix push-crontab.,$(DASHBOARDS))

pull-crontab:$(addprefix pull-crontab.,$(DASHBOARDS))

$(addprefix push-crontab.,$(DASHBOARDS)):
	common/push-crontab.sh $(subst .,,$(suffix $@))

$(addprefix pull-crontab.,$(DASHBOARDS)):
	common/pull-crontab.sh $(subst .,,$(suffix $@))

.PHONY: push-crontab $(addprefix push-crontab.,$(DASHBOARDS)) pull-crontab $(addprefix pull-crontab.,$(DASHBOARDS))
