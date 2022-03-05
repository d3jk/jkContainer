#!/usr/bin/env bash

rootfs="minirootfs"
sourcefile=".sourcefile"

# check if source file already exists
if [[ -f "${rootfs}/${sourcefile}" ]]; then
    echo "" > ${rootfs}/${sourcefile}
fi

# commands to execute inside containerized process
cmds=(\
    "mount -t proc proc /proc" \
    "mount -t sysfs sysfs /sys" \
)

for cmd in "${cmds[@]}"; do
    echo "$cmd" >> ${rootfs}/${sourcefile}
done

unshare \
    --uts \
    --pid --fork \
    --ipc \
    --mount \
    --net \
    --cgroup \
    chroot ${rootfs} /bin/sh -c '. '"${sourcefile}"'; exec /bin/sh'



