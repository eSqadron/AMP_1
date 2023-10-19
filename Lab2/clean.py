import os
directory = 'z_adaptacja_data'

for filename in os.listdir(directory):
    f_p = os.path.join(directory, filename)
    if os.path.isfile(f_p):
        with open(f_p, "r+") as f:
            new_file = []
            for line in f.readlines():
                if(line[0] != '*'):
                    new_file.append(line)
                if("Freq(Hz), SPL(dB), Phase(degrees)" in line):
                    new_file.append(line[2:])
            f.seek(0)
            f.truncate()
            f.writelines(new_file)