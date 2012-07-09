
# load script functions
FUNCTIONS_DIR=~/.scripts
if [ -d $FUNCTIONS_DIR ]; then
for file in `ls $FUNCTIONS_DIR`
do
. $FUNCTIONS_DIR/$file
done
fi

# load environment variables
if [ -f ~/.bash_variables ]; then
. ~/.bash_variables
fi

# load aliases
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# don't use tab completion on hidden files
bind 'set match-hidden-files off'

##
# Your previous /Users/jklucar/.bash_profile file was backed up as /Users/jklucar/.bash_profile.macports-saved_2011-10-29_at_21:49:36
##

# MacPorts Installer addition on 2011-10-29_at_21:49:36: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

