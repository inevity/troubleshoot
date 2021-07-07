Capture_Script_Version_080919

LSI HBA/MegaRAID/Expander Data collection script for Linux, FreeBSD, and VMWare.
This script will collect system logs and info as well as controller, disk and
enclosure info for debugging purposes. All files included in the original
lsigetlinix_xxxxxx.tgz file MUST be kept in the same subdir as lsigetlinix.sh.
You MUST have root access rights to run this script, su/sudo/root/. The
latest version of this script as well as information on what data can be collected manually
can be found at:

https://www.broadcom.com/support/knowledgebase/1211161499563/lsiget-data-capture-script


Known Changes and Issues
Updated Software Management Tools used during Data Collection
Added support for MegaRAID Snapdump commands
Added support for IOC/HBA Host Trace Buffer Support for 94XX HBAs using PH11 firmware or newer
Added support for pl stats all, sg_readcap
Removed storcli legacy syntax
Removed -E_RB switch as this conflicts with Host Trace Buffer support in PH11 firmware
Made batch mode the default
Added Expander 6Gb Log Collection. 
When the script starts, User will see Fatal mptctl errors in Fedora. This can be ignored.
If the exact options are used in the comment quotes, these will get picked up by the script.
In FreeBSD, the -EXT is the default.


Command Line Options:
lsiget [Comment] [Option(s)]
Option:
-UMS		= Use MegaCli Syntax in addition to native storcli syntax.
-EXT		= EXTRACT - Extracts all available utilities for use.
-P		= PRINT filename in .\LSICAPTUREFILES.TXT for scripting.
-PT            	= Append the PRINTED filename of the lsiget output file with TRIGGERED, used to differentiate automated captures.
-D		= Working DIRECTORY is not deleted.
-Q		= QUIET Mode - No keystrokes required unless error.
-B		= BATCH Mode - No keystrokes required.
 ##### Batch mode is the default with the 080919 version ######
 ##### To change from batch mode and have the script wait for user input when done remove the line with TWGETBATCHMODE=BATCH 	
-E_SAS2LOG     	= ENABLE ALL SAS2 HBA Driver Logging, Option ffffffh. HUGE /var/log/messages file size! (Linux Only)
-E_SAS2LOG1    	= ENABLE some SAS2 HBA Driver Logging, Option 3f8h. Very Large /var/log/messages file size! (Linux Only)
-E_SAS3LOG     	= ENABLE ALL AS3 HBA Driver Logging, Option ffffffh. HUGE /var/log/messages file size! (Linux Only)
-E_SAS3LOG1    	= ENABLE some SAS3 HBA Driver Logging, Option 3f8h. Very Large /var/log/messages file size! (Linux Only)
-D_SAS2LOG     	= Disables ALL SAS2 HBA Driver Logging, Option 000000h (Default). (Linux Only)
-D_SAS3LOG     	= Disables ALL SAS3 HBA Driver Logging, Option 000000h (Default). (Linux Only)
-MRWA          	= MegaRAID Work Around - Limit commands for compatibility issues with old code // Not Tested //
-H		= This Help Screen.

The following command line options are NOT standard and may be detrimental
to a root cause analysis of your issue. Used for repetitive data collection
and script debugging, these are fluid and may change.  These switches are not tested.

RS		= Skip MegaRAID AEN Record Sort, NOT standard.
-SRC		= Skip MegaRAID AEN Record Capture and Sort, NOT standard.
-SMR		= Skip MegaRAID DATA Capture, NOT standard.
-SHBA		= Skip HBA DATA Capture, NOT standard.
-SEXP		= Skip Expander DATA Capture, NOT standard.
-SC		= Skip Compression of output subdirectory, NOT standard.  

EXAMPLES
Example ./lsigetlunix.sh -D -Q "This is my comment"
Runs the standard script leaving the working directory, without prompts
and leaves a comment.

Example ./lsigetlunix.sh -Q "This is my comment" -D -M
Runs the standard script leaving the working directory, without prompts
and leaves a comment, once done the script stays resident in Monitor Mode.

Notes:
Send just the created .tar.gz file as is to your support rep.

Please note that using LSIUtil to collect ringbuffer with -E_RB or similar
flag is no longer supported as of this version.  Please work with your
FAE or support person for instructions on how to obtain the ring buffer with
Scrutiny, or use older LSIGet.  This version of lsiget WILL automaticall
collect RB from 9400 and later controllers that have => phase 11 driver and fw.
	
-E_SASxLOG = This sets the HBA Driver logging level, -E_SAS2LOG is for all
SAS2 HBAs and -E_SAS3LOG is for all SAS3 HBAs. This is VERY VERBOSE!

All of the -E/D options can only be used alone.

If there are competing comments the lowest variable number wins.
If there are contradictory options the lowest variable number with the
option order listed in the help wins. Valid combinations would be;
-D or -D with -B or -Q any -E_* option by itself or in conjunction
with a -D and -B/-Q option. -E_* is allowed with -D but has no effect as
there is no working directory created.


Trouble Shooting Script Issues -

I. Ubuntu 9.04
sudo ./lsigetlunix.sh -D -Q
Tue Sep 22 17:06:32 PDT 2009
export: 3: 22: bad variable name

Run;
sudo bash ./lsigetlunix.sh -D -Q

II. Script hangs with MegaRAID Controller

If you are positive the script is hung, CTRL-C the process, wait 3 minutes.
If the prompt doesn't come back kill the term window, do a ps -ea, note the
# of any lsigetlunix.sh or MegaCli(64) processes. Do a kill -9 process-number
for each process. If any can't be killed, wait 3 minutes, there is a 180 second
timeout on MegaCli. Upgrade your driver/fw/capture script to the latest version and
try again. If you cant upgrade or if you still have problems try the -MRWA switch.
If you still have problems manually zip the subdirectory structure and 
email it to your support rep.

Recommended Code Set/Release Versions

MegaRAID -

This script should run with any 92xx, 93xx, 94xx controllers.

HBA -

This script should run with any 92xx, 93xx, 94xx HBAs.

Capture Script Version: 080919

