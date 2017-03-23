This tutorial was copied from here: http://neverstopbuilding.com/gitpro and was modified for my needs.

Much support from Joe as well. (https://github.com/joseph-tohdjojo)


1. Create the files you need

	`touch ~/.bash_profile`

	`touch ~/.git-completion.bash`

	`touch ~/.git-prompt.sh`

2. Populate your completion file

	`nano ~/.git-completion.bash`

	In the .git-completion.bash file put the contents located here:

		terminal_config/git-completion.bash


	Update the permissions of the file.

	`[sudo] chmod 755 ~/.git-completion.bash`

3. Populate your prompt file

	`nano ~/.git-prompt.sh`

	In the .git-prompt.sh file, put the contents located here:

		terminal_config/git-prompt.sh

	Update the permissions of the file.

	`[sudo] chmod 755 ~/.git-prompt.sh`

4. Populate your .bash_profile

	`nano ~/.bash_profile`

	In the .bash_profile, put the contents located here:

		terminal_config/.bash_profile


5. Reset your terminal:

	`source ~/.bash_profile`

	Now, you should have a few things going for you:

	Clean looking path prompt.
	Indication of the branch you are on in a Git repository.
	Bad A$$ aliases to make your workflow easier.

### Black Diamond ###

Add snippets to your Atom:

1. Find your Atom snippets file:

	mine is located at `~/.atom/snippets.cson`

2. Populate your snippets file with the following:

	/atom/snippets.cson





# Default location of original files #

	# Bash
	~/.bash_profile

	# Git
	~/.git-completion
	~/.git-prompt

	# Atom
	~/.atom/snippents.cson
