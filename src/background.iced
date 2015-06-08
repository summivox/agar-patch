require './xhr.js'
patch = require './patch.js'

utf8_to_b64 = (str) -> window.btoa unescape encodeURIComponent str
b64_to_utf8 = (str) -> decodeURIComponent escape window.atob str
getDataURI = (data) -> 'data:text/javascript;base64,' + utf8_to_b64(data)

interceptRequest = ({url}) ->
  # load script synchronously
  src = ''
  GM_xmlhttpRequest {
    async: false
    method: 'GET'
    url
    onload: (e) -> src = e.responseText
  }
  # patch 
  srcMod = patch src
  # return patched version
  redirectUrl: getDataURI srcMod

chrome.webRequest.onBeforeRequest.addListener(
  interceptRequest
  urls: ["*://agar.io/main_*.js*"]
  ["blocking"]
)
