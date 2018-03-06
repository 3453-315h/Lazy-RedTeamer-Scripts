#/bin/bash
#CloudFront Domain Fronting Finder
#LazyAuthor: r0lan Ye Yint @yeyint_mth
#Kudos to Vincent Yiu @vysecurity for his research https://www.mdsec.co.uk/2017/02/domain-fronting-via-cloudfront-alternate-domains/ and Cloudfront domain list, download here https://github.com/vysec/DomainFrontingLists
banner=$(echo "CloudFront Domain Frontable Finder v0.1 - LazyAuthor: r0lan")
if [ $# -eq 0 ]
  then
    echo $banner
    echo -e "\nUsage: df_finder.sh yourdomain.cloudfront.net cloudfront-domains.txt\n"
    exit 0
fi
echo "$banner"
echo -e "\nFinding AWS frontable.....\n"
for i in {a..z};
        do for j in {0..9};
                do
                aws=$(wget -q -O - -U test http://$i$j.awsstatic.com/t3st.txt --header "Host: $1")
                echo $i$j.awsstatic.com: $aws;
        done;
done
echo ".........................................."
domainlist=$2
IFS=$'\n'
echo "\nFinding High Reputation Frontable....\n"
for next in `cat $domainlist`
        do
                aws=$(wget -q -O - -U test http://$next/t3st.txt --header "Host: $1")
        echo $next: $aws;
done
