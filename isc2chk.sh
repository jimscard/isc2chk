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
JQ=$(which jq)    #get location of jq if it's installed.

case "$#" in			# Check how many parameters were supplied
3)				# 3 is the max, they gave the first name too
	fname=$1
	lname=$2
	id=$3
	;; 
2)				# 2 is just the required parms, lname && id
	fname=""
	lname=$1
	id=$2
	;;
*)
	echo Usage: "${0##*/}" [fname] lname ISC2ID
	exit 1
	;;
esac

if [ -z "$JQ" ] ; then   # If $JQ is null, then jq wasn't found so just do the curl command to get the results
curl -d "{\"FirstName\":\"$fname\",\"LastName\":\"$lname\",\"MemberNumber\":\"$id\"}" -H "Content-Type: application/json" -X POST https://www.isc2.org/api/MemberVerification/MemberVerification
else    # $JQ isn't null so it contains the location of jq. So we run the output through it to pretty print.
curl -d "{\"FirstName\":\"$fname\",\"LastName\":\"$lname\",\"MemberNumber\":\"$id\"}" -H "Content-Type: application/json" -X POST https://www.isc2.org/api/MemberVerification/MemberVerification | $JQ "."
fi
echo 
