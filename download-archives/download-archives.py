#download-archives.py

import re
import sys
import mechanize as mz
from optparse import OptionParser
from HTMLParser import HTMLParser

'''
https://docs.python.org/2/library/htmlparser.html
http://wwwsearch.sourceforge.net/mechanize/

'''

#script to download archives from behind a password.


<tr class="search_bg1 tdpanel" id="rows6">
  <td align="center" valign="middle">
    <a href="http://www.postmyfiles.com/voxgen/home.php?foId=2080"  class="link">
      <img src="http://www.postmyfiles.com/images/folder.gif" alt="Folder" title="Folder" border="0"  />
    </a>
  </td>
  <td align="center" valign="top">
    <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
  </td>
  <td align="left" valign="middle" class="tabeltext2">
    <a href="http://www.postmyfiles.com/voxgen/home.php?foId=2080"  class="text_product">On Hold 2013 - PCM Mono_3min Seg</a>
  </td>
  <td align="center" valign="top">
    <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
  </td>
  <td width="50" align="left" valign="middle" class="tabeltext">15-02-2013</td>
  <td width="1" align="center" valign="top"><img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" /></td>
  <td align="left" valign="middle" class="tabeltext2">0 Dir(s),<br />1 File(s).</td>
  <td width="1" align="center" valign="top">
    <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
  </td>
  <td align="left" valign="middle" class="tabeltext2">37.2 MB</td>
  <td width="1" align="center" valign="top">
    <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
  </td>
  <td align="left" valign="middle" class="tabeltext2">
    <a href="http://www.postmyfiles.com/voxgen/home.php?action=sharedoc&foId=2080" class="text_product">
      <strong>Share</strong>
    </a>
  </td>
  <td width="1" align="center" valign="top">
    <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
  </td>

def main(options):
  #get browser
  b = mz.Browser()

  #base_url
  base_url = 'http://www.postmyfiles.com/voxgen/login_panel.php'
  b.open(base_url)
  b.select_form(name='login')
  b["userName"] = "sdg"
  b["userPass"] = options.password
  b.submit()
  base_folder_url = 'http://www.postmyfiles.com/voxgen/home.php?foId=2609'
  base_response = b.open(base_folder_url)

  ht = Ht()
  ht.feed(base_response.read())

  #past login, navigate to folder



if __name__ == "__main__":
  parser = OptionParser()
  parser.add_option("-p", "--password", dest="password")
  (options, args) = parser.parse_args()
  main(options)
