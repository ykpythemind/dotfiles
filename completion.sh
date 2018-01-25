olddir=`pwd`
cd ~/.zprezto/modules/completion/external/src
curl -fLo _docker https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker
curl -fLo _docker-compose https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose
cd $olddir
exec $SHELL -l
