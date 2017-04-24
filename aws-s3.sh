#!/bin/bash
# Created by Sreeraju.V
# setup AWS CLI first
#  http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html
# configure AWS CLI (e.g. use IAM role for S3 access)
echo "Enter your default region :  us-east-1"
read REGION
echo "Enter your Access key Details :"
read ID
echo "Enter your SEcret access key :"
read KEY
export AWS_DEFAULT_REGION=$REGION
export AWS_ACCESS_KEY_ID=$ID
export AWS_SECRET_ACCESS_KEY=$KEY
options=("ListBucket" "ListPath" "S3Upload" "Quit")
select opt in "${options[@]}"
do
    case $opt in

        "ListBucket")
# To List out all Objects and Folder in Bucket

echo "Enter your Bucket name: "
read Bucket
echo "Listing out all objects and folders in Bucket: $Bucket"
aws s3 ls s3://$Bucket --recursive | awk '{print $4}' | cut -d / -f1 | uniq
         ;;

        "ListPath")
# To List out all Objects in Specified Bucket Path

echo "Enter your Bucket name: "
read Bucket
echo "Enter the Path name: "
read Path
echo "List out 	all objects in Bucket path: $Bucket/$Path"
aws s3 ls s3://$Bucket/$Path --recursive | awk '{print $4}' | cut -d / -f2 | uniq
          ;;

         "S3Upload")
# To upload Specified file
echo "Enter file Location: egs-/root/filname.tar.gz "
read File_Location
echo "Enter Bucket name where file to be uploaded: "
read Bucket
aws s3 cp $File_Location  s3://$S3Bucket/ 
            ;;

        "Quit")
            break
            ;;
   esac
done

