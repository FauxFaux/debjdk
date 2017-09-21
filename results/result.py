#!/usr/bin/env python3
import subprocess
from typing import Set

blacklist = {
    'mongo-java-driver',  # build fails to exit properly
    'vtk6',  # build takes hours
    'octave-ltfat',  # no idea what went wrong here
    'tomcat8',  # build takes forever(?)
    'subversion',  # can't build as root
}


def load(path: str) -> Set[str]:
    with open(path) as f:
        return set(line.strip() for line in f.readlines())


def main():
    one_attempted = load('2017-08-22/attempted')
    two_attempted = load('2017-08-30/attempted')
    one_failures = load('2017-08-22/failures')
    two_failures = load('2017-08-30/failures')

    same_attempted = one_attempted.intersection(two_attempted)

    print('Blacklist (packages which cause issues):')
    print(sorted(blacklist))
    print()

    print('Packages only in first run:')
    print(sorted(one_attempted - same_attempted))
    print()

    print('Packages only in second run:')
    print(sorted(two_attempted - same_attempted))
    print()

    bugs = load('bugs')

    print("Failures caused by -source/-target, but for which there isn't a bug, hopefully as they'll be fixed by ant:")
    source_target_failures = two_failures - one_failures - bugs
    print(sorted(source_target_failures))
    print()

    # curl 'https://bugs.debian.org/cgi-bin/pkgreport.cgi?tag=default-java9;users=debian-java@lists.debian.org' | fgrep \?src= | cut -d ':' -f 2 | cut -d '<' -f 1 | sort -u > bugs

    unknown_failures = two_failures - bugs - source_target_failures - blacklist

    encoding = set(subprocess.check_output(['fgrep', '-l', 'error: unmappable character']
                                           + [x + '.pkg.fail' for x in unknown_failures],
                                           cwd='../2017-08-30').decode('utf-8').split('.pkg.fail\n'))

    print('Packages with apparent encoding issues:')
    print(sorted(encoding))
    print()

    unknown_failures -= encoding

    # wget -N https://tests.reproducible-builds.org/reproducible.json.bz2 && bzcat reproducible.json.bz2 | jq -r '.[]|select(.architecture=="amd64" and .status != "reproducible" and .status != "unreproducible" and .suite=="unstable")|.package'  > jenkins
    jenkins = load('jenkins')

    before = len(unknown_failures)
    unknown_failures -= jenkins
    print('{} are broken on jenkins too'.format(before - len(unknown_failures)))

    print('Remainder: {}:'.format(len(unknown_failures)))
    for item in sorted(unknown_failures):
        print(item)


if __name__ == '__main__':
    main()
