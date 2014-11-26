#script to copy image files from specific folders on the 'transport' volume and output the progress verbosely.

import os
import shutil

base_path = os.path.join('/','Volumes','transport','data','confocal')
experiments = ['050714','190714','260714']
backup = os.path.join('backup','backup')
output_path = os.path.join('/','Users','nicholaspiano','data','confocal')

