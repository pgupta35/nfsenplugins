# Introduction #

This page contains a few points that will be necessary when installing NFSEN for plugin development and testing.

# Details #

**NFSEN installation**
  * you MUST install NFSEN all through compiling source code.  Be prepared to spend a few hours dealing with dependency hell.
  * use the list at http://www.honeynor.no/sharewiki/index.php/Nfsen
  * NFSEN has not been kept up so only a certain RRDTOOL version is supported with NFSEN version 1.3.  We had to use version rrdtool-1.2.30.
    * to compile rrdtool we used the following syntax:  ./configure --enable-perl-site-install -prefix=/usr/local/rrdtool-1.2.30/ -disable-tcl
    * Although this guide will get you most of the way there... it won't get you ALL the way there.  You need to install a bunch of perl modules via CPAN.

**Little known issues with NFSEN and plugins**
  * your nfsen.comm file needs to be readable by the NFSEN application.  This user account can be found within the nfsen.conf file.  If you get a "**ERROR: nfsend connect() error: Permission denied!**" page, this is because NFSEN cannot read the nfsen.comm socket file.
    * refer to http://code.google.com/p/installnfsen/wiki/InstallNetFlowWithNfSen for information on setting up the permissions properly.  One word of warning:  the document is incorrect, the groupname should be called 'nfsenadmin', not 'nagios'.
    * for Ubuntu you need to use the 'www-data' user instead of 'wwwrun'.
  * PortTracker which is one of the example "plugins" which is provided with NFSEN, does not use the actual plugin framework.  It requires that you recompile nfdump from source code into a special binary, nftrack, that must run as a process outside of NFSEN.  Not ideal!
  * In order to use an existing set of static data and replay it through the NFSEN environment you must set up a simulation.  This is fine... except for:
    * All alerts are lost each time you restart your simulation
    * All profiles are lost each time you restart your simulation
> > This makes it very difficult to truly work with a static set of data when building a test environment.  The only way to get around this is feed it live data streams, which might not be an allowed requirement.
  * DO NOT develop plugins on your production NFSEN system.  Plugins leverage the same comm socket file as the web application itself.  If your plugin breaks the comm socket, it breaks your web application communication.  Doing this on a prod system will bring down your web app abnormally.
> > ![http://nfsen.sourceforge.net/PluginGuide/plugins-comm.png](http://nfsen.sourceforge.net/PluginGuide/plugins-comm.png)