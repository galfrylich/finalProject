import csv
import pysftp
import os
from dotenv import load_dotenv
import sys
load_dotenv()



""" 
    connecting to server with sftp connection, to transfer all csv files
    return all csv file names. 

"""

def file_transfer():
   # try:
        cnopts = pysftp.CnOpts()
        cnopts.hostkeys = None
        with pysftp.Connection(host=os.environ.get('REMOTE_IP'), username=os.environ.get('REMOT_UNAME'), password=os.environ.get('REMOT_PASS'),
    cnopts=cnopts,port=22) as sftp:
            print("Connection successfully established ... ")
            # Switch to a remote directory
            sftp.cwd('/var/tmp/csv_files')
            local_dir = os.environ.get('DIR_PATH')
            # Obtain structure of the remote directory
            csv_files = []
            directory_structure = sftp.listdir_attr()
            for file in directory_structure:
                #if not os.path.exists(os.path.join(local_dir, file.filename)):
                    remote_path = "/var/tmp/csv_files" + '/' + file.filename
                    local_path = os.path.join("/app/csv_files", file.filename)
                    csv_files.append(file.filename)
                    sftp.get(remote_path, local_path)
            sftp.close()
    #except:
       # e = sys.exc_info()
        #print(e)  
    
        return csv_files


      