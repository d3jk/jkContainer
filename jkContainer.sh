#!/usr/bin/env bash

rootfs="minirootfs"
sourcefile=".sourcefile"

trap "echo 'Thanks, come again!'" EXIT

# check if source file already exists
if [[ -f "${rootfs}/${sourcefile}" ]]; then
    echo "" > ${rootfs}/${sourcefile}
fi

# commands to execute inside containerized process
cmds=(\
    "mount -t proc proc /proc" \
    "mount -t sysfs sysfs /sys" \
    "mount -t tmpfs cgroup_root /sys/fs/cgroup" \
    "mkdir /sys/fs/cgroup/memory" \
    "mkdir /sys/fs/cgroup/blkio" \
    "mkdir /sys/fs/cgroup/pids" \
    "mkdir /sys/fs/cgroup/rdma" \
    "mkdir /sys/fs/cgroup/freezer" \
    "mount -t cgroup -o memory cgroup_memory /sys/fs/cgroup/memory/" \
    "mount -t cgroup -o blkio cgroup_blkio /sys/fs/cgroup/blkio/" \
    "mount -t cgroup -o pids cgroup_pids /sys/fs/cgroup/pids/" \
    "mount -t cgroup -o rdma cgroup_rdma /sys/fs/cgroup/rdma/" \
    "mount -t cgroup -o freezer cgroup_freezer /sys/fs/cgroup/freezer/" \
    "hostname jkcontainer"
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

