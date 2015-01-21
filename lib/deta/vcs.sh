#
# deta
#
# Copyright (c) 2011-2014 David Persson
#
# Distributed under the terms of the MIT License.
# Redistributions of files must retain the above copyright notice.
#
# @COPYRIGHT 2011-2014 David Persson <nperson@gmx.de>
# @LICENSE   http://www.opensource.org/licenses/mit-license.php The MIT License
# @LINK      http://github.com/davidpersson/deta
#

msginfo "Module %s loaded." "vcs"

# @FUNCTION: vcs_clear
# @USAGE: <directory>
# @DESCRIPTION:
# Forcefully removes any directories and files needed by version control
# systems like SVN and GIT.
vcs_clear() {
	msg "Removing any VCS traces from directory %s." $1
	find $1 -type d -name .svn    | xargs rm -r
	find $1 -type d -name .git    | xargs rm -r
	find $1 -type f -name '.git*' | xargs rm
}

# @FUNCTION: git_current_branch
# @DESCRIPTION:
# Retrieves the current branch name.
function git_current_branch() {
	git rev-parse --abbrev-ref HEAD
}

# @FUNCTION: git_rev_for
# @USAGE: <TREE-ISH>
# @DESCRIPTION:
# Retrieves the revision for a given tag or i.e. HEAD.
function git_rev_for() {
	git rev-parse --short $1
}

# @FUNCTION: git_has
# @USAGE: <TREE-ISH>
# @DESCRIPTION:
# Checks if a given tag or other tree-ish exists.
function git_has() {
	git rev-list $1 &> /dev/null

	if [[ "$?" != "0" ]]; then
		echo -n "n"
	else
		echo -n "y"
	fi
}

# @FUNCTION: git_first_commit
# @DESCRIPTION:
# Retrieves the revision of the very first commit.
function git_first_commit() {
	git log --format=%H | tail -1
}
