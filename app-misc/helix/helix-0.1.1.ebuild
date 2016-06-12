# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 user systemd

DESCRIPTION="Trading platform"
HOMEPAGE="https://helix.synapse.net.ru/"
SRC_URI="https://github.com/phantomii/helix/releases/download/${PV}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="amd64 arm ia64 x86"
SLOT="0"

IUSE="test mysql-client sqlite gui server"

RDEPEND="
        >=dev-python/alembic-0.7.7[${PYTHON_USEDEP}]
        >=dev-python/six-1.7.0[${PYTHON_USEDEP}]
        >=dev-python/oslo-config-1.9.0[${PYTHON_USEDEP}]
        >=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
        >=dev-python/sqlalchemy-0.7.10[${PYTHON_USEDEP}]
        test? (
            >=dev-python/coverage-3.6[${PYTHON_USEDEP}]
            >=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
            >=dev-python/nose-1.3.0[${PYTHON_USEDEP}]
            >=dev-python/hacking-0.10.1[${PYTHON_USEDEP}]
            >=dev-python/testtools-1.5.0[${PYTHON_USEDEP}]
            dev-vcs/git
        )
        mysql-client? (
            dev-python/mysql-python[${PYTHON_USEDEP}]
        )
        sqlite? (
            dev-db/sqlite
        )
        gui? (
            >=dev-python/numpy-1.8.2[${PYTHON_USEDEP}]
            >=dev-python/pygobject-3.14.0[${PYTHON_USEDEP}]
        )
        server? (
            dev-python/restalchemy[${PYTHON_USEDEP}]
            www-servers/uwsgi[${PYTHON_USEDEP},python]
        )"

DEPEND="
    dev-python/setuptools[${PYTHON_USEDEP}]
    >=dev-python/pbr-0.8.2[${PYTHON_USEDEP}]
    ${RDEPEND}"

PDEPEND="dev-python/pip[${PYTHON_USEDEP}]"

pkg_setup() {
    enewgroup helix
    enewuser helix -1 -1 /var/lib/helix helix
}

python_install() {
    distutils-r1_python_install

    diropts -m 0755 -o root -g root
    insinto /etc/helix
    insopts -m 0644 -o root -g root
    doins "etc/helix.conf"
    doins "etc/logging.yaml"

    diropts -m 0755 -o helix -g root
    keepdir /var/lib/helix

    diropts -m 0755 -o helix -g root
    keepdir /var/log/helix

    if use server ; then
        diropts -m 0755 -o root -g root
        insinto /var/lib/helix
        insopts -m 0444 -o root -g root
        doins "helix.wsgi"

        diropts -m 0755 -o root -g root
        insinto /etc/helix/uwsgi
        insopts -m 0444 -o root -g root
        doins "etc/uwsgi/helix.ini"

        # systemd sturtup
        systemd_newunit etc/systemd/helix.uwsgi.service helix.uwsgi.service
    fi
}
