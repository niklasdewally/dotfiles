NETHOME=/cs$HOME
unlink $NETHOME/.vimrc
unlink $NETHOME/.vim
unlink $NETHOME/.ssh/config
unlink $NETHOME/.gitconfig
unlink $NETHOME/.gnuplot
unlink $NETHOME/bin/* || rm -i $NETHOME/bin/*
unlink $NETHOME/.tmux
