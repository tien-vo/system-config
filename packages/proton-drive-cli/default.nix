{
  lib,
  stdenvNoCC,
  fetchurl,
  makeWrapper,
  libsecret,
}:

stdenvNoCC.mkDerivation {
  pname = "proton-drive-cli";
  version = "0.4.6";

  src = fetchurl {
    url =
      "https://proton.me/download/drive/cli/0.4.6/linux-x64/proton-drive";

    hash = "sha256-iaVBMaCBHkLqGOxDBz1us0fYD1lO0CJgCbuUEY9M2oY=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm0755 \
      "$src" \
      "$out/bin/proton-drive"

    wrapProgram "$out/bin/proton-drive" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ libsecret ]}"

    runHook postInstall
  '';

  meta = {
    description = "Official Proton Drive command-line interface";
    homepage = "https://proton.me/support/drive-cli";
    license = lib.licenses.mit;
    mainProgram = "proton-drive";
    platforms = [ "x86_64-linux" ];
  };
}
