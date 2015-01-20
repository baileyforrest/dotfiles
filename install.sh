#!/bin/bash

CONFIG=".config"
ignore=( backup install.sh $CONFIG .git .gitignore .. . )

# DIR = directory of this script
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )



# Handle home dotfiles
cd $DIR
for filename in .*
do
    # check if the file should be ignored
    shouldIgnore=false
    for ignorename in ${ignore[@]}
    do
        if [[ $filename == $ignorename ]]
        then
            shouldIgnore=true
        fi
    done

    # if you shouldn't ignore, and it's not already linked
    if [ $shouldIgnore == false -a ! -L $HOME/$filename ]
    then

        # move old versions moved to backup dir
        if [ -e $HOME/$filename ]
        then
            echo ${filename} moved to ${DIR}/backups/${filename}
            mv $HOME/$filename $DIR/backups/
        fi

        # create the link
        echo new link $HOME/${filename} to ${DIR}/${filename}
        ln -s $DIR/$filename $HOME/$filename
    fi
done

# Handle .config dotfiles
cd $DIR/$CONFIG
if [ ! -d "$HOME/$CONFIG" ]; then
    mkdir "$HOME/$CONFIG"
fi

for filename in .*
do
    # If it's not already linked
    if [ ! -L $HOME/$CONFIG/$filename ]
    then

        # move old versions moved to backup dir
        if [ -e $HOME/$CONFIG/$filename ]
        then
            echo ${filename} moved to ${DIR}/backups/$CONFIG/${filename}
            mv $HOME/$filename $DIR/backups/$CONFIG
        fi

        # create the link
        echo new link $HOME/$CONFIG/${filename} to ${DIR}/$CONFIG/${filename}
        ln -s $DIR/$CONFIG/$filename $HOME/$CONFIG/$filename
    fi
done
