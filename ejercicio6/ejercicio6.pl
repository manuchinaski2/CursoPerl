#!/usr/bin/perl -w 

use Net::Fluidinfo;

 # Predefined Fluidinfo client for playing around, points
 # to the sandbox with user test/test
 $fin = Net::Fluidinfo->new_for_testing;
 $fin = Net::Fluidinfo->new_for_testing(trace_http => 1);

 # Fluidinfo client pointing to production
 $fin = Net::Fluidinfo->new(username => 'manu', password => 'lv20032006');

 # Fluidinfo taking credentials from environment variables
 # FLUIDINFO_USERNAME and FLUIDINFO_PASSWORD
 $fin = Net::Fluidinfo->new;

 # Content-MD5 headers with checksums for requests with payload
 $fin = Net::Fluidinfo->new(md5 => 1);

 # Resource getters
 $object     = $fin->get_object_by_id($id, about => 1);
 $object     = $fin->get_object_by_about($about);
 $ns         = $fin->get_namespace($path, description => 1);
 $tag        = $fin->get_tag($path, description => 1);
 $permission = $fin->get_permission($category, $path_or_has_path, $action);
 $user       = $fin->get_user($username);

 # Object search
 @ids = $fin->search("has fxn/rating");
