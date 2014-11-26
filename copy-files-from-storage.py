#script to copy image files from specific folders on the 'transport' volume and output the progress verbosely.

import os
import shutil

base_path = os.path.join('/','Volumes','transport','data','confocal')
experiments = ['050714','190714','260714']
backup = os.path.join('backup','backup')
output_path = os.path.join('/','Users','nicholaspiano','data','confocal')

for experiment in experiments:
  from_path = os.path.join(base_path, experiment, backup)
  to_path = os.path.join(output_path, experiment, backup)
  file_list = os.listdir(from_path)

  #make directories
  os.makedirs(to_path)

  for i, file_name in enumerate(file_list):

    #paths
    full_from_path = os.path.join(from_path, file_name)
    full_to_path = os.path.join(to_path, file_name)
    print([experiment, '%d of %d'%(i+1, len(file_list)), full_from_path + ' -> ' + full_to_path])

    #copy
    shutil.copy2(full_from_path, full_to_path)
