import subprocess

def is_vm():
    systemd_detect_virt = subprocess.run(['systemd-detect-virt'], universal_newlines=True, check=False, capture_output=True)

    virt_status = systemd_detect_virt.stdout.rstrip('\n')

    return virt_status != 'none'

def exit_if_vm():
    if is_vm():
        # Clear any previous content.
        print('')

        exit(0)
