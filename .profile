# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi


if [ -s ~/.bashrc ]; then
    source ~/.bashrc;
fi

export PATH="./:$PATH"
source ~/.bashrc
VULKAN_SDK="/home/spounka/Documents/Libraries/vulkan/1.1.101.0/x86_64"
export PATH=$PATH:$VULKAN_SDK
LD_LIBRARY_PATH="/home/spounka/Documents/Libraries/vulkan/1.1.101.0/x86_64/lib"
export PATH=$PATH:$LD_LIBRARY_PATH
VK_LAYER_PATH="/home/spounka/Documents/Libraries/vulkan/1.1.101.0/x86_64/etc/explicit_layer.d"
export PATH=$PATH:$VK_LAYER_PATH

