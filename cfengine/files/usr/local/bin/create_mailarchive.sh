!#! /bin/bash

#script to archive maildir of person

#Use:
#create_mailarchive <directory in /home/vmail/home>
#uitvoeren als user vmail.

if [ ! `whoami` == 'vmail' ]
then
        echo "Voer dit script uit als user 'vmail'"
        exit
fi

cd /home/vmail/home

if [ ! -e $1 ]
then
        echo "Gebruik: create_mailarchive <gebruiker>"
        echo "Type 'ls /home/vmail/home' om alle maildirectories te zien"
        echo "parameter is $1" 
        exit 0
fi

if [ ! -d $1 ] 
then
        echo "Deze gebruiker bestaat niet"
        echo "Type 'ls /home/vmail/home' om alle maildirectories te zien"
        exit 0
fi

if [ ! -d  $1/Maildir ]
then    
        echo "Maildir van deze gebruiker bestaat niet!"
        echo "Archivering onmogelijk"
        exit 0
fi

cd $1/Maildir

if [  -e ArchivedMail.tgz ]
then
        echo "Niets te doen"
        echo "Maildirectory is al gearchiveerd"
        exit 0
fi

cd $1/Maildir

echo "Aanmaken archief ArchivedMail.tgz"
tar -zcvf ArchivedMail.tar .*


echo "Verwijderen alle submappen"
find . -type d -exec rm -rf '{}' \;

ls -alh /home/vmail/home/$1/Maildir/
echo "All done."
