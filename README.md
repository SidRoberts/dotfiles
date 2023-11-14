# Sid's Fedora Install Script

This script is designed to run on my *vintage* Dell XPS 13 (L322X, early 2013) and VirtualBox.

**Please don't run this yourself.** Fork and modify it, learn from it, critique it, but don't actually run the damn thing. :p



## How to run

Install the OS using the [Fedora i3 Spin 39](https://fedoraproject.org/spins/i3/) ISO image.
Then run:

```bash
curl https://sidroberts.co.uk/install.sh | bash
```

(The `install.sh` script simply downloads this repo and runs `setup.sh`).

Once the script has finished, it will automatically reboot.

Now, check out the `ToDoList.md` file in the home directory.



## License

[![License](https://img.shields.io/github/license/SidRoberts/fedora-install-script?style=for-the-badge)](LICENSE.md)

This repository is released under the Unlicense license.
See [LICENSE.md](LICENSE.md) for more details.
