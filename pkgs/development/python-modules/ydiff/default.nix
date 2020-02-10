{ stdenv, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "ydiff";
  version = "1.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0mxcl17sx1d4vaw22ammnnn3y19mm7r6ljbarcjzi519klz26bnf";
  };

  meta = with stdenv.lib; {
    description = "Term based tool to view colored, incremental diff in a Git/Mercurial/Svn workspace or from stdin, with side by side (similar to diff -y) and auto pager support";
    homepage = "https://github.com/ymattw/ydiff";
    license = licenses.bsd3;
    maintainers = [ maintainers.limeytexan ];
  };
}
