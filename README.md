# overleaf-docker

overleaf docker-compose files...

To start do:
```bash
docker-compose pull
docker-compose up -d
```

Or use the start/stop scripts in [scripts](scripts/)

# Setup
Adjust your settings in the ```.env``` and ```mail_pw.env``` file.

Use the scripts in ```scripts/``` to start/stop or create a service. For a service adapt the paths in the ```sharelatex.service``` file.

The setup is originally used with this proxy: https://github.com/timschaeferde/nginx-proxy-automation
