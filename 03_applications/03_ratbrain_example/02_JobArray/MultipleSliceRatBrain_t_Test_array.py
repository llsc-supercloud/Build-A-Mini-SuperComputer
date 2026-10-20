# imports
import os, math, numpy as np, time
import matplotlib.pyplot as plt
import sys
import time
start_time = time.monotonic()

def read_lines_iterative(fileID):
    lines = []
    try:
        with open(fileID, 'r') as file:
            for line in file:
                # Optional: strip whitespace, including the newline character
                lines.append(line.strip())
    except FileNotFoundError:
        print(f"Error: The file {filename} was not found.")
    return lines

# set the paths to the data and read in the file listing all the jobs to run
dataDir = "../mri_data"
dataSubDir = "../mri_data/results"
dataImgDir = "../mri_data/images"
batch_run = 'MultipleSlices.txt'
filename = os.path.join(dataDir, batch_run)
#print(filename)
all_lines = read_lines_iterative(filename)
#for i in range(len(all_lines)):
#    print(all_lines[i])
#print("end of print lines")

# Grab the arguments that are passed in
my_task_id = int(sys.argv[1])
num_tasks = int(sys.argv[2])

# Assign indices to this process/task
all_idx = range(len(all_lines))
my_idx = all_idx[my_task_id:len(all_idx):num_tasks]

for ijk in my_idx:
    lin_e = all_lines[ijk]
    filename = os.path.join(dataDir, lin_e)
    with open(filename,'r') as f:
        print(filename)
        fileOut = filename + 'out'
        nr = 0
        nc = 0
        nt = 0
        nRows = 256
        nCols = 256
        nTime = 50
        data = np.zeros((256,256,50))
        elements = np.zeros((256*50,256))
        k = 0
        for line in f:
            elements[k,:] = line.strip().split()
            k = k+1
        k = 0
        for nt in range(nTime):
            for nr in range(nRows):
                data[nr, :, nt] = elements[k, :]
                k = k + 1

        # Get the average and standard deviation for the rows and columns through the
        #  two time periods - the control period and the post stimulus period
        sample_count = 15
        onset = 30
        start_index = onset-sample_count
        end_index = onset-1
        pre_matrix = data[:,:,start_index:end_index]
        avg_pre = np.mean(pre_matrix,axis=2)
        std_pre = np.std(pre_matrix,axis=2)

        start_index = onset+1
        end_index = onset+sample_count
        post_matrix = data[:,:,start_index:end_index]
        avg_post = np.mean(post_matrix,axis=2)
        std_post = np.std(post_matrix,axis=2)

        # now create the t-test for each row by column entry
        # since both pre and post onset have the same size
        #  we can use square-root ((std_Pre^2 + std_post^2)/2) * sqrt(2/sample_size)
        var_pre = np.square(std_pre)
        var_post = std_post*std_post
        # in case the standard deviation combinations approaches zero
        sp = np.sqrt( (var_pre+var_post)/2)
        threshold = .01
        sp[sp < threshold] = threshold

        t_stat = (avg_pre - avg_post)/(sp*np.sqrt(2/sample_count))

        # replace any location with 255 (for grayscale imaging) if the t_test was significant
        threshold = 5
        replacement_value = 0
        t_stat[np.abs(t_stat) < threshold] = replacement_value
        replacement_value = 255
        t_stat[np.abs(t_stat) > threshold] = replacement_value

        img_output = np.zeros((256,256))
        for nr in range(nRows):
            img_output[nr,:] = data[:,nr,0] + t_stat[nr,:]

        tjms01 = fileOut
        outf = os.path.basename(fileOut).split('.')[0]
        tjms01 = outf + '.out'
        tjms01 = os.path.join(dataSubDir, tjms01)
        np.savetxt(tjms01,img_output,fmt='%.4d')
        tjms_before = outf + '.pre'
        tjms_before = os.path.join(dataSubDir, tjms_before)
        np.savetxt(tjms_before,avg_pre,fmt='%.4d')
        tjms_post = outf + '.post'
        tjms_post = os.path.join(dataSubDir, tjms_post)
        np.savetxt(tjms_post,avg_post,fmt='%.4d')
        
end_time = time.monotonic()
elapsed_seconds = end_time - start_time
print(f"Job took {elapsed_seconds:.2f} seconds")

