#!/bin/bash

curl -s http://whogoesthere.c2y2jbcu8i.us-west-2.elasticbeanstalk.com/users | egrep -o '\"id\":.*?,\"name' | sed -e 's/^"id"://' -e 's/,"name//' >> user_id_list.txt

while read line
do
  curl -X DELETE http://whogoesthere.c2y2jbcu8i.us-west-2.elasticbeanstalk.com/users/$line
done < user_id_list.txt

rm user_id_list.txt

echo 'Success!!!'
