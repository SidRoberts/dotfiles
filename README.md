# Sid's Arch Install Script

This script is designed to run on my *vintage* Dell XPS 13 (L322X, early 2013) and VirtualBox (with EFI enabled).

**Please don't run this yourself.** Fork and modify it, learn from it, critique it, but don't actually run the damn thing. :p

## How to run

(The `install.sh` script simply installs Git and clones this repo).

Boot into the Arch ISO image.

```bash
curl https://sidroberts.co.uk/install.sh | bash
```

Reboot.

```bash
cd arch-install-script/

bash first-boot.sh
```

Reboot again.

Now, check out the `ToDoList.md` file in the home directory.
