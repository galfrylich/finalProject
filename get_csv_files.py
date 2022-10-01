import pysftp
import os
from dotenv import load_dotenv
import sys
load_dotenv()


Hostname = os.environ.get('REMOTE_IP')
Username = os.environ.get('REMOT_UNAME')
Password = os.environ.get('REMOT_PASS')
path1 = os.environ.get('DIR_PATH')


def file_transfer():
    try:
        with pysftp.Connection(host=Hostname, username=Username, password=Password) as sftp:
            print("Connection successfully established ... ")
            # Switch to a remote directory
            #remote_dir = sftp.cwd('/var/tmp/csv_files')
            local_dir = path1
            # Obtain structure of the remote directory
            directory_structure = sftp.listdir_attr()
            for file in directory_structure:
                if not os.path.exists(os.path.join(local_dir, file.filename)):
                    remote_path = "/var/tmp/csv_files" + '/' + file.filename
                    local_path = os.path.join(local_dir, file.filename)
                    sftp.get(remote_path, local_path)
            sftp.close()
    except:
        e = sys.exc_info()
        print(e)  

            
    
    
    
    
    
    
  
    