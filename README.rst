DOT.VIM
=======

Simple Management for my vim configs.

Use plug.vim and require.vim to make life easier.

Install
~~~~~~~


    git clone https://github.com/gu-fan/dot.vim.git ~/.dot.vim/

    echo "so ~/.dot.vim/index.vim" > ~/.vimrc


start vim, after curl get ``plug.vim``

use ``PlugInstall`` to install all plugins


Usage
~~~~~

This is my vim config file, but you can use it as a start place for your own configuration

Config
~~~~~~

configs are in ``config/`` folder, change it by your own

    ``<leader>`` key is ``<SPACE>``

    ``<leader>vv`` to edit ``index.vim``

Plugins
~~~~~~~


plugin are all in ``package.vim`` and ``package/`` folder, you can check them and change by your own.


includes following plugin but may update in future:


    ui: 
        colorv.vim
            :ColorV to pick a color
        galaxy.vim
            :Galaxy to change your scheme

    history:
        gundo.vim
            infinite undo
        lastbuf.vim
            <C-W>z to open last closed buffer
        vim-obsession
            :load
            :save
            :restart
            with current session (XXX: it's buggy of vim sourcing, currently)

    search:
        ag.vim
            :se     search

    complete:
        neosnippet
            <leader>se to add new snippet for current file
            ino_<c-k> to invoke snippet
        neocomplcache
        tcomment_vim
            <leader>cc to toggle comment

    document:
        riv.vim
            for rst document and wiki
    file:
        nerdtree
            <F4> to open file tree
        ctrlp.vim
            <ctrl-p> to fuzzy open file
    git:
        fugitive
            <leader>gc commit
            <leader>gs status
            <leader>gp push
            <leader>gP pull
        gitgutter
    mapping:
        easymotion
            f/F/t for quick move


    filetype/html
        vim-stylus
        vim-graphql
        yats
        vim-less

    
NOTE
~~~~

Still need polish, contributions (PR) are welcome.

thanks.


License
~~~~~~~

Use it by your own.
=======

    echo "so ~/.dot.vim/index.vim" > ~/.vimrc


start vim , after curl get ``plug.vim``

    use ``PlugInstall`` to install all plugins



Usage
~~~~~


This is my vim config file, but you can use it as a start place for your own configuration

