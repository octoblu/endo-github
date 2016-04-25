#!/bin/bash

OCTOBLU_CLIENT_ID='a0e80acf-480a-45ad-a7a6-1c920e4c53fb'
OCTOBLU_CLIENT_SECRET='872d84e02a7864469bcf02f0c533fc30c2abd40b'
OCTOBLU_OAUTH_URL='https://oauth.octoblu.com'

GITHUB_CLIENT_ID='e73058c4bf7c9cb95007'
GITHUB_CLIENT_SECRET='8479e154df17ad2ddc4aa835618171ceb10ded08'
GITHUB_CLIENT_CALLBACK='http://endo-github.octoblu.dev/auth/api/callback'

SERVICE_URI="http://requestb.in/s9x4z5s9"

MESHBLU_UUID='189a6758-bc9c-49e1-ab14-1240ebaf2d5c'
MESHBLU_TOKEN='48c583526dea3b446caad32ccea82dba7ad280a2'
MESHBLU_PRIVATE_KEY='MIIBOwIBAAJBAKjUyLSVcbWUHA8hQJiUcTpwqECuojTUzIxU7ki36V3iei6Nm33A7zyFwWy9/5kg3yST7bjx2YuGb2Y4guMmil8CAwEAAQJABtbv9pjjTWbdqCNBuayx1ZtAxbYNbjR8wOaj7KA+vQXh8whZ/vVhket+bGab2tOmafVriRS/A8miHTfbBZ51CQIhANCZGJiV1kFqyz2yOUt/259WEzNb0e3Wb0l29Bwmvd0tAiEAzzJOcJqlflnGDVUtCApGxM9i+38iayAnETfgMiPrdTsCIQDDU0gTwOJiWRS8zcEWsD+/gIL0KXt2oL+OZAOKxMAudQIhAL+MB14sabCcd+8dfkr/jRsnip9skjos+FD/sgFImcW/AiBFw81eDRJs6P/px4zwCV0PcWxqXoIme7IGWovtWx0Onw=='

run_mocha(){
  mocha
}

run_server(){
  env \
    ENDO_GITHUB_OCTOBLU_CLIENT_ID="$OCTOBLU_CLIENT_ID" \
    ENDO_GITHUB_OCTOBLU_CLIENT_SECRET="$OCTOBLU_CLIENT_SECRET" \
    ENDO_GITHUB_OCTOBLU_OAUTH_URL="$OCTOBLU_OAUTH_URL" \
    ENDO_GITHUB_GITHUB_CLIENT_ID="$GITHUB_CLIENT_ID" \
    ENDO_GITHUB_GITHUB_CLIENT_SECRET="$GITHUB_CLIENT_SECRET"
    ENDO_GITHUB_SERVICE_URL="$SERVICE_URI" \
    MESHBLU_SERVER="meshblu.octoblu.com" \
    MESHBLU_PORT="443" \
    MESHBLU_PROTOCOL="https" \
    MESHBLU_PRIVATE_KEY="$MESHBLU_PRIVATE_KEY" \
    MESHBLU_UUID="$MESHBLU_UUID" \
    MESHBLU_TOKEN="$MESHBLU_TOKEN" \
    NODE_TLS_REJECT_UNAUTHORIZED="0" \
    npm start
}

run_yo(){
  local skip_install="$1"
  local args=""

  if [ "$skip_install" == "true" ]; then
    args+=" --skip_install "
  fi

  yo endo \
    --github-user octoblu \
    --force \
    "$args"
}

main(){
  local skip_install="$SKIP_INSTALL"

  run_yo "$skip_install" \
  && run_mocha \
  && run_server

}
main $@
