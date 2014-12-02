#download-archives.py

import re
import sys
import mechanize as mz
from optparse import OptionParser
import pprint
import shutil as sh
import os
import datetime as dt

'''
https://docs.python.org/2/library/htmlparser.html
http://wwwsearch.sourceforge.net/mechanize/

'''

#script to download archives from behind a password.

# <tr class="search_bg1 tdpanel" id="rows6">
#   <td align="center" valign="middle">
#     <a href="http://www.postmyfiles.com/voxgen/home.php?foId=2080"  class="link">
#       <img src="http://www.postmyfiles.com/images/folder.gif" alt="Folder" title="Folder" border="0"  />
#     </a>
#   </td>
#   <td align="center" valign="top">
#     <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
#   </td>
#   <td align="left" valign="middle" class="tabeltext2">
#     <a href="http://www.postmyfiles.com/voxgen/home.php?foId=2080"  class="text_product">On Hold 2013 - PCM Mono_3min Seg</a>
#   </td>
#   <td align="center" valign="top">
#     <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
#   </td>
#   <td width="50" align="left" valign="middle" class="tabeltext">15-02-2013</td>
#   <td width="1" align="center" valign="top"><img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" /></td>
#   <td align="left" valign="middle" class="tabeltext2">0 Dir(s),<br />1 File(s).</td>
#   <td width="1" align="center" valign="top">
#     <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
#   </td>
#   <td align="left" valign="middle" class="tabeltext2">37.2 MB</td>
#   <td width="1" align="center" valign="top">
#     <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
#   </td>
#   <td align="left" valign="middle" class="tabeltext2">
#     <a href="http://www.postmyfiles.com/voxgen/home.php?action=sharedoc&foId=2080" class="text_product">
#       <strong>Share</strong>
#     </a>
#   </td>
#   <td width="1" align="center" valign="top">
#     <img src="http://www.postmyfiles.com/images/line_icon2.gif" width="1" height="35" />
#   </td>


def main(options):

  start = dt.datetime.now()
  print('start: ' + str(start))

  base_path = os.path.join('/','Users','nicholaspiano','code','scripts','download-archives','data')
  if not os.path.isdir(base_path):
    os.mkdir(base_path)
  if not os.path.isdir(os.path.join(base_path, options.root)):
    os.mkdir(os.path.join(base_path, options.root))

  #get browser
  b = mz.Browser()

  #base_url
  base_url = 'http://www.postmyfiles.com/voxgen/login_panel.php'
  b.open(base_url)
  b.select_form(name='login')
  b["userName"] = "sdg"
  b["userPass"] = options.password
  b.submit()

  #tuning folder
  b.follow_link(text_regex=options.root, nr=0)

  #table
  rx = re.compile(r'http://www\.postmyfiles\.com/download_file\.php\?fileid=(?P<id>[0-9]+)')
  rev = 'http://www.postmyfiles.com/download_file.php?fileid=%d'

  links = []
  for link in b.links(url_regex='foId'):
    attr_dict = {a[0]:a[1] for a in link.attrs}
    if 'class' in attr_dict and attr_dict['class'] == 'text_product' and 'share' not in link.url:
      if link.url not in [l.url for l in links]:
        links.append(link)

  archive_links = {}
  for link in links:
    b.open(link.url)
    if link.text not in archive_links:
      archive_links[link.text] = []

      for sub_link in b.links(url_regex='fileid'):
        attr_dict = {a[0]:a[1] for a in sub_link.attrs}
        if 'class' in attr_dict and attr_dict['class'] == 'text_product' and 'share' not in sub_link.url:
          if sub_link.url not in [l.url for l in archive_links[link.text]]:
            archive_links[link.text].append(sub_link)

  for link in archive_links:
    #create folder for download
    if not os.path.isdir(os.path.join(base_path, options.root, link)):
      os.mkdir(os.path.join(base_path, options.root, link))

    #loop through files
    for archive in archive_links[link]:
      if not os.path.exists(os.path.join(base_path, link, archive.text)):
        print([options.root, link, archive.text, 'time: ', dt.datetime.now()-start])
        b.retrieve(archive.url, os.path.join(base_path, options.root, link, archive.text))

  end = dt.datetime.now()
  duration = end - start
  print([end, duration])

if __name__ == "__main__":
  parser = OptionParser()
  parser.add_option("-p", "--password", dest="password")
  parser.add_option("-r", "--root", dest="root")
  (options, args) = parser.parse_args()
  main(options)
