# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

DESCRIPTION="The Python REST HTTP Toolkit and Object Relational Mapper."
HOMEPAGE="https://restalchemy.synapse.net.ru/"
SRC_URI="https://github.com/phantomii/restalchemy/archive/${PV}.tar.gz"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~arm ~ia64 ~x86"
SLOT="0"

IUSE="test sqlalchemy"

RDEPEND="
	>=dev-python/anyjson-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/webob-1.4[${PYTHON_USEDEP}]
	sqlalchemy? (
		>=dev-python/sqlalchemy-0.7.10[${PYTHON_USEDEP}]
	)"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
        >=dev-python/pbr-0.8.2[${PYTHON_USEDEP}]
	test? (
                >=dev-python/coverage-3.6[${PYTHON_USEDEP}]
                >=dev-python/mock-1.0.1[${PYTHON_USEDEP}]
                >=dev-python/nose-1.3.0[${PYTHON_USEDEP}]
                >=dev-python/hacking-0.7.2[${PYTHON_USEDEP}]
                >=dev-python/testtools-0.9.32[${PYTHON_USEDEP}]
                >=dev-python/unittest2-0.5.1[${PYTHON_USEDEP}]
        )
	${RDEPEND}"
