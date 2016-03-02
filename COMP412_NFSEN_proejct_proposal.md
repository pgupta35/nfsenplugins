# Abstract #

Our group, consisting of Erik Decker, Steven Hill and Ken Hebel, will be tackling the [NFSEN Open Source Project](http://nfsen.sourceforge.net).  This program is used by the University Information Security Office (UISO) to investigate anomalous network traffic, forensic investigations and other information security related needs.  The existing system is set up as a [Netflow](http://en.wikipedia.org/wiki/Netflow) collector and repository.  No active processing occurs on this system outside of the base functionality that NFSEN provides.  Instead it is used as a repository to be queried on an as needed basis.  NFSEN contains the ability to use plugins, both front-end (PHP) and back-end (Perl), to automatically monitor and generate alerts on suspicious or anomalous traffic.  This functionality is currently not implemented but highly desired.


We will be investigating and developing plugins for this system to assist the security office in its day-to-day operations of securing Loyola's network.  The plugins written here will be published back out to the community so that others, especially other Universities, can leverage their use.  Additionally, documentation efforts will be undertaken to explain the use of the plugins created, the problems they are solving and any references available for them.


This system was implemented by a UISO student worker between 2008-2009, as part of a class project.  It is invaluable in the UISO's the day to day operations and is a perfect example of student / staff partnerships that help improve the student experience.  The team will leverage the existing [Google Code](http://code.google.com/p/nfsenplugins/) page that was originally developed.

# Network Behavioral Analysis and References #
The ultimate goal of Information Security departments within organizations is to protect the Confidentiality, Integrity and Availability (CIA) of their information resources, data, and people.  It is a broad topic that spans multiple disciplines and business units.

One method Information Security departments achieve these goals is through the  use of systems that monitor and alert on suspicious network traffic.  The most common method includes the use of Intrusion Detection Systems (IDS).  These systems examine packets as they flow over the network and make decisions based on a set of signatures tailored towards packet contents.  This method is good for detecting known malicious traffic but can be easily subverted by slightly altering the pattern that a signature detects.  Additionally, as networks become faster and more data is pushed through ever increasing network pipes it is becoming quickly unreasonable to be able to capture packets for subsequent "deep" analysis.

Network Behavior Analysis (NBA) abstracts the IDS concept and focuses on the behavior of the network traffic itself.  Although all networks are similar in function the behavior of its traffic is different across organizations.  The goal of NBA is to detect anomalous traffic that normally would not occur on a specific network.  In this fashion warnings can be created.  As different warnings are created the aggregation of all warnings allows security professionals to detect malicious activity without the need to dive deep into a packets content.

It is common practice for University information technology departments to leverage Free and Open Source systems in the operations of their duties.  The NFSEN system is used by many organizations and universities alike.  The work done in this project can ultimately be leveraged by all interested parties of the NFSEN system

Ultimately NBA does not replace the need for firewalls, IDS, content management, packet shaping or other network level technologies.  Instead, it augments these technologies, providing more information to time pressed security professionals and enabling them to make quick and accurate decisions towards threats on their networks.


[Details about Bots and Botnets](http://www.sans.org/reading_room/whitepapers/malicious/bots_and_botnet_an_overview_1299)

[Leveraging NFSEN to detect bots and botnets by PSU.EDU](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.126.2471&rep=rep1&type=pdf)

[Using flows to detect intrusions](http://www.ces.net/events/2008/conference/prog/paper/9.pdf)

[Detecting Suspicious Traffic Patterns using SIEM](http://www.sans.org/reading_room/whitepapers/detection/harness_the_power_of_siem_33204)


# Project Details #
The team will be focusing their energies on researching existing bot and botnet network activity and then developing expandable plugins that will read in network traffic in real time to detect "botlike" activity.  This detection process will be automated through the use of PERL and PHP plugins.

The following is a list of botlike characteristics that can be detected via network behavior analysis.  A plugin will be developed for each of these three types.  If additional time is available more plugins will be developed.  Each plugin will consistent of both a back-end collection plugin (using PERL) and a front-end graphing plugin (using PHP) to show trends overtime.

  * Hosts communicating to known command and control servers.  The list can be harvested from security communities, posted via the web or forensic analysis.  The list should not be static, but instead should be modifiable.
  * Systems generating SMTP traffic from their local host, bypassing existing SMTP relay servers.  This plugin should allow for modification of a list of 'authorized mail relays'.  This plugin will detect worms and bots that have compromised PCs to be used for sending out large quantities of SPAM and phishing attacks.
  * Detect a large number of hosts communicating in tandem to IRC servers using known IRC ports.  IRC is a legitimate protocol that has powerful collaborative uses.  However, it is also a popular mechanism for controlling large numbers of bots within a botnet.  The threshold should be adjustable to allow for tuning of this plugin as the environment changes.

Each of the plugins will have a criteria of network traffic to be matched against.  For example, detecting SMTP traffic will be using IP addresses of known mail servers and common SMTP ports (25, 465).  Plugin requirements will be captured on [PluginDetails](PluginDetails.md).


# Action Items #
Below are the list of items in order to accomplish our project goals

  * put together project proposal (Erik, Feb)
  * set up development NFSEN box for plugin development and testing (Erik, Steve, Feb)
    * copy over historical flow data to be used for testing (Erik, Feb)
  * identify types of traffic that would be interesting (Erik, Feb)
  * read up on all bot/botnet materials and become familar with traffic pattern matching (Team, Feb)
  * develop PERL & PHP plugins to identify hosts communicating with C&C servers (Steve, Mar-April)
  * develop PERL & PHP plugins to identify hosts communicating via SMTP to the outside world (Erik, Mar-April)
  * develop PERL & PHP  plugins to detect a large number of hosts communicating to IRC servers, indicative of a 'botlike' activity (Ken, Mar-April).
  * package up development system for class presentation (??, May)
  * finalization of documentation of plugins (Respective plugin developers, May)

If time permits, the following additional tasks will be accomplished to help reduce false-positive rates.
  * develop plugin that keeps track of source hosts triggering the above three traffic patterns.  Each additional "trigger" will lend greater weight for an infection. (Mar-April)
  * enhance existing plugin that can help track the spread of a worm over a network by leveraging hosts triggering the original three plugins. (Mar-April)

# Related Items #
Below are links towards other organizations that have implemented NFSEN.

[Monash University](http://nfsen.its.monash.edu/nfsen/nfsen.php) - They have developed a Port Tracker plugin, keeping statistics on highly used ports within their network.

[University of Maryland](http://www.umaryland.edu/cits/security/security_updates.html)

[Plugin repository on SourceForget.net](http://sourceforge.net/projects/nfsen-plugins/develop)

[NFSEN and NFDUMP user documentation](http://www.first.org/conference/2006/papers/haag-peter-papers.pdf)