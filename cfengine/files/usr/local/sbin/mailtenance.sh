## Not useful any more after migration to gmail?

exit 0;

##
# this file is managed by cfengine
#


#! /bin/bash
#scriptje met als doelen:
#de map .Spam van elke user door sa-learn te laten inspecteren.
#en daarna mail die ouder is dan 30 dagen te verwijderen
#
#
#verwijderen van mail ouder dan 60 dagen van de m4n-backupmail user bcc
#
#verwijderen van bestanden die ouder zijn dan 30 dagen uit alle .Trash


PWD="/home/vmail/home/"
spam="Maildir/.Spam"
trash="Maildir/.Trash"
cd $PWD

for user in  *
do
        if [ -e $PWD/$user/$spam/ ]; then
                sa-learn --mbox --spam --progress $PWD/$user/$spam/cur
                rm $PWD/$user/$spam/cur/* 2> /dev/null
                sa-learn --mbox --spam --progress $PWD/$user/$spam/new
                 rm $PWD/$user/$spam/new/* 2> /dev/null
                find $PWD/$user/$trash/cur/* -mtime +30 -delete

        fi
done

if [ -e $PWD/bcc/Maildir ]; then
                find  $PWD/bcc/Maildir/ -type f -mtime +60 -delete
fi

#Verwijderen van mail ouder dan 60 dagen uit mailboxes
#bcc@m4n.nl, bccmbuyu@m4n.nl,m4n-bounces@m4n.nl
find $PWD/bcc/Maildir/ -mtime +60 -delete
find $PWD/bccmbuyu.nl/Maildir -mtime +60 -delete
find $PWD/m4nbounces/Maildir -mtime +60 delete