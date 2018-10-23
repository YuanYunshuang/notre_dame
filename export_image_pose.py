

import os
import argparse
import sqlite3
import numpy as np
import sys
from struct import *



IS_PYTHON3 = sys.version_info[0] >= 3



def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--database_path", default="./database.db")
    parser.add_argument("--output_path", default="./image_poses.txt")
    parser.add_argument("--min_num_matches", type=int, default=15)
    args = parser.parse_args()
    return args


def pair_id_to_image_ids(pair_id):
    image_id2 = pair_id % 2147483647
    image_id1 = (pair_id - image_id2) / 2147483647
    return image_id1, image_id2

def blob_to_array(blob, dtype, shape=(-1,)):
    if IS_PYTHON3:
        return np.fromstring(blob, dtype=dtype).reshape(*shape)
    else:
        return np.frombuffer(blob, dtype=dtype).reshape(*shape)



def main():
    args = parse_args()

    connection = sqlite3.connect(args.database_path)
    cursor = connection.cursor()

####################### Read image data #############################		
    cursor.execute("SELECT image_id, camera_id, name FROM images;")
    poses = {}
    images = {}
    for row in cursor:
        image_id = row[0]
        camera_id = row[1]
        image_name = row[2]
        poses[image_id] = camera_id
        images[image_id] = image_name

####################### Read camera data#############################
    cameras = {}
    cursor.execute("SELECT * FROM cameras;")
    for row in cursor:
        cam_id, model,width, height, params, pri_f = row
        cameras[cam_id] = row

    cursor.close()
    connection.close()


    with open(os.path.join(args.output_path), "w") as fid:
        for im_id in images.iterkeys():
            fid.write("===========================================================\n" )			
            fid.write("Image_id:%d name:%s camera_id:%d\n"\
                % (im_id, images[im_id],poses[im_id]))
            fid.write("===========================================================\n" )	
            cam_id, model,width, height, params, pri_f = cameras[poses[im_id]]
            params = blob_to_array(params, np.float64)
            fid.write("model: %s\n" % (model))			
            fid.write("width: %d\n" % (width))
            fid.write("height: %d\n" % (height))
            fid.write("parameters: %f, %f, %f, %f \n" % tuple(params))



if __name__ == "__main__":
    main()
