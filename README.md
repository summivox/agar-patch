# SO AGAR.IO IMPLEMENTED MOUSE WHEEL ZOOM IN -- which made this plugin stop working

## which is not my fault, because this is what always happens when you make userscripts -- THE AUTHOR SCREWS YOU

### more on this rant: until I find out (or someone so kind to suggest me) a way to get around a technical difficulty, the plugin is PULLED DOWN FROM CHROME STORE to avoid jerks giving trashing reviews.

 
# The technical difficulty: 

So `agar.io` now dumps the main script (which I want to patch) into the main page (which I *cannot* change). How on earth do you change a HTML file before Chrome parses and executes it? I used to replace the separate main script file using Chrome's [WebRequest][https://developer.chrome.com/extensions/webRequest#type-BlockingResponse] API to my own patched version using Data URI's, but this 

I already figured out what changes to make to the main script.
Someone help me get the "change the HTML file" part done and we could keep using this plugin.
Before that, my 
