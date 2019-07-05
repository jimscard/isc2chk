#!/bin/bash
# ---isc2chk.sh
# Script takes person's name and (ISC)2 ID number and checks their status
# using the (ISC)2 Member verification page. The results aren't formatted, but
# contains their name and an array of certifications that they have. If the 
# person hasn't been verified yet, the certification array will be empty.
# if it's available, the output is run through jq to pretty it up a bit.
#
# Based on the curl command provided by u/AsterisK86 in a post on Reddit: 
#         https://www.reddit.com/r/cissp/comments/bzbpqr/cissp_endorsement_curl_postman_request/
#
# Script by Jim Scardelis u/jimscard
#
