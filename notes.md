Fixed upstream
--------------

 * findbugs: superceeded by "spotbugs" (not packaged), looks to be fixed anyway: https://github.com/findbugsproject/findbugs/issues/105
 * basex: fixed upstream: https://github.com/BaseXdb/basex/commit/f15bb097301ddc9bb89da0a7a5668ebff5d3f3a6
 * assertj-core: Active upstream, encoding issues are probably fixed.

Patch
-----

 * akuma: https://github.com/kohsuke/akuma/issues/14
 * antelope: Fixed, unreleased: https://anonscm.debian.org/git/pkg-java/antelope.git/commit/?id=4294bc4
 * dom4j: pull request for new major version; old version is unmaintained: https://github.com/dom4j/dom4j/pull/29
 * fop / avalon-framework: https://issues.apache.org/jira/browse/FOP-2733
 * olap4j: Upstream build is pretty weird; fixed in Debian. https://anonscm.debian.org/git/pkg-java/olap4j.git/commit/?id=a7cd65ab6831f6c4d3864d0e4a468a6c4614a41b

Bug
---

 * dicomscope: not java team, idle upstream, https://bugs.debian.org/872945
 * charactermanaj: not java team, idle upstream, https://bugs.debian.org/872946

Problems
--------

openjdk swing changes are dumb: https://paste.debian.net/982594/
 * electric
 * freeplane
 * jajuk
 * jsymphonic
 * libjaudiotagger
 * sweethome3d
 * zeroc-ice

openjfx build confuses matters:
 * mediathekview

