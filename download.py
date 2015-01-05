import youtube_dl

urls = []
ydl_opts = {}

#open file with links to download
filename = 'links_to_download.rtf'
with open(filename) as links_to_download:
  lines = links_to_download.readlines()
  for line in lines:
    urls.append(line.rstrip())

with youtube_dl.YoutubeDL(ydl_opts) as ydl:
  ydl.download(urls)
