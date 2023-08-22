#{ 
#pkgs ? import <nixpkgs> { system = builtins.currentSystem; }
#, lib ? pkgs.lib
#, stdenv ? pkgs.stdenv
#, fetchurl ? pkgs.fetchurl
#, fetchFromGitLab ? pkgs.fetchFromGitLab
#, testVersion ? pkgs.testVersion
#, hello ? pkgs.hello
#}:
{ pkgs, lib, stdenv, fetchFromGitLab, ... }:

stdenv.mkDerivation rec {
  pname = "space2meta";
  version = "v0.2.0";

  src = fetchFromGitLab {
    group = "interception";
    owner = "linux/plugins";
    repo = pname;
    rev = version;
    sha256 = "MvpIe230I0TNzTO6ol1+DrpcFgqw0gF9Z22WMQLujb4=";
  };

  nativeBuildInputs = [ pkgs.cmake ];

  meta = with lib; {
    homepage = "https://gitlab.com/interception/linux/plugins/space2meta";
    description = "Hold space for meta, tap space for space.";
    license = licenses.mit;
    maintainers = with maintainers; [ dougw ];
    platforms = platforms.linux;
    mainProgram = "space2meta";
  };
}
