This tutorial was copied from here: http://neverstopbuilding.com/gitpro and was
modified for my needs.

Much support from Joe as well. (https://github.com/joseph-tohdjojo)

1. If you are a Mac/Linux user, copy the following into your terminal to create your bash profile and load in
   necessary files. You may have to provide your computer password to provide
   required permissions.

```
curl -s https://raw.githubusercontent.com/SheaClose/config_files/master/terminal_config/.bash_profile > ~/.bash_profile && curl -s https://raw.githubusercontent.com/SheaClose/config_files/master/terminal_config/git-completion.bash > ~/.git-completion.bash && curl -s https://raw.githubusercontent.com/SheaClose/config_files/master/terminal_config/git-prompt.sh > ~/.git-prompt.sh && sudo chmod 755 ~/.git-completion.bash ~/.git-prompt.sh && source ~/.bash_profile
```

1. If you are a Windows user, you can paste in the following:

```
curl -s https://raw.githubusercontent.com/SheaClose/config_files/master/terminal_config/.bash_profile(windows) > ~/.bash_profile && source ~/.bash_profile
```

Now, you should have a few things going for you:

Clean looking path prompt. Indication of the branch you are on in a Git
repository. Bad A$$ aliases to make your workflow easier.

### Black Diamond

Add snippets to your Atom:

```
curl -s https://raw.githubusercontent.com/SheaClose/config_files/master/atom/snippets.cson > ~/.atom/snippets.cson
```

Add snippets to your VSCode

```
curl -s https://raw.githubusercontent.com/SheaClose/config_files/master/code/jsSnippets.json > /Users/$USER/Library/Application Support/Code/User/snippets/javascript.json
```
