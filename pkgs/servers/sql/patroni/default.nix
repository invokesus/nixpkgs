{ stdenv, python3Packages, fetchurl }:

let
  pythonPackages = python3Packages;

in
pythonPackages.buildPythonApplication rec {
  name = "patroni-${version}";
  version = "1.6.4";

  src = fetchurl {
    url = "https://github.com/zalando/patroni/archive/v${version}.tar.gz";
    sha256 = "0a8pzy3sf164byz4wkjcgm6yi45y2rkaf8jvzlhnbq3rdq68pb0x";
  };
  postPatch = ''
    # cdiff renamed to ydiff; remove when patroni source reflects this.
    for i in requirements.txt patroni/ctl.py tests/test_ctl.py; do
      substituteInPlace $i --replace cdiff ydiff
    done
  '';

  nativeBuildInputs = with pythonPackages; [
    flake8
    mock
    pytest
    pytestcov
    requests
  ];

  propagatedBuildInputs = with pythonPackages; [
    boto
    click
    consul
    dns
    kazoo
    kubernetes
    prettytable
    psutil
    psycopg2
    python-dateutil
    python-etcd
    pyyaml
    tzlocal
    urllib3
    ydiff
  ];

  preCheck = "export HOME=$(mktemp -d)";

  meta = with stdenv.lib; {
    homepage = https://patroni.readthedocs.io/en/latest/;
    description = "A Template for PostgreSQL HA with ZooKeeper, etcd or Consul";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = [ maintainers.limeytexan ];
  };
}
