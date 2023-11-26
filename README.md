# Sid's Fedora Install Script

My collection of config and setup files for my Linux system.

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



## Software

- [Fedora](https://fedoraproject.org/) with [RPM Fusion free and non-free repos](https://rpmfusion.org/)
- [i3](https://i3wm.org/) and [Polybar](https://polybar.github.io/)
- [Nitrogen](https://github.com/l3ib/nitrogen/), [Picom](https://github.com/yshui/picom), [Greenclip](https://github.com/erebe/greenclip), [Dunst](https://dunst-project.org/), [Rofi](https://github.com/davatorium/rofi)
- [Firefox](https://www.mozilla.org/firefox/)
- [Thunar](https://docs.xfce.org/xfce/thunar/start)
- [Xarchiver](https://github.com/ib/xarchiver)
- [mpv](https://mpv.io/)
- [Xfce4 Terminal](https://docs.xfce.org/apps/terminal/start)
- [VS Code](https://code.visualstudio.com/)
- [Transmission](https://transmissionbt.com/)
- [GIMP](https://www.gimp.org/), [Inkscape](https://inkscape.org/)
- [Audacity](https://www.audacityteam.org/)
- [Handbrake](https://handbrake.fr/)
- [yt-dlp](https://github.com/yt-dlp/yt-dlp), [ffmpeg](https://www.ffmpeg.org/)
- [PHP](https://www.php.net/) with [Xdebug](https://xdebug.org/) and [yaml support](https://www.php.net/manual/en/book.yaml.php), [Composer](https://getcomposer.org/)
- [Docker](https://www.docker.com/), [Docker Compose](https://docs.docker.com/compose/)
- [Autotrash](https://github.com/bneijt/autotrash)
- [Print to PDF support](https://www.cups-pdf.de/)
- [OBS Studio](https://obsproject.com/)
- [Zoom](https://zoom.us/)
- [XP Pen tablet support](https://www.xp-pen.com/)
- [VirtualBox / VirtualBox guest additions](https://www.virtualbox.org/)
- [Git](https://git-scm.com/)
- [Arc Dark theme](https://github.com/jnsh/arc-theme), [Qogir icons](https://github.com/vinceliuice/Qogir-icon-theme), [Nord color scheme](https://www.nordtheme.com/)
- Fonts: [Noto Sans](https://fonts.google.com/noto/specimen/Noto+Sans), [Noto Serif](https://fonts.google.com/noto/specimen/Noto+Serif), [Deja Vu](https://dejavu-fonts.github.io/), [Fira Code](https://github.com/tonsky/FiraCode), [Awesome Terminal Fonts](https://github.com/gabrielelana/awesome-terminal-fonts), [Noto Emoji](https://fonts.google.com/noto/specimen/Noto+Emoji)



## Keyboard Shortcuts / Aliases

### i3 Workspaces

- `Win+1` - Terminal
- `Win+2` - Firefox
- `Win+3` - File manager
- `Win+4` - VS Code
- `Win+5` - mpv
- `Win+6` - Transmission
- `Win+7` to `Win+9` - everything else

### i3 Keybindings

- `Win+Return` - Terminal
- `Win+W`      - Firefox
- `Win+N`      - File manager

- `Win+D` - Applications menu
- `Win+T` - Windows menu

- `Win+C` - Clipboard manager

- `Win+Escape` - Power menu

- `Win+/` - Google Search
- `Win+#` - Google Translate

### Git Aliases

- `git aliases`  - Show all aliases and their commands.
- `git amend`    - Amend previous commit.
- `git branches` - Show all branches.
- `git count`    - List all repository contributors and their number of commits.
- `git remotes`  - Show all remotes.
- `git tags`     - Show all tags.



## License

[![License](https://img.shields.io/github/license/SidRoberts/fedora-install-script?style=for-the-badge)](LICENSE.md)

This repository is released under the Unlicense license.
See [LICENSE.md](LICENSE.md) for more details.
