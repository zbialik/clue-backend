

old = open('log.tf','r')
Lines = old.readlines()

with open('main-brand-new.tf', 'w') as the_file:
    for line in Lines:
        if not line[29:].isspace():
            the_file.write(line[29:])