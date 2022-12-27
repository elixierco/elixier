podman create --name hue -p 8888:8888 -v ./z-hue-overrides.ini:/usr/share/hue/desktop/conf/z-hue-overrides.ini registry.gitlab.com/abyres/releases/hue:development
