#!/bin/sh -e
#
# Removes unwanted content from the upstream sources.
# Called by uscan with '--upstream-version' <version> <file>
#

VERSION=$2
TAR=../maven-gettext-plugin_$VERSION.orig.tar.xz
DIR=maven-gettext-plugin-$VERSION
TAG=$(echo "$VERSION" | sed -re's/~(alpha|beta|rc)/-\1-/')

svn export http://gettext-commons.googlecode.com/svn/maven2-plugins/tags/${TAG}/maven-gettext-plugin $DIR
XZ_OPT=--best tar -c -J -f $TAR --exclude '*.jar' --exclude '*.class' --exclude '.cvsignore' --exclude '.settings' --exclude-vcs $DIR
rm -rf $DIR ../$TAG

# move to directory 'tarballs'
if [ -r .svn/deb-layout ]; then
  . .svn/deb-layout
  mv $TAR $origDir && echo "moved $TAR to $origDir"
fi
