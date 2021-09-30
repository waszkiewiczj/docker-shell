# Docker Shell

Run with:
```bash
docker run \
--priviledged \
--interactive \
--tty \
--rm \
--net host \
--pid host \
--user "$(id -u):$(id -g)" \
--volume "${HOME}:${HOME}" \
--volume "/etc/passwd:/etc/passwd:ro" \
--workdir "${HOME}" \
<image-tag>
```