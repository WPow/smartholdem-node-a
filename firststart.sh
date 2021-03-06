forever stop app.js >&- 2>&-
echo 'Getting last snapshot for' $USER
wget http://snapshots.smartholdem.io/snapshot
dropdb sth_smartholdem
createdb -E UTF8 -T template0 --lc-collate=en_US.UTF-8 --lc-ctype=en_US.utf8 sth_smartholdem
echo 'DB recreate!'
echo 'Loading Full BlockChain, please wait..'
pg_restore --no-acl --role=$USER -d sth_smartholdem snapshot >&- 2>&-
echo 'Success!'
rm snapshot
forever start app.js --config config.json --genesis genesisBlock.json >&- 2>&-
rm ./logs/sth.log
touch ./logs/sth.log
tail -f ./logs/sth.log
