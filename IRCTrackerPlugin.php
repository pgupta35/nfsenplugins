<?php

/*
 * Frontend plugin: IRCTrackerPlugin
 *
 * Required functions: IRCTrackerPlugin_ParseInput and IRCTrackerPlugin_Run
 *
 */

/* 
 * IRCTracker_ParseInput is called prior to any output to the web browser 
 * and is intended for the plugin to parse possible form data. This 
 * function is called only, if this plugin is selected in the plugins tab. 
 * If required, this function may set any number of messages as a result 
 * of the argument parsing.
 * The return value is ignored.
 */
function IRCTrackerPlugin_ParseInput( $plugin_id ) {

#	SetMessage('error', "Error set by IRCTracker plugin!");
#	SetMessage('warning', "Warning set by IRCTracker plugin!");
#	SetMessage('alert', "Alert set by IRCTracker plugin!");
	SetMessage('info', "Info set by IRCTracker plugin!");

} // End of IRCTracker_ParseInput


/*
 * This function is called after the header and the navigation bar have 
 * are sent to the browser. It's now up to this function what to display.
 * This function is called only, if this plugin is selected in the plugins tab
 * Its return value is ignored.
 */
function IRCTrackerPlugin_Run( $plugin_id ) {

	print "<h3>This plugin demostrates clients that are communicating over IRC at a specific point in time.  A large number of hosts would be indicative a bot net communicating via IRC.  In this case, the traffic appears normal</h3>\n";

	// the command to be executed in the backend plugin
	$command = 'IRCTrackerPlugin::try';

	// call command in backened plugin
	$out_list = nfsend_query($command, $opts);

	// get result
    if ( !is_array($out_list) ) {
        SetMessage('error', "Error calling backend plugin");
        return FALSE;
    }
#	$string = $out_list['string'];
#	print "Backend reported: <b>$string</b><br>\n";
	
	$output = $out_list['output'];
	echo "<pre>";
	print_r ($output);
	echo "</pre>";

} // End of IRCTrackerPlugin_Run


?>
