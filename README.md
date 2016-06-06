#Overlay for Helix project

Include following packages:

    * Helix (Trading platform)
    * RESTAlchemy (The Python REST HTTP Toolkit and Object Relational Mapper)

##Install

As per the [current Portage specifications](https://dev.gentoo.org/~zmedico/portage/doc/man/portage.5.html), overlays should be managed via `/etc/portage/repos.conf/`.
To enable this overlay make sure you are using a recent Portage version (at least `2.2.14`), and crate an `/etc/portage/repos.conf/phantomii` file containing precisely:

```
[phantomii]
location = /usr/local/portage/phantomii
sync-type = git
sync-uri = https://github.com/phantomii/projects-overlay.git
priority=8888
```

Afterwards, simply run `emerge --sync`, and Portage should seamlessly make all our ebuilds available.
Many of our packages are available as live (`*-9999`) ebuilds, and also need manual unmasking in `/etc/portage/package.accept_keywords` before they can be emerged.

---

*Please report issues via the GitHub tracking system! Please fork and submit pull requests! We're happy to merge!*
