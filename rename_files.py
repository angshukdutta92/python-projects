import os,string

def rename_files():
    #1) get all the file names from a folder
    file_list=os.listdir(r"F:\competetive coding\python_programming\prank")
    print file_list
    saved_path=os.getcwd();
    os.chdir(r"F:\competetive coding\python_programming\prank")    

    #2)for each file , rename file
    for file_name in file_list:
        os.rename(file_name,file_name.translate(None,"0123456789"))
    os.chdir(saved_path);
rename_files()
    
