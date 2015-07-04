# SO AGAR.IO IMPLEMENTED MOUSE WHEEL ZOOM IN -- which made this plugin stop working

## which is not my fault, because this is what always happens when you make userscripts -- THE AUTHOR SCREWS YOU

### more on this rant: until I find out (or someone so kind to suggest me) a way to get around a technical difficulty, the plugin is PULLED DOWN FROM CHROME STORE to avoid jerks giving trashing reviews.

 
# The technical difficulty: 

I used to replace the **separate main script file** using Chrome's [WebRequest](https://developer.chrome.com/extensions/webRequest#type-BlockingResponse) API to my own patched version using Data URI's, but `agar.io` now dumps the main script (which I want to patch) into the main HTML page (which I *cannot* change using this method).

I already figured out what (new) changes to make to the main script.

I just need to know how to modify the HTML file before Chrome parses it.
