# OP25 Docker

Docker image used to run OP25 (Boatbod fork) in a docker container based on Ubuntu 18.04.

## Changing the Configuration

Example startup scripts are located in the config folder. This is mapped to the container at runtime (`/op25/op25/gr-op25_repeater/apps/config`).

If you change the http port from port 8080, make sure you update `docker-compose.yml`, `start-op25-detached.sh`, `start-op25.sh`, and `config/op25.sh` files to reflect the new port.
