c = get_config()

c.ServerProxy.servers = {
    'webide': {
        'command': ['/opt/code-server/bin/code-server', '--port', '{port}', 
                    '--auth', 'none', '--disable-workspace-trust',
                    '--disable-file-downloads', '--disable-telemetry', 
                    '--disable-update-check'],
        'launcher_entry': {
            'enabled': True,
            'icon_path': '/opt/code-server/builder.svg',
            'title': 'Web IDE'
        },
        'timeout': 60
    }
}

c.Application.logging_config = {
    'handlers': {
        'labapp': {
            'class': 'logging.FileHandler',
            'level': 'WARN',
            'filename': '/workdir/LabApp.log',
        }
    },
    'loggers': {
        'LabApp': {
            'level': 'WARN',
            # NOTE: if you don't list the default "console"
            # handler here then it will be disabled
            'handlers': ['console', 'labapp'],
        },
    }
}

