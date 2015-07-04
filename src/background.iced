require './xhr.js'
patch = require './patch.js'
HP = require 'htmlparser'

utf8_to_b64 = (str) -> window.btoa unescape encodeURIComponent str
b64_to_utf8 = (str) -> decodeURIComponent escape window.atob str
getDataURI = (data) -> 'data:text/html;base64,' + utf8_to_b64(data)

interceptRequest = ({url}) ->
  # load main HTML synchronously
  html = null
  GM_xmlhttpRequest {
    async: false
    method: 'GET'
    url
    onload: (e) -> html = e.responseText
  }
  # parse
  dom = null
  parser = new HP.Parser new HP.DefaultHandler (err, d) -> dom = d
  parser.parseComplete html
  head = dom.filter((x)->x.name=='html')[0].children.filter((x)->x.name=='head')[0].children
  # find script
  src = null
  for x in head
    if x.type == 'script'
      s = x.children?[0]?.raw
      if s?.length > 1000
        src = s
  # patch script
  srcMod = patch src
  # patch html
  htmlMod = html.replace(src, srcMod)
  htmlMod = """
  <script src="https://code.jquery.com/jquery-2.1.4.min.js"></script>
  #{htmlMod}
  """
  console.log getDataURI(htmlMod).length
  # return patched version
  redirectUrl: getDataURI htmlMod
  #redirectUrl: url #TEST

chrome.webRequest.onBeforeRequest.addListener(
  interceptRequest
  urls: ["*://agar.io/"]
  ["blocking"]
)
