#!/usr/bin/python3
# Copyright (c) 2019,2020 adamius.dev@gmail.com, MIT licensed
# regexes can do this. but why do it that way when you can demonstrate to the class a much longer way?!

import sys
import os
import zipfile
import tempfile
from collections import defaultdict

HEADER="-"*99
VERSION_HEADER_TEMPLATES = [HEADER+"\n",HEADER+"\r",HEADER+"\r\n"]

FIELDS="Version","Date"

zorro_mode=False
line_classification=[] # linenum, classification, linetext

def strip_crlf(line):
  return line.replace("\r","").replace("\n","")

def count_text(s,needle):
  count=0
  for c in s : 
    if c == needle:
      count +=1
  return count

deferredoutput=[]
def stderr_level_line(text):
  global deferredoutput
  deferredoutput.append(text)

def stderr_level_line_sort_rule(line):
  l_level = line.split(" ")[0]
  l_linenum = int(line.split(":")[0].split(" ")[3])
  return l_linenum+ord(l_level[0])/1000.

def get_stderr_level_line():
  global deferredoutput
  
  # no duplicate output messages
  unique = {}
  for line in deferredoutput:
    unique[line]=1
  deferredoutput=[]
  for line in unique :
    deferredoutput.append(line)  
  deferredoutput.sort(key=stderr_level_line_sort_rule)
  return "".join([x.replace("Line # 0 : ","") for x in deferredoutput])

from collections import Counter
counters=Counter()
linenum=0
def output(level,message,file=False,overridelinenum=None):
  global count_errors, count_warnings, count_info, linenum
  counters[level]+=1
  if level == "ZORRO":
    parts=message.split("|")
    classification = parts[0].strip()
    text = message[len(classification):]
    line_classification.append((linenum,classification,text))
  if zorro_mode :
    if file :
      stderr_level_line("%s Line # 0 : %s\n" % (level,message))
    else :
      if overridelinenum :
        stderr_level_line("%s Line # %05d : %s\n" % (level,overridelinenum,message))
      else :
        stderr_level_line("%s Line # %05d : %s\n" % (level,linenum,message))
  else :
    
    if level == "ZORRO":
      return
  
    if file :
      stderr_level_line("%s Line # 0 : %s\n" % (level,message))
    else :
      if overridelinenum :
        stderr_level_line("%s Line # %d : %s\n" % (level,overridelinenum,message))
      else :
        stderr_level_line("%s Line # %d : %s\n" % (level,linenum,message))

def best_guess(line):
  global counters
  if count_text(line,"-")>3:
    output("ERROR","header must contain 99 dashes")
    return
  if line.strip()==":":
    output("ERROR","category or field missing")
    return
  
  # end of the line, give up
  output("ERROR","Unrecognised line.")
  output("DATA",line.replace("\n",""))

def verify_category(line):
  global counters

  spaces=count_text(line[0:line.find(line.strip())]," ")
  if spaces != 2 :
    output("ERROR","category MUST have 2 spaces, eg '  Bugfixes:'")
  
  counters["expect_category"]-=1
  
  # any text after category on same line?
  parts=line.replace("\n","").replace("\r","").split(":")
  if parts[1]:
    if parts[1].strip():
      output("ERROR","category should not have anything after the colon.")
    else :
      output("ERROR","category should not have spaces after the colon.")
    
version_fields=[]
def verify_field(line):
  global counters
  global version_fields
  if line.lstrip() != line : 
    output("ERROR","Fields can't be indented.")
    
  if line.strip().startswith("Version:"):
    version_fields.append((linenum,line.strip()))
    if line.strip() in counters :
      output("ERROR","Can't have duplicate versions listed.")
    counters[line.strip()]+=1 # record this particular version
    parts = line.lstrip().replace("\r","").replace("\n","").split(":")
    
    if parts[1].startswith(" "):
      pass
    else :
      output("ERROR","Version: must have a space between the colon and the version specifier")
      
    if parts[1].strip():
      pass
    else :
      output("ERROR","No actual version specified.")
    counters["version_fields_found"]+=1  
    counters["expect_version_field"]-=1
    return
    
  if line.strip().startswith("Date:"):
    parts = line.strip().split(":")
    if parts[1].strip():
      pass
    else :
      output("ERROR","No actual date specified.")
    
  
def verify_item(line):
  spaces=count_text(line[0:line.find("-")]," ")
  if spaces < 4 or spaces==5:
    output("ERROR","item MUST have 4 spaces before its dash.")
  if line.strip()=="-":
    output("ERROR","item line contains no text after the dash")

def verify_continuation(line):
  if line.startswith("      "):
    pass
  else :
    if (len(line)-len(line.lstrip()))<6 :
      output("ERROR","Continuation lines MUST have at least 6 spaces before them.")


def verify_previous_version() :
  global counters
  
  if counters["got_header"]==0:
    if counters["expect_version_field"]<1 or counters["expect_field"]<1 or counters["expect_category"]<1 or counters["expect_item"]<1 :
      output("ERROR","a changelog MUST have a valid header",False,counters["previous_version_linenum"])
    return
  
  # make sure it had a Version field
  if counters["expect_version_field"]==1:
    output("ERROR","a change MUST have a version.",False,counters["previous_version_linenum"])
    return
  if counters["expect_version_field"]<0:
    if counters["previous_version_linenum"]!=1 :
      output("ERROR","a change MUST have only one version.",False,counters["previous_version_linenum"])
    return
  # make sure it had a category
  if counters["expect_category"]==1:
    output("ERROR","a change MUST have some category.",False,counters["previous_version_linenum"])
    return
  # make sure it had a item
  if counters["expect_item"]==1:
    output("ERROR","a change MUST have an item.",False,counters["previous_version_linenum"])
    return

  pass
  
numbers="1234567890"  

if False :
  def remove_numerics(t):
    def empty_if_numeric(c):
      if c in numbers :
        return ""
      else :
        return
    return "".join([empty_if_numeric(x) for x in t])

  def version_text_to_number(t):
    if not t :
      return 0
    # x -> 0
    # a -> 0
    # 1x -> 
    # 1a -> 
    changes=1
    s=t[:]
    
    # end of line text is ignored
    while changes==0:
      changes=0
      if s[-1] not in numbers :
        s=s[0:-1]
        changes+=1
    
    return int(s)

    
  def effective_version(t):
    print("--")
    print(t)
    v=[str(version_text_to_number(x)) for x in t.split(".")]
    return ".".join(v)

  print(effective_version("0.0.1"))
  print(effective_version("0.0.x"))
  print(effective_version("0.0.1x"))
  print(effective_version("0.x.1"))
  print(effective_version("0.1x.1"))
  print(effective_version("1.x.1"))
  print(effective_version("0x.x.1"))
  print(effective_version("x1.x.1"))
  print(effective_version("x0.x.1"))

def verify_discovered_version_numbers():
  global version_fields
  v=Counter()
  def emptylist(): return []
  duplicates=defaultdict(emptylist)
  
  # check the versions we've found
  for vf_linenum,vf_version in version_fields :
    #print(vf_linenum,vf_version)
    s=vf_version.replace("Version:","").strip()
    # find what is not numbers
    debris=s[:]
    scrub=numbers+". "
    for ch in scrub :
      debris=debris.replace(ch,"")
    if debris:
      output("INFO","Non-numeric version identifier found. Letters such as x will be interpreted by Factorio as zeroes in confusing ways.",False,vf_linenum)
    duplicates[vf_version].append(vf_linenum)
    
  # find duplicate versions
  for version in duplicates :
    if len(duplicates[version])>1:
      found = ", ".join(["%d" % x for x in duplicates[version]])
      for vf_linenum in duplicates[version]:
        output("INFO",version+" found in lines: %s" % found,False,vf_linenum)

def process_changelog_file(filepath,description=""):
  global counters,linenum
  global version_fields
  global deferredoutput
  global line_classification
  
  deferredoutput=[]
  version_fields=[]
  counters=Counter()
  linenum=1
  
  if description :
    sys.stderr.write("\nprocessing: %s\n  examining changelog at: %s\n" % (description,filepath))
  else:
    sys.stderr.write("\nprocessing: %s\n" % filepath)
  issues=0
  versions=[]
  try :
    f=open(filepath,"r")
  except : # TODO increase care factor. perhaps handle exceptions from open... more civilised.
    if os.path.isfile(filepath) :
      output("ERROR","Unable to open file",True)
      f=None
    if os.path.isdir(filepath):
      output("ERROR","Unable to open a folder",True)
      f=None
    output("WARNING","File not found",True)
    f=None
    
  if f: 
    within_item = False
    
    # predefine the "previous" version
    counters["got_header"]=0
    counters["expect_version_field"]=1
    counters["expect_field"]=1
    counters["expect_category"]=1
    counters["expect_item"]=1
    counters["previous_version_linenum"]=1
    
    for line in f:
          
      # classify the line
      if line == "" :
        output("ZORRO", "BLANK LINE    |"+strip_crlf(line))

      elif "\t" in line : ##### Tab characters in line
        output("ZORRO",   "ILLEGAL CHARS |"+strip_crlf(line))
        output("ERROR","No tab characters allowed.")

      elif strip_crlf(line)=="      ":
        if not within_item :
          output("ZORRO", "ITEM          |"+strip_crlf(line))
          output("ERROR", "Blank continuation line without a item before it")
        else:
          output("ZORRO", "BLANK LINE    |"+strip_crlf(line))
          
      elif line.strip() == "": ##### Empty line
        output("ZORRO",   "BLANK LINE    |"+strip_crlf(line))
        if " " in line :
          output("ERROR","empty lines MUST actually be empty (no spaces).")
        if counters["expect_version_field"]==1 :
          output("ERROR","empty lines can't occur before the Version: field.")
      
      elif line.strip()=="-" : ##### Item (defective line)
        output("ZORRO",   "ITEM          |"+strip_crlf(line))
        within_item = True # item
        verify_item(line)
        counters["expect_item"]-=1        
      
      elif line.strip().startswith("- ") : ##### Item
        output("ZORRO",   "ITEM          |"+strip_crlf(line))
        within_item = True # item
        verify_item(line)
        counters["expect_item"]-=1
        
      elif line.startswith("      ") and line.strip() and line.strip()[0]!="-" and line.strip()[-1]!=":":
        output("ZORRO",   "ITEM          |"+strip_crlf(line))
        if not within_item :
          output("ERROR","Continuation line without a item before it")
        verify_continuation(line)
      
      elif line.startswith(" ") and ":" in line: ##### Category
        within_item = False
        if line.strip().replace(":","") in FIELDS : # catch Version: or Date: as on line by themselves with no value after
          output("ZORRO", "FIELD         |"+strip_crlf(line))
          verify_field(line) 
        else :
          if line.startswith(" "): # catch category and verify
            output("ZORRO","CATEGORY      |"+strip_crlf(line))
            verify_category(line)
          else :
            output("ZORRO","FIELD         |"+strip_crlf(line))
            verify_field(line) # catch a non-listed field with no value
            
      elif ": " in line : ##### Field
        for fieldname in FIELDS :
          if line.strip().startswith(fieldname+":"):
            output("ZORRO","FIELD         |"+strip_crlf(line))
            verify_field(line)
            
      elif line in VERSION_HEADER_TEMPLATES: ##### header line for the version
        output("ZORRO","VERSION HEADER|"+strip_crlf(line))
        within_item = False # item
        verify_previous_version()
        counters["previous_version_linenum"]=linenum+1
        counters["got_header"]=1
        counters["expect_version_field"]=1
        counters["expect_field"]=1
        counters["expect_category"]=1
        counters["expect_item"]=1
        counters["change entries"]+=1
        
      elif line.startswith(" "): ##### Continuation line
        output("ZORRO","ITEM          |"+line.strip())
        verify_continuation(line)
          
      else :
        ##### catchall, this tool has no clue what to do with this line
        output("ZORRO","UNKNOWN       |"+line.strip())
        best_guess(line)
          
      linenum+=1
      
    verify_previous_version()

    if counters["change entries"]==0 :
      output("ERROR","No change entries found",True)
      
    if counters["version_fields_found"] != counters["change entries"] :
      output("WARNING","Number of Version fields does not match the number of dash separators",True)
      
    verify_discovered_version_numbers()
    
    
  # summarise
  sys.stderr.write(get_stderr_level_line())
  sys.stderr.write("Errors: %d, warnings: %d, information: %d\n" % (counters["ERROR"], counters["WARNING"], counters["INFO"]))
 
def process_zip_file(filepath):
  if not zipfile.is_zipfile(filepath):
    output("ERROR","Not actually a zip file",True)
    return
  try :
    folder_from_filename = os.path.split(filepath)[1].replace(".zip","").replace(".ZIP","")
    
  except :
    output("DEBUG","Unlikely error in process_zip_file")
    return
  
  # create a temp folder
  logtempfolder = tempfile.mkdtemp()
  
  with zipfile.ZipFile(filepath) as z:

    # try the root folder of the zip
    try :
      z.extract("changelog.txt",logtempfolder) 
      expandedfilepath=logtempfolder+os.sep+"changelog.txt"
    except KeyError :
      # open the subfolder with same name as zip and try again
      try :
        z.extract("%s/changelog.txt" % folder_from_filename,logtempfolder)
        expandedfilepath=logtempfolder+os.sep+folder_from_filename+os.sep+"changelog.txt"
      except KeyError:
        output("ERROR","Unable to find a changelog inside the ZIP file.",True)
        expandedfilepath=None
        
    if expandedfilepath :
      if os.path.isfile(expandedfilepath):
        process_changelog_file(expandedfilepath,filepath)
  
def process(filepath):
  extension = filepath.lower()
  
  # if its name is changelog.txt then
  if extension.endswith(".txt"):
    process_changelog_file(filepath)
    return
  
  if extension.endswith(".zip"):
    process_zip_file(filepath)
    return
    
  print(filepath,"+++out of cheese+++")
 
if __name__=="__main__":
  
  args = sys.argv[:]
  scriptname = args.pop(0)
  if len(scriptname.split(os.sep))>1:
    scriptname = os.path.split(scriptname)[1]
  if len(args)==0:
    args=["-h"]
    
  modfolderpath = ""
  filenames = []
  
  check_mods_folder = False
  check_individual_files = False
  
  while args :
    cmd = args.pop(0)
    if cmd == "--mods-folder":
      modfolderpath = args.pop(0)
      check_mods_folder = True
    elif cmd == "-f" or cmd == "--changelog":
      filenames.append(args.pop(0))
      check_individual_files=True
    elif cmd == "--zorro":
      zorro_mode=True
    elif cmd == "--help" or cmd == "-h":
      sys.stderr.write("\nchangelog-checker.py\nadamius 2019 https://mods.factorio.com/mod/da-changelog-tools \nMIT Licensed.\n\n")
      sys.stderr.write("%s [--mods-folder <folder path>] [--changelog <filepath>]\n\n" % scriptname)
      sys.stderr.write("--mods-folder <folder path>\n  scan a folder as if it contains multiple subfolders or zip files. each subfolder or zip has a single mod.\n\n")
      sys.stderr.write("--changelog\n  specify a particular filepath and treat is as a changelog.txt or a zipfile with a changelog.txt inside it.\n")
      sys.stderr.write("--zorro\n  show tool's line classification. Cuts to the question of why a particular message is appearing.\n")
      sys.stderr.write("\nMultiple --changelog pairs can be put on same command line to allow checking multiple individual files. eg --changelog mod1.zip --changelog mod2.zip\n")
      sys.stderr.write("-f is an alias for --changelog\n")
      sys.stderr.write("-h is an alias for --help\n")
      sys.exit(0)
    else :
      sys.stderr.write("unknown command: %s\n" % cmd)    
      sys.exit(1)
      
  if check_mods_folder :
    for name in os.listdir(modfolderpath):
      if os.path.isdir(modfolderpath+os.sep+name):
        process(modfolderpath+os.sep+name+os.sep+"changelog.txt")
      else :
        if name.lower().endswith(".zip") :
          process(modfolderpath+os.sep+name)

  # --changelog
  if check_individual_files :
    for filename in filenames :
      process(filename)
  
  