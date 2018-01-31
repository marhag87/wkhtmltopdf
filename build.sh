#!/bin/bash

set -e

function version() {
  awk '/^Version/ {print $2}' SPECS/wkhtmltopdf.spec
}

function build() {
  rm -rf BUILD BUILDROOT RPMS SRPMS || true
  mkdir SOURCES 2>/dev/null || true
  wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/$(version)/wkhtmltox-$(version)_linux-generic-amd64.tar.xz -O SOURCES/wkhtmltopdf-$(version).tar.xz
  rpmbuild --define "_topdir $(git rev-parse --show-toplevel)" -bb SPECS/wkhtmltopdf.spec
  mv RPMS/x86_64/wkhtmltopdf-*.rpm .
}

build
