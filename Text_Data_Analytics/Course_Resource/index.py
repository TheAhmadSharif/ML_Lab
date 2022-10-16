import os
def gettextlist(directory_path):
	directory_textfiles=[]	
	directory_nontextfiles=[]	
	directory_nonfiles=[]
	directory_contents=os.listdir(directory_path)	
	for contentitem in directory_contents:
		temp_fullpath=os.path.join(directory_path, contentitem)
		if os.path.isfile(temp_fullpath)==0:
			directory_nonfiles.append(contentitem)
		else:
			if temp_fullpath.find('.txt')==-1:
				directory_nontextfiles.append(contentitem)
			else:
				directory_textfiles.append(contentitem)
	return(directory_textfiles,directory_nontextfiles,directory_nonfiles)
 