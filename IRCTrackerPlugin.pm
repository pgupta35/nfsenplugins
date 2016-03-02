#!/usr/bin/perl
#
#  Copyright (c) 2004, SWITCH - Teleinformatikdienste fuer Lehre und Forschung
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions are met:
#
#   * Redistributions of source code must retain the above copyright notice,
#     this list of conditions and the following disclaimer.
#   * Redistributions in binary form must reproduce the above copyright notice,
#     this list of conditions and the following disclaimer in the documentation
#     and/or other materials provided with the distribution.
#   * Neither the name of SWITCH nor the names of its contributors may be
#     used to endorse or promote products derived from this software without
#     specific prior written permission.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
#  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
#  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
#  POSSIBILITY OF SUCH DAMAGE.
#
#  $Author: sghill $
#
#  $Id: IRCTrackerPlugin.pm 27 2010-04-20 13:50:06Z sghill $
#
#  $LastChangedRevision: 27 $

# IRCTracker plugin for NfSen

# Name of the plugin
package IRCTrackerPlugin;

use strict;
use NfProfile;
use NfConf;

#
# The plugin may send any messages to syslog
# Do not initialize syslog, as this is done by 
# the main process nfsen-run
use Sys::Syslog;
Sys::Syslog::setlogsock('unix');
  
our %cmd_lookup = (
#	'try'	=> \&RunProc,
	'try'   => \&run,
);

# This string identifies the plugin as a version 1.3.0 plugin. 
our $VERSION = 130;

my $EODATA 	= ".\n";

my ( $nfdump, $PROFILEDIR );
#
# Define a nice filter: 
# We like to see flows containing more than 500000 packets
my $nf_filter = 'not (dst net 151.102.0.0/16 or dst net 117.0.0.0/8) and (dst port > 6660 and dst port < 6670)';

sub RunProc {
#	my $socket  = shift;	# scalar
#	my $opts	= shift;	# reference to a hash
#	my $profile = 'live';
 #       my $timeslot = '200909010005';
#	my $netflow_sources = '/flows/nfsen/profiles-data/live/router1';

	# error checking example
#	if ( !exists $$opts{'colours'} ) {
#		Nfcomm::socket_send_error($socket, "Missing value");
#		return;
#	}

#	 syslog('debug', "IRCTrackerPlugin args: '$netflow_sources'");

#	  my @output = `$nfdump -M $netflow_sources -r nfcapd.$timeslot '$nf_filter'`;

	 # Process the output and notify the duty team
 #  	 my ($matched) = $output[-4] =~ /Summary: total flows: (\d+)/;

  #	  if ( defined $matched ) {
   #     	syslog('debug', "IRCTrackerPlugin run: $matched aggregated flows");
    #	} else {
     #   	syslog('err', "IRCTrackerPlugin: Unparsable output line '$output[-4]'");
 #   	}
#
         # define your return string
  #      my %args;
   #     $args{'output'} = \@output;
    #    Nfcomm::socket_send_ok($socket, \%args);


	# Prepare answer
	#my %args;
	#$args{'string'} = "Greetings from backend plugin. Got colour values: '$colour1' and '$colour2'";
	#$args{'othercolours'} = \@othercolours;

	#N#fcomm::socket_send_ok($socket, \%args);

} # End of RunProc

#
# Periodic data processing function
#	input:	hash reference including the items:
#			'profile'		profile name
#			'profilegroup'	profile group
#			'timeslot' 		time of slot to process: Format yyyymmddHHMM e.g. 200503031200
sub run {

	my $socket = shift;
	my $argref 		 = shift;
	my $profile = 'live';
	my $timeslot = '200909011155'; 
#	my $profile 	 = $$argref{'profile'};
#	my $profilegroup = $$argref{'profilegroup'};
#	my $timeslot 	 = $$argref{'timeslot'};
	 my $netflow_sources = '/flows/nfsen/profiles-data/live/router1';

#	syslog('debug', "IRCTrackerPlugin run: Profilegroup: $profilegroup, Profile: $profile, Time: $timeslot");

#	my %profileinfo     = NfProfile::ReadProfile($profile, $profilegroup);
#	my $profilepath 	= NfProfile::ProfilePath($profile, $profilegroup);
#	my $all_sources		= join ':', keys %{$profileinfo{'channel'}};
	#my $netflow_sources = "$PROFILEDIR/$profilepath/$all_sources";

	syslog('debug', "IRCTrackerPlugin args: '$netflow_sources'");
 	#return; // added to end

	# 
	# process all sources of this profile at once
	my @output = `$nfdump -M $netflow_sources -r nfcapd.$timeslot -n 25 -s srcip/bytes '$nf_filter'`;
	
	#
    # Process the output and notify the duty team
    my ($matched) = $output[-4] =~ /Summary: total flows: (\d+)/;

    if ( defined $matched ) {
        syslog('debug', "IRCTrackerPlugin run: $matched aggregated flows");
    } else {
        syslog('err', "IRCTrackerPlugin: Unparsable output line '$output[-4]'");
    }

	my %args;
         # define your return string
	$args{'output'} = \@output;
        Nfcomm::socket_send_ok($socket, \%args);


#	return 1;
}

# The Init function is called when the plugin is loaded. It's purpose is to give the plugin 
# the possibility to initialize itself. The plugin should return 1 for success or 0 for 
# failure. If the plugin fails to initialize, it's disabled and not used. Therefore, if
# you want to temporarily disable your plugin return 0 when Init is called.
#
sub Init {
	syslog("info", "demoplugin: Init");

	# Init some vars
	$nfdump  = "$NfConf::PREFIX/nfdump";
	$PROFILEDIR = "$NfConf::PROFILEDATADIR";

	return 1;
}

#
# The Cleanup function is called, when nfsend terminates. It's purpose is to give the
# plugin the possibility to cleanup itself. It's return value is discard.
sub Cleanup {
	syslog("info", "IRCTrackerPlugin Cleanup");
	# not used here
}

1;
