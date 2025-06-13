# dockala: Lessons learned in Docker management converted to configs and scripts


You can't be like me right? Using Docker and have no clue why you have to do
emergency disk usage clean up every so often? Well, I got tired of forgetting,
so this repository includes all my hacks to maintain Docker in a way that keeps
things organized and not going over board.

## What's in here

### The basics

    - `docker system df`: shows the disk usage just like df but for containers
    - `docker system prune -a --volumes`: let's clean it
    - `sudo systemctl restart docker`: restart the daemon

### Log cleanup

Apparently, chatty containers can create large logs. 1TB is not surprising to
see. The script truncates all container logs (`*-json.log` files in
`/var/lib/docker/containers`) that quietly eat up space. This is the main
culprit of my multi-terabyte surprise.

Can configure and limit log size and rotation. Edit or create `/etc/docker/daemon.json`:

```
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
```

### **Makefile integration**

  So I don’t forget the exact command. Run `make clean-docker-logs` and move on
  with your life.

### Future

I might toss in:

  - Volume audits and pruning
  - Old image cleanup strategies
  - Log rotation daemon
  - Crontab or systemd integration

## Quickstart

```bash
make clean-docker-logs
````

That's it. It runs `scripts/docker_log_cleanup.sh` with `sudo`, truncates logs,
and tells you how much space you saved.


If you're also living that "container grind" life and just want Docker to
behave, clone this, set up a cron job, and stop thinking about it.

```
crontab -e
0 3 * * 0 /path/to/docker_log_cleanup.sh >> /var/log/docker_log_cleanup.log 2>&1
```
