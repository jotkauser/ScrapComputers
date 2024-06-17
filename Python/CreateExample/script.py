# Read the data.lua file.
with open("input.lua", "r") as f:
    # Read it
    data = f.read()
    
    # Do converstions. \n = \\n, \t = \\t, \\\"
    data = data.replace("\n","\\n").replace("\t", "\\t").replace("\"", "\\\"").replace("    ", "\\t")
    
    # Write the converted data to output.txt
    with open("output.txt", "w") as ff:
        ff.write(data)