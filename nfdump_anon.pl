#!/usr/bin/perl

# ===============================
# @AUTHOR:  Erik Decker
# ================================
# This program will take flow information from nfdump and use nfdump's native 
# crypto functionality to anonimize the flow data so it can be shared with others.
# The anonmizer function only anonimizes the IP information, and does it consistently
# using CryptoPan().  This way your patterns will still be valid, but without identifiable
# IP information.
# =================================
# YOU MUST ENTER A CRYPTOKEY TO USE IN MY $CRYPTOKEY1	


use strict;
use File::Find;
use File::Path;

($#ARGV == 1) or die "Usage: ARG1 -  [src_directory], ARG2 -  [target_directory] for NFDUMP -K to execute\n";


# define your cryptokey.
my $cryptoKey1="<insert a 32 digit string here>";

# set the location of your NFDUMP bin file
my $nfdump="/foo/bar/bin/nfdump";

# create the target directory and display the error if this cannot be done

eval { mkpath($ARGV[1],1,0777)};
        if ($@) {
                print "Could created $ARGV[1]:  $@";
        }

# process the directory, run the anonimizer against all 'nfcap' files and place in root of target directory

sub process_file {

        if (/^nfcap/) {
                system("$nfdump", "-r","$_","-K","$cryptoKey1","-w","$ARGV[1]/$_");
        }

        # check to see if there was an error - if so give us some details of what that is.
        if ($? == -1 ) {
                print "command failed:  $!\n";
        }

        # tell us the status of the command that executed properly
        else {
                printf "command exited with value %d\n", $? >> 8;
        }
}

# execute the NFDUMP replacement command against the your directory.
find(\&process_file, $ARGV[0]);

exit;

